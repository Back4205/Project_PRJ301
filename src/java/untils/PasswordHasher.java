/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package untils;

import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author Vuong Bach
 */
public class PasswordHasher {
    // ma hoa majt khau 
    public static String hashPassword(String password){
        return BCrypt.hashpw(password, BCrypt.gensalt(10));
    }
    // giai ma mat khau va so sanh voi mat khau nguoi dung nhap vao 
    public static boolean checkPassword(String password , String hashPassword){
        return BCrypt.checkpw(password, hashPassword);
    }

}
