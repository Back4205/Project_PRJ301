/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dal.CourseDAO;
import java.util.List;
import model.Course;
import model.User;

/**
 *
 * @author Vuong Bach
 */
public class CourseService {

    CourseDAO courseDAO;

    public CourseService() {
        courseDAO = new CourseDAO();
    }

    public List<Course> getAllCourse() {
        return courseDAO.listcourseandNumberSell();
    }

   

}
