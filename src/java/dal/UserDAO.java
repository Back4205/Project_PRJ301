package dal;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

import java.util.List;
import model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.sql.Statement;

/**
 *
 * @author ADMIN
 */
public class UserDAO extends DBContext {

    private final String GET_ALL_USER = "select * from Users";
    private final String LOGIN_USER = "Select * from Users where Email =? and PasswordHash =?";
    private final String REGISTER_USER = "INSERT INTO dbo.Users (  FullName, Email,PasswordHash,Role) VALUES (?, ?, ?,?)";
    private final String CHECK_EMAIL = "Select * from Users where Email =?";

    public List<User> getAllMenber() {
        try {
            PreparedStatement stm = c.prepareStatement(GET_ALL_USER);

            ResultSet rs = stm.executeQuery();

            List<User> listUser = new ArrayList<>();
            while (rs.next()) {
                int userID = rs.getInt("UserID");
                String FullName = rs.getString("FullName");
                String Email = rs.getString("Email");
                String PasswordHash = rs.getString("PasswordHash");
                byte role = rs.getByte("Role");
                Date registerDate = rs.getDate("RegisterDate");

                listUser.add(new User(userID, FullName, Email, PasswordHash, role, registerDate));//(userID,FullName, Email, PasswordHash, role, registerDate)
            }
            return listUser;

        } catch (Exception e) {
            return null;
        }

    }

    public User login(String email, String password) {
        try {
            PreparedStatement stm = c.prepareStatement(LOGIN_USER);

            stm.setString(1, email);
            stm.setString(2, password);

            ResultSet rs1 = stm.executeQuery();

            if (rs1.next()) {
                return new User(rs1.getInt("UserID"),rs1.getString("FullName"), rs1.getString("Email"), rs1.getString("PasswordHash"), rs1.getByte("Role"), rs1.getDate("RegisterDate"));
            }
            return null;

        } catch (Exception e) {
            return null;
        }

    }

    private boolean checkExistEmail(String email) {
        try {

            PreparedStatement stm = c.prepareStatement(CHECK_EMAIL);

            stm.setString(1, email);

            ResultSet rs1 = stm.executeQuery();

            if (rs1.next()) {
                System.out.println("Email found in database: " + rs1.getString("Email"));
                return true;
            }

            return false;

        } catch (Exception e) {

            e.printStackTrace();
        }
        return false;
    }

    public User getUserByEmail(String email) {
        try {

            PreparedStatement stm = c.prepareStatement(CHECK_EMAIL);

            stm.setString(1, email);

            ResultSet rs1 = stm.executeQuery();

            if (rs1.next()) {
                return new User(rs1.getInt("UserID"),rs1.getString("FullName"), rs1.getString("Email"), rs1.getString("PasswordHash"), rs1.getByte("Role"), rs1.getDate("RegisterDate"));

            }

            return null;

        } catch (Exception e) {

            e.printStackTrace();
        }
        return null;
    }

    public User register(String fullname, String email, String password) {
        if (checkExistEmail(email)) {
           return null;
        }
        try {
            // Yêu cầu JDBC trả về key (UserID) vừa được tạo
            PreparedStatement stm = c.prepareStatement(REGISTER_USER, Statement.RETURN_GENERATED_KEYS);
            stm.setString(1, fullname);
            stm.setString(2, email);
            stm.setString(3, password);
            stm.setInt(4, 1); // Role = 1 (User)
            
            int check = stm.executeUpdate();

            if (check > 0) {
                // Lấy UserID vừa được tạo từ DB
                try (ResultSet generatedKeys = stm.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int newUserID = generatedKeys.getInt(1);
                        
                        // Trả về đối tượng User hoàn chỉnh
                        return new User(newUserID, fullname, email, password, (byte) 1, new java.util.Date());
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // Trả về null nếu đăng ký thất bại
    }
    
//    public boolean updateRole(String email, byte newRole) {
//    String UPDATE_ROLE = "UPDATE Users SET Role = ? WHERE Email = ?";
//
//    try {
//        PreparedStatement stm = c.prepareStatement(UPDATE_ROLE);
//        stm.setByte(1, newRole);
//        stm.setString(2, email);
//
//        int rowsAffected = stm.executeUpdate();
//        return rowsAffected > 0; // true nếu cập nhật thành công
//
//    } catch (Exception e) {
//        e.printStackTrace();
//    }
//    return false;
//}
    
    public void deleteUser(int id) {
        String sql = "DELETE FROM Users WHERE UserID = ?";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
           
        }
    }
     public User findUserById(int id) {
        String sql = "SELECT * FROM Users WHERE UserID = ?";
        User s = null;
        try {
            PreparedStatement st = c.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int userID = rs.getInt("UserID");
                String FullName = rs.getString("FullName");
                String Email = rs.getString("Email");
                String PasswordHash = rs.getString("PasswordHash");
                byte role = rs.getByte("Role");
                Date registerDate = rs.getDate("RegisterDate");

                s = new User(userID, FullName, Email, PasswordHash, role, registerDate);
            }
        } catch (SQLException e) {
            
        }
        return s;
    }
     public void updateUser(User u) {
    String sql = "UPDATE Users SET FullName = ?, Email = ?, Role = ? WHERE UserID = ?";
    try (
         PreparedStatement ps = c.prepareStatement(sql)) {
        ps.setString(1, u.getFullName());
        ps.setString(2, u.getEmail());
        ps.setInt(3, u.getRole());
        ps.setInt(4, u.getUserID());
        ps.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}


    
}
