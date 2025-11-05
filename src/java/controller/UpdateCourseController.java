/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.CourseDAO;
import dal.LessonDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Course;
import model.Lesson;
import model.User;

/**
 *
 * @author Vuong Bach
 */
@WebServlet(name="UpdateCourseController", urlPatterns={"/UpdateCourseController"})
public class UpdateCourseController extends HttpServlet {
   
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
            out.println("<title>Servlet UpdateCourseController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateCourseController at " + request.getContextPath () + "</h1>");
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

    CourseDAO courseDAO = new CourseDAO();
    LessonDAO lessonDAO = new LessonDAO();

    String pId = request.getParameter("uid");
    int id = Integer.parseInt(pId);

    try {
        Course p = courseDAO.findCourseById(id);
        List<Lesson> lessons = lessonDAO.getLessonsByCourseID(id);

        request.setAttribute("p", p);
        request.setAttribute("lessons", lessons); // ✅ thêm dòng này

        request.getRequestDispatcher("updateCourse.jsp").forward(request, response);
    } catch (Exception ex) {
        ex.printStackTrace();
        response.sendRedirect("error.jsp");
    }
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
    request.setCharacterEncoding("UTF-8");

    String id_raw = request.getParameter("ID");
    String title  = request.getParameter("title");
    String description = request.getParameter("description");
    String price_raw  = request.getParameter("price");
    String category_raw = request.getParameter("category");
    String thumbnail = request.getParameter("thumbnail"); // thêm dòng này

    try {
        int id = Integer.parseInt(id_raw);
        double price = Double.parseDouble(price_raw);
        int category = Integer.parseInt(category_raw);

        CourseDAO dao = new CourseDAO();
        Course oldCourse = dao.findCourseById(id);

        // nếu thumbnail mới rỗng → giữ lại ảnh cũ
        if (thumbnail == null || thumbnail.isEmpty()) {
            thumbnail = oldCourse.getThumbnailURL();
        }

        Course c = new Course(id, title, description, price, oldCourse.getAdmin(), category, thumbnail, oldCourse.getCreateDate());
        dao.updateCourse(c);

        response.sendRedirect("ListCourseController");
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("error", "Cập nhật thất bại: " + e.getMessage());
        request.getRequestDispatcher("updateCourse.jsp").forward(request, response);
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
