/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package model;
import java.util.Date;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author Vuong Bach
 */


public class User {
    private int userID;
    private String fullName;
    private String email;
    private String passwordHash;
    private byte role; // 1=User, 2=Instructor, 3=Admin
    private Date registerDate;
    
    private List<Course> courses;
    private List<Enrollment> enrollments;
    private List<Payment> payments;
    private List<Review> reviews;

    public User() {
        this.registerDate = new Date();
        this.role = 1;
        this.courses = new ArrayList<>();
        this.enrollments = new ArrayList<>();
        this.payments = new ArrayList<>();
        this.reviews = new ArrayList<>();
    }

    public User( String fullName, String email, String passwordHash, byte role, Date registerDate) {
        
        this.fullName = fullName;
        this.email = email;
        this.passwordHash = passwordHash;
        this.role = role;
        this.registerDate = registerDate;
      
    }
    
     public User(int userID, String fullName, String email, byte role) {
         this.userID=userID;
        this.fullName = fullName;
        this.email = email;
        
        this.role = role;
       
      
    }
     public User(int userID, String fullName, String email, String passwordHash, byte role, Date registerDate) {
        this.userID=userID;
        this.fullName = fullName;
        this.email = email;
        this.passwordHash = passwordHash;
        this.role = role;
        this.registerDate = registerDate;
      
    }
    

    public User( String fullName, String email, String passwordHash, byte role, Date registerDate, List<Course> courses, List<Enrollment> enrollments, List<Payment> payments, List<Review> reviews) {
        
        this.fullName = fullName;
        this.email = email;
        this.passwordHash = passwordHash;
        this.role = role;
        this.registerDate = registerDate;
        this.courses = courses;
        this.enrollments = enrollments;
        this.payments = payments;
        this.reviews = reviews;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public byte getRole() {
        return role;
    }

    public void setRole(byte role) {
        this.role = role;
    }

    public Date getRegisterDate() {
        return registerDate;
    }

    public void setRegisterDate(Date registerDate) {
        this.registerDate = registerDate;
    }

    public List<Course> getCourses() {
        return courses;
    }

    public void setCourses(List<Course> courses) {
        this.courses = courses;
    }

    public List<Enrollment> getEnrollments() {
        return enrollments;
    }

    public void setEnrollments(List<Enrollment> enrollments) {
        this.enrollments = enrollments;
    }

    public List<Payment> getPayments() {
        return payments;
    }

    public void setPayments(List<Payment> payments) {
        this.payments = payments;
    }

    public List<Review> getReviews() {
        return reviews;
    }

    public void setReviews(List<Review> reviews) {
        this.reviews = reviews;
    }
    

   
}

