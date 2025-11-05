package controller;

import dao.ReviewDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Course;
import model.Review;
import model.User;

@WebServlet(name = "AddReviewController", urlPatterns = {"/AddReviewController"})
public class AddReviewController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String courseIDParam = request.getParameter("courseID");
        String ratingParam = request.getParameter("rating");
        String comment = request.getParameter("comment");

        try {
            int courseID = Integer.parseInt(courseIDParam);
            int rating = Integer.parseInt(ratingParam);

            // Kiểm tra đăng nhập
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            User user = (User) session.getAttribute("user");

            // Tạo đối tượng Review
            Course course = new Course();
            course.setCourseID(courseID);

            Review review = new Review();
            review.setCourse(course);
            review.setUser(user);
            review.setRating(rating);
            review.setComment(comment);

            // Gọi DAO để insert
            ReviewDAO dao = new ReviewDAO();
            boolean check = dao.insertReview(review);

            if (check) {
                // Sau khi thêm review thành công → quay lại DetailCourseController
                response.sendRedirect("DetailCourseController?id=" + courseID);
            } else {
                response.sendRedirect("error.jsp?msg=InsertFailed");
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("DetailCourseController?id=" + courseIDParam + "&error=InputInvalid");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?msg=UnexpectedError");
        }
    }
}
