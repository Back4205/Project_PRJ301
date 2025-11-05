/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package model;
import java.util.Date;
/**
 *
 * @author Vuong Bach
 */


public class Enrollment {
    private int enrollmentID;
    private User user;
    private Course course;
    private Date enrollDate;
    private double progress;

    public Enrollment() {
        this.enrollDate = new Date();
        this.progress = 0.0;
    }

    public Enrollment(int enrollmentID, User user, Course course, Date enrollDate, double progress) {
        this.enrollmentID = enrollmentID;
        this.user = user;
        this.course = course;
        this.enrollDate = enrollDate;
        this.progress = progress;
    }

    public int getEnrollmentID() {
        return enrollmentID;
    }

    public void setEnrollmentID(int enrollmentID) {
        this.enrollmentID = enrollmentID;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public Date getEnrollDate() {
        return enrollDate;
    }

    public void setEnrollDate(Date enrollDate) {
        this.enrollDate = enrollDate;
    }

    public double getProgress() {
        return progress;
    }

    public void setProgress(double progress) {
        this.progress = progress;
    }
    
   
}
