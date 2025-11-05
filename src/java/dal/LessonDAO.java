package dal;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Lesson;

public class LessonDAO extends DBContext {

    /**
     * Lấy tất cả bài học (Lessons) theo CourseID
     */
    public List<Lesson> getLessonsByCourseID(int courseID) {
        List<Lesson> list = new ArrayList<>();
        String sql = "SELECT LessonID, Title, VideoURL FROM Lessons WHERE CourseID = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, courseID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Lesson lesson = new Lesson();
                    lesson.setLessonID(rs.getInt("LessonID"));
                    lesson.setTitle(rs.getString("Title"));
                    lesson.setVideoURL(rs.getString("VideoURL"));
                    // Không cần set courseID ở đây, trừ khi model Lesson yêu cầu
                    list.add(lesson);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    // ✅ Lấy 1 lesson theo ID (để sửa)
    public Lesson getLessonById(int lessonID) {
        Lesson l = null;
        String sql = "SELECT LessonID, CourseID, Title, VideoURL FROM Lessons WHERE LessonID = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, lessonID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                l = new Lesson();
                l.setLessonID(rs.getInt("LessonID"));
                l.setTitle(rs.getString("Title"));
                l.setVideoURL(rs.getString("VideoURL"));

                // nếu model yêu cầu course object
                CourseDAO cDao = new CourseDAO();
                l.setCourse(cDao.findCourseById(rs.getInt("CourseID")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return l;
    }

    // ✅ Update lesson
    public boolean updateLesson(int lessonID, String title, String videoURL) {
        String sql = "UPDATE Lessons SET Title = ?, VideoURL = ? WHERE LessonID = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, title);
            ps.setString(2, videoURL);
            ps.setInt(3, lessonID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Insert lesson mới
    public boolean insertLesson(int courseID, String title, String videoURL) {
        String sql = "INSERT INTO Lessons (CourseID, Title, VideoURL) VALUES (?, ?, ?)";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, courseID);
            ps.setString(2, title);
            ps.setString(3, videoURL);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Delete lesson
    public boolean deleteLesson(int lessonID) {
        String sql = "DELETE FROM Lessons WHERE LessonID = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, lessonID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
}