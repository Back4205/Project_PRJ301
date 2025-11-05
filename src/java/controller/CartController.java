package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Course;
import dal.CourseDAO;
import dal.EnrollmentDAO;
import dal.EnrollmentDAO;

@WebServlet(name = "CartController", urlPatterns = {"/CartController"})
public class CartController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        List<Course> cart = (List<Course>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        request.setAttribute("cart", cart);
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        List<Course> cart = (List<Course>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        String action = request.getParameter("action");
        String courseID = request.getParameter("courseID");
        Integer userID = (Integer) session.getAttribute("userID");
        CourseDAO courseDAO = new CourseDAO();
        EnrollmentDAO enrollmentDAO = new EnrollmentDAO();

        switch (action) {
            case "add": {
                try {
                    int id = Integer.parseInt(courseID);
                    Course course = courseDAO.findCourseById(id);

                    boolean exists = false;
                    for (Course c : cart) {
                        if (c.getCourseID() == id) {
                            exists = true;
                            break;
                        }
                    }

                    if (!exists && course != null) {
                        cart.add(course);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;
            }

            case "remove":
                for (int i = 0; i < cart.size(); i++) {
                    Course c = cart.get(i);

                    if (String.valueOf(c.getCourseID()).equals(courseID)) {
                        cart.remove(i); // xóa phần tử khỏi list
                        break;
                    }
                }

                break;

            case "clear":
                cart.clear();
                break;

            case "buy": {
                try {
                    int id = Integer.parseInt(courseID);
                    Course course = courseDAO.findCourseById(id);

                    if (course != null && userID != null) {
                        enrollmentDAO.addEnrollment(userID, id);
                        for (int i = 0; i < cart.size(); i++) {
                            Course c = cart.get(i);
                            if (c.getCourseID() == id) {
                                cart.remove(i);
                                break; 
                            }
                        }

                        session.setAttribute("message", "Bạn đã đăng ký khóa học thành công!");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    session.setAttribute("message", "Có lỗi khi mua khóa học!");
                }
                break;
            }

            case "buyAll": {
                if (!cart.isEmpty() && userID != null) {
                    try {
                        for (Course c : cart) {
                            enrollmentDAO.addEnrollment(userID, c.getCourseID());
                        }
                        cart.clear();
                        session.setAttribute("message", "Bạn đã mua thành công tất cả khóa học!");
                    } catch (Exception e) {
                        e.printStackTrace();
                        session.setAttribute("message", "Có lỗi khi thanh toán tất cả!");
                    }
                } else {
                    session.setAttribute("message", "Giỏ hàng trống hoặc chưa đăng nhập!");
                }
                break;
            }
        }

        session.setAttribute("cart", cart);
        response.sendRedirect("cart.jsp");
    }
}
