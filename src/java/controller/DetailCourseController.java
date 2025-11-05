package controller;

import dal.CourseDAO;
import dal.EnrollmentDAO;
import dal.LessonDAO;
import dao.ReviewDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Course;
import model.Lesson;
import model.Review;
import model.User;

@WebServlet(name = "DetailCourseController", urlPatterns = {"/DetailCourseController"})
public class DetailCourseController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));

            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            EnrollmentDAO enrollDAO = new EnrollmentDAO();
            boolean isEnrolled = false;

            // Kiểm tra xem user đã đăng nhập VÀ đã đăng ký khóa học chưa
            if (user != null) {
                isEnrolled = enrollDAO.isEnrolled(user.getUserID(), id);
            }

            // Lấy thông tin khóa học
            CourseDAO cdao = new CourseDAO();
            Course course = cdao.findCourseById(id);
            request.setAttribute("course", course);

            // Lấy danh sách review (AI CŨNG XEM ĐƯỢC)
            ReviewDAO rdao = new ReviewDAO();
            List<Review> listReviews = rdao.getReviewsByCourseID(id);
            request.setAttribute("listReviews", listReviews);

            // Nếu admin thì luôn được xem bài học
            byte role = (user != null) ? user.getRole() : 1;
            if (role == 3) {
                isEnrolled = true;
            }

            if (isEnrolled) {
                // ĐÃ MUA: lấy danh sách bài học và qua lesson.jsp
                LessonDAO lessonDAO = new LessonDAO();
                List<Lesson> listLessons = lessonDAO.getLessonsByCourseID(id);
                request.setAttribute("listLessons", listLessons);

                // Giữ luôn listReviews để hiển thị phần đánh giá ở cuối video
                request.getRequestDispatcher("lesson.jsp").forward(request, response);

            } else {
                // CHƯA MUA: chỉ hiển thị thông tin + review
                request.getRequestDispatcher("detail.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Chi tiết khóa học (hiển thị review cho cả người mua và chưa mua)";
    }
}
