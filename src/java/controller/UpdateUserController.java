/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.CourseDAO;
import dal.EnrollmentDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import model.Course;
import model.User;

/**
 *
 * @author Vuong Bach
 */
@WebServlet(name="UpdateUserController", urlPatterns={"/UpdateUserController"})
public class UpdateUserController extends HttpServlet {
   
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
            out.println("<title>Servlet UpdateUserController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateUserController at " + request.getContextPath () + "</h1>");
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
    

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
  @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO dAO = new UserDAO();
        String pId = request.getParameter("uid");
        int id = Integer.parseInt(pId);

        try {
            User p = dAO.findUserById(id);
            request.setAttribute("p", p);
            request.getRequestDispatcher("updateUser.jsp").forward(request, response);

        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String id_raw = request.getParameter("ID");
        String fullname = request.getParameter("fname");
        String email = request.getParameter("email");
        String role_raw = request.getParameter("role");

        try {
            int id = Integer.parseInt(id_raw);
            byte role = Byte.parseByte(role_raw);

            UserDAO userDAO = new UserDAO();
            EnrollmentDAO enrollDAO = new EnrollmentDAO();

            // 1. Update user info
            User u = new User(id, fullname, email, role);
            userDAO.updateUser(u);

            // 2. If role = Admin (3) auto enroll all courses
            if (role == 3) {
                enrollDAO.enrollAllCoursesForAdmin(id);
            }

            // 3. If the person updated is currently logged in -> update session
            HttpSession session = request.getSession(false);
            if (session != null) {
                User currentUser = (User) session.getAttribute("user");
                if (currentUser != null && currentUser.getUserID() == id) {
                    // reload user from DB
                    User updatedUser = userDAO.findUserById(id);
                    session.setAttribute("user", updatedUser);
                }
            }

            // 4. Redirect
            response.sendRedirect("ListUserController");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Cập nhật thất bại: " + e.getMessage());
            request.getRequestDispatcher("updateUser.jsp").forward(request, response);
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
