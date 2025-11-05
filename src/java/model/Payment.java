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


public class Payment {
    private int paymentID;
    private User user;
    private Course course;
    private double amount;
    private Date paymentDate;
    private String paymentMethod; // 'Credit Card', 'Bank Transfer', 'Momo', 'ZaloPay', 'Other'
    private String paymentStatus; // 'Pending', 'Completed', 'Failed'

    public Payment() {
        this.paymentDate = new Date();
        this.paymentStatus = "Pending";
    }

    public Payment(int paymentID, User user, Course course, double amount, Date paymentDate, String paymentMethod, String paymentStatus) {
        this.paymentID = paymentID;
        this.user = user;
        this.course = course;
        this.amount = amount;
        this.paymentDate = paymentDate;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
    }

    public int getPaymentID() {
        return paymentID;
    }

    public void setPaymentID(int paymentID) {
        this.paymentID = paymentID;
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

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }
    

  
}
