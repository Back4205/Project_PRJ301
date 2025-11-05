/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import constant.MessageConstant;
import dto.Reponse;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import service.UserService;

/**
 *
 * @author Vuong Bach
 */
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        UserService userService = new UserService();
        Reponse<User> userReponse = userService.checkLogin(email, password);
        // nếu đăng nhập  thanh công 
        if (userReponse.isSuccess()) {
            // tạp phiên đăeng nhập 
            HttpSession session = request.getSession();
            User user = userReponse.getData();
            // Lưu thông tin user vào session
            session.setAttribute("session_Login", email);
            session.setAttribute("fullname", user.getFullName());
            session.setAttribute("role", user.getRole());
            session.setAttribute("user", user);
            session.setAttribute("userID", user.getUserID());
            // tao moi session 
            session.setAttribute("session_Login", email);
            if (rememberMe != null) {
                // tao cookie vaf gawsn data can luu vao cookie 
                Cookie emailCookie = new Cookie("COOKIE_EMAIl", email);
                Cookie passwordCookie = new Cookie("COOKIE_PASSWORD", password);

                // set thoi gian ton tai cho cookie 
                emailCookie.setMaxAge(60 * 60 * 24);
                passwordCookie.setMaxAge(60 * 60 * 24);

                // them cookie vao reponse de reponse luu cookie vao trinh duyet 
                response.addCookie(emailCookie);
                response.addCookie(passwordCookie);
            } else {
                Cookie[] cookies = request.getCookies();
                if (cookies != null) {
                    for (Cookie cookie : cookies) {
                        if (cookie.getName().equals("COOKIE_EMAIl")) {
                            cookie.setMaxAge(0);
                            response.addCookie(cookie);
                        }
                        if (cookie.getName().equals("COOKIE_PASSWORD")) {
                            cookie.setMaxAge(0);
                            response.addCookie(cookie);
                        }
                    }
                }
            }
            String fullname = user.getFullName();
            session.setAttribute("fullname", fullname);

            byte role = user.getRole();
            session.setAttribute("role", role);
            if (role == 1) {

                // request.getRequestDispatcher("home.jsp").forward(request, response);
                response.sendRedirect("HomeController");
            }
            if (role == 3) {

                // request.getRequestDispatcher("homeAdmin.jsp").forward(request, response);
                response.sendRedirect("HomeController");
            }

        } else {
            request.setAttribute("error", MessageConstant.LOGIN_FAILED);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
