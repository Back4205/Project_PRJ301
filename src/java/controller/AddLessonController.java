/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.LessonDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Vuong Bach
 */
@WebServlet(name="AddLessonController", urlPatterns={"/AddLessonController"})
public class AddLessonController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String courseID = request.getParameter("courseID");
        request.setAttribute("courseID", courseID);
        request.getRequestDispatcher("addLesson.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String courseID_raw = request.getParameter("courseID");
        String title = request.getParameter("title");
        String videoURL = request.getParameter("videoURL");

        try {
            int courseID = Integer.parseInt(courseID_raw);
            LessonDAO dao = new LessonDAO();
            dao.insertLesson(courseID, title, videoURL);

            response.sendRedirect("UpdateCourseController?uid=" + courseID);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

