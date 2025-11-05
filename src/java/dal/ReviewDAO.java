package dao;

import dal.DBContext;
import model.Review;
import model.User;
import model.Course;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO extends DBContext {

    /**
     * Lấy danh sách Review theo CourseID, kèm thông tin người dùng (FullName)
     */
    public List<Review> getReviewsByCourseID(int courseID) {
        List<Review> list = new ArrayList<>();

        String sql = """
            SELECT R.ReviewID, R.Rating, R.Comment, R.ReviewDate,
                   U.UserID, U.FullName
            FROM Reviews R
            JOIN Users U ON R.UserID = U.UserID
            WHERE R.CourseID = ?
            ORDER BY R.ReviewDate DESC
        """;

        try (
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, courseID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Tạo User object (chỉ cần UserID + FullName)
                    User user = new User();
                    user.setUserID(rs.getInt("UserID"));
                    user.setFullName(rs.getString("FullName"));

                    // Tạo Course object (chỉ cần CourseID)
                    Course course = new Course();
                    course.setCourseID(courseID);

                    // Tạo Review
                    Review review = new Review();
                    review.setReviewID(rs.getInt("ReviewID"));
                    review.setUser(user);
                    review.setCourse(course);
                    review.setRating(rs.getInt("Rating"));
                    review.setComment(rs.getString("Comment"));
                    review.setReviewDate(rs.getDate("ReviewDate"));

                    list.add(review);
                }
            }

        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi lấy danh sách review: " + e.getMessage());
        }

        return list;
    }

    /**
     * Thêm một review mới cho khóa học
     */
  public boolean insertReview(Review review) {
    String sql = "INSERT INTO Reviews (CourseID, UserID, Rating, Comment) VALUES (?, ?, ?, ?)";
    try (PreparedStatement ps = c.prepareStatement(sql)) {
        ps.setInt(1, review.getCourse().getCourseID());
        ps.setInt(2, review.getUser().getUserID());
        ps.setInt(3, review.getRating());
        ps.setString(4, review.getComment());
        return ps.executeUpdate() > 0;
    } catch (SQLException e) {
//        e.printStackTrace();
        System.out.println("!!!!!!!!!!!!!! LỖI SQL KHI INSERT REVIEW: " + e.getMessage());
    }
    return false;
}


    /**
     * Xóa review theo ID
     */
    public boolean deleteReview(int reviewID) {
        String sql = "DELETE FROM Reviews WHERE ReviewID = ?";
        try (
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, reviewID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi xóa review: " + e.getMessage());
            return false;
        }
    }
}
