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


public class Course {
    private int courseID;
    private String title;
    private String description;
    private double price;
    private int admin;
    private int category;
    private String thumbnailURL;
  private Date createDate;
  private int semester;
private String categoryName;
private int number ;
    
    private List<Lesson> lessons;
    private List<Enrollment> enrollments;
    private List<Payment> payments;
    private List<Review> reviews;

    public Course(int courseID, String title, String description, double price, int category, String thumbnailURL, String categoryName, int semester) {
        this.courseID = courseID;
        this.title = title;
        this.description = description;
        this.price = price;
        
        this.category = category;
        this.thumbnailURL = thumbnailURL;
       
        this.semester = semester;
        this.categoryName = categoryName;
        
    }
    

    public Course() {
        
        this.lessons = new ArrayList<>();
        this.enrollments = new ArrayList<>();
        this.payments = new ArrayList<>();
        this.reviews = new ArrayList<>();
    }
    public Course( String title, String description, double price, int admin, int category, String thumbnailURL, Date createDate) {
    
        this.title = title;
        this.description = description;
        this.price = price;
        this.admin = admin;
        this.category = category;
        this.thumbnailURL = thumbnailURL;
        this.createDate = createDate;
     
    }

    public Course(int courseID, String title, String description, double price, int admin, int category, String thumbnailURL, Date createDate) {
        this.courseID = courseID;
        this.title = title;
        this.description = description;
        this.price = price;
        this.admin = admin;
        this.category = category;
        this.thumbnailURL = thumbnailURL;
        this.createDate = createDate;
     
    }
     public Course(int courseID, String title, String description, double price, int admin, int category, String thumbnailURL, Date createDate,int number) {
        this.courseID = courseID;
        this.title = title;
        this.description = description;
        this.price = price;
        this.admin = admin;
        this.category = category;
        this.thumbnailURL = thumbnailURL;
        this.createDate = createDate;
        this.number=number;
     
    }
    public Course(int courseID, String title, String description, double price, int category) {
        this.courseID = courseID;
        this.title = title;
        this.description = description;
        this.price = price;
       
        this.category = category;
      
     
    }

  


    public int getCourseID() {
        return courseID;
    }

    public void setCourseID(int courseID) {
        this.courseID = courseID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getCategory() {
        return category;
    }

    public void setCategory(int category) {
        this.category = category;
    }


   

    public String getThumbnailURL() {
        return thumbnailURL;
    }

    public void setThumbnailURL(String thumbnailURL) {
        this.thumbnailURL = thumbnailURL;
    }

    public int getAdmin() {
        return admin;
    }

    public void setAdmin(int admin) {
        this.admin = admin;
    }

   

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    

   

    public List<Lesson> getLessons() {
        return lessons;
    }

    public void setLessons(List<Lesson> lessons) {
        this.lessons = lessons;
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

    public int getSemester() {
        return semester;
    }

    public void setSemester(int semester) {
        this.semester = semester;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }
    

   
}
