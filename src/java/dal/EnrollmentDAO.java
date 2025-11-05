package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Course;

public class EnrollmentDAO extends DBContext {

    // Kiểm tra xem user đã đăng ký khóa học chưa
    public boolean isEnrolled(int userID, int courseID) {
        String sql = "SELECT COUNT(*) FROM Enrollments WHERE UserID = ? AND CourseID = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ps.setInt(2, courseID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Thêm Enrollment mới
    public boolean addEnrollment(int userID, int courseID) {
        String sql = "INSERT INTO Enrollments (UserID, CourseID, EnrollDate, Progress) VALUES (?, ?, GETDATE(), 0)";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ps.setInt(2, courseID);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Lỗi khi thêm Enrollment: " + e.getMessage());
        }
        return false;
    }

    // Lấy danh sách khóa học mà user đã đăng ký
   public List<Course> getEnrolledCourses(int userID) {
    List<Course> list = new ArrayList<>();
    String sql = "SELECT c.* FROM Courses c " +
                 "JOIN Enrollments e ON c.CourseID = e.CourseID " +
                 "WHERE e.UserID = ?";
    try (PreparedStatement ps = c.prepareStatement(sql)) {
        ps.setInt(1, userID);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Course c = new Course();
            c.setCourseID(rs.getInt("CourseID"));
            c.setTitle(rs.getString("Title"));
            c.setDescription(rs.getString("Description"));
            c.setThumbnailURL(rs.getString("ThumbnailURL"));
            c.setPrice(rs.getDouble("Price"));
            list.add(c);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}
   
    public boolean enrollAllCoursesForAdmin(int adminUserID) {
    String sql = "INSERT INTO Enrollments (UserID, CourseID, EnrollDate, Progress)\n" +
                 "SELECT ?, CourseID, GETDATE(), 0\n" +
                 "FROM Courses\n" +
                 "WHERE CourseID NOT IN (SELECT CourseID FROM Enrollments WHERE UserID = ?)";

    try (PreparedStatement ps = c.prepareStatement(sql)) {
        ps.setInt(1, adminUserID);
        ps.setInt(2, adminUserID);
        return ps.executeUpdate() > 0;
    } catch (Exception e) {
        System.out.println("Lỗi khi enroll all for admin: " + e.getMessage());
    }
    return false;
}

     public static void main(String[] args) {
        EnrollmentDAO dao = new EnrollmentDAO();
        List<Course> list = dao.getEnrolledCourses(5);
        int count = 0 ; 
        for (Course course : list) {
            count ++ ;
        }
        System.out.println(count);
    }

}
