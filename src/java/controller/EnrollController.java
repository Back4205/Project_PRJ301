/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.EnrollmentDAO;
import dal.PaymentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author Vuong Bach
 */
@WebServlet(name="EnrollController", urlPatterns={"/EnrollController"})
public class EnrollController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EnrollController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EnrollController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
   @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            // 1. Kiểm tra đăng nhập
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            int courseID = Integer.parseInt(request.getParameter("courseID"));
            double price = Double.parseDouble(request.getParameter("price"));
            int userID = user.getUserID();

            EnrollmentDAO enrollDAO = new EnrollmentDAO();
            PaymentDAO paymentDAO = new PaymentDAO();

            // 2. Nếu đã đăng ký rồi, chuyển thẳng đến trang chi tiết khóa học
            if (enrollDAO.isEnrolled(userID, courseID)) {
                response.sendRedirect("DetailCourseController?id=" + courseID);
                return;
            }

            // 3. Xử lý thanh toán (giả lập)
            boolean paymentSuccess = true;
            if (price > 0) {
                // Giả lập thanh toán bằng Momo (ở đây chỉ thêm vào DB)
                paymentSuccess = paymentDAO.addPayment(userID, courseID, price, "Momo");
            }

            // 4. Nếu thanh toán thành công → thêm Enrollment
            if (paymentSuccess) {
                boolean enrollSuccess = enrollDAO.addEnrollment(userID, courseID);
                if (enrollSuccess) {
                    // Chuyển sang trang học
                    response.sendRedirect("DetailCourseController?id=" + courseID);
                } else {
                    response.sendRedirect("error.jsp?msg=EnrollmentFailed");
                }
            } else {
                response.sendRedirect("error.jsp?msg=PaymentFailed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
