/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package model;

/**
 *
 * @author Vuong Bach
 */
public class Lesson {
    private int lessonID;
    private Course course;
    private String title;
    private String videoURL;
  

    public Lesson() {
    }

    public Lesson(int lessonID, Course course, String title, String videoURL) {
        this.lessonID = lessonID;
        this.course = course;
        this.title = title;
        this.videoURL = videoURL;
        
    }

    public int getLessonID() {
        return lessonID;
    }

    public void setLessonID(int lessonID) {
        this.lessonID = lessonID;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getVideoURL() {
        return videoURL;
    }

    public void setVideoURL(String videoURL) {
        this.videoURL = videoURL;
    }

   
    }
    

   

