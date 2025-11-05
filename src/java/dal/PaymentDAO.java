package dal;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.math.BigDecimal;

public class PaymentDAO extends DBContext {

    /**
     * Thêm một thanh toán mới
     * @param method: (ví dụ: 'Momo', 'Credit Card'...)
     */
    public boolean addPayment(int userID, int courseID, double amount, String method) {
        String sql = "INSERT INTO Payments (UserID, CourseID, Amount, PaymentMethod) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ps.setInt(2, courseID);
            ps.setBigDecimal(3, BigDecimal.valueOf(amount)); // Dùng BigDecimal cho kiểu DECIMAL
            ps.setString(4, method);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi thêm payment: " + e.getMessage());
        }
        return false;
    }
}