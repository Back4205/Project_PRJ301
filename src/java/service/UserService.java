/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package service;

import constant.MessageConstant;
import dal.UserDAO;
import dto.RegisterRequest;
import dto.Reponse;
import java.util.List;
import model.User;
import untils.PasswordHasher;

/**
 *
 * @author Vuong Bach
 */
public class UserService {
    UserDAO userDAO;
    
    public UserService (){
        userDAO = new UserDAO();
    }
    public Reponse<User> checkLogin(String email , String password){
        User user = userDAO.getUserByEmail(email);
        if (user != null && PasswordHasher.checkPassword(password, user.getPasswordHash()) ) {
           return  new Reponse<>(user,true,MessageConstant.LOGIN_SUCCESS);
        }
        return new Reponse<>(null,false,MessageConstant.LOGIN_FAILED);
    }
    public User register (RegisterRequest request){
        String hashedPassword = PasswordHasher.hashPassword(request.getPassword());
        return userDAO.register(request.getFullname(), request.getEmail(), hashedPassword);
    }
    public List<User> getAllUser(){
        return userDAO.getAllMenber();
    }
}
