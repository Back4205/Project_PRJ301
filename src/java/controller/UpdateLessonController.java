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
import model.Lesson;

/**
 *
 * @author Vuong Bach
 */
@WebServlet(name = "UpdateLessonController", urlPatterns = {"/UpdateLessonController"})
public class UpdateLessonController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String lessonID_raw = request.getParameter("lessonID");
        try {
            int lessonID = Integer.parseInt(lessonID_raw);
            LessonDAO dao = new LessonDAO();
            Lesson lesson = dao.getLessonById(lessonID);
            request.setAttribute("lesson", lesson);
            request.getRequestDispatcher("updateLesson.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String lessonID_raw = request.getParameter("lessonID");
        String title = request.getParameter("title");
        String videoURL = request.getParameter("videoURL");
        String courseID_raw = request.getParameter("courseID");

        try {
            int lessonID = Integer.parseInt(lessonID_raw);
            int courseID = Integer.parseInt(courseID_raw);

            LessonDAO dao = new LessonDAO();
            dao.updateLesson(lessonID, title, videoURL);

            response.sendRedirect("UpdateCourseController?uid=" + courseID);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
