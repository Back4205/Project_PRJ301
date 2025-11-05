/*
     * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
     * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.AbstractList;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Course;
import model.User;

/**
 *
 * @author Vuong Bach
 */
public class CourseDAO extends DBContext {

    private final String GET_ALL_COURSE = "select * from Courses";

    private final String INSERT_COURSE = "INSERT INTO dbo.Courses (Title, Description, Price, ThumbnailURL, CategoryID, CreateDate, AdminID) VALUES (?, ?, ?,?, ?, ?,?)";
    private final String CHECK_TITLE = "Select * from Courses where Title =?";

    public List<Course> getAllCourse() {
        try {
            PreparedStatement stm = c.prepareStatement(GET_ALL_COURSE);

            ResultSet rs = stm.executeQuery();

            List<Course> listcCourses = new ArrayList<>();

            while (rs.next()) {
                int courseID = rs.getInt("CourseID");
                String title = rs.getString("Title");
                String Description = rs.getString("Description");
                double price = rs.getDouble("Price");
                int AdminID = rs.getInt("AdminID");
                int CategoryID = rs.getInt("CategoryID");
                String ThumbnailURL = rs.getString("ThumbnailURL");

                Date CreateDate = rs.getDate("CreateDate");

                listcCourses.add(new Course(courseID, title, Description, price, AdminID, CategoryID, ThumbnailURL, CreateDate));
            }
            return listcCourses;

        } catch (Exception e) {
            return null;
        }

    }

    private boolean checkExistTitle(String title) {
        try {

            PreparedStatement stm = c.prepareStatement(CHECK_TITLE);

            stm.setString(1, title);

            ResultSet rs1 = stm.executeQuery();

            if (rs1.next()) {

                return true;
            }

            return false;

        } catch (Exception e) {

            e.printStackTrace();
        }
        return false;
    }

    public Course getCourseByTitle(String title) {
        try {

            PreparedStatement stm = c.prepareStatement(CHECK_TITLE);

            stm.setString(1, title);

            ResultSet rs1 = stm.executeQuery();

            if (rs1.next()) {
                int courseID = rs1.getInt("CourseID");
                String title_raw = rs1.getString("Title");
                String Description = rs1.getString("Description");
                double price = rs1.getDouble("Price");
                int AdminID = rs1.getInt("AdminID");
                int CategoryID = rs1.getInt("CategoryID");
                String ThumbnailURL = rs1.getString("ThumbnailURL");

                Date CreateDate = rs1.getDate("CreateDate");
                return new Course(courseID, title_raw, Description, price, AdminID, CategoryID, ThumbnailURL, CreateDate);

            }

            return null;

        } catch (Exception e) {

            e.printStackTrace();
        }
        return null;
    }

    public boolean insertCourse(String title, Course course) {
        if (checkExistTitle(title)) {
            return false;  // Đã tồn tại -> không thêm
        }

        try {
            PreparedStatement ps = c.prepareStatement(INSERT_COURSE);
            ps.setString(1, course.getTitle());
            ps.setString(2, course.getDescription());
            ps.setDouble(3, course.getPrice());
            ps.setString(4, course.getThumbnailURL());
            ps.setInt(5, course.getCategory());
            ps.setDate(6, new java.sql.Date(course.getCreateDate().getTime()));
            ps.setInt(7, 1); // adminID = 1 (admin tạo khóa học)

            ps.executeUpdate();
            ps.close();
            return true;

        } catch (SQLException e) {
            System.out.println("Lỗi insertCourse(): " + e.getMessage());
            return false;
        }
    }

    public void deleteCourse(int id) {
        String sql = "DELETE FROM Courses WHERE CourseID = ?";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {

        }
    }

    public Course findCourseById(int id) {
        String sql = "SELECT * FROM Courses WHERE CourseID = ?";
        Course course = null;
        try {
            PreparedStatement st = c.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int courseID = rs.getInt("CourseID");
                String title_raw = rs.getString("Title");
                String Description = rs.getString("Description");
                double price = rs.getDouble("Price");
                int AdminID = rs.getInt("AdminID");
                int CategoryID = rs.getInt("CategoryID");
                String ThumbnailURL = rs.getString("ThumbnailURL");

                Date CreateDate = rs.getDate("CreateDate");
                return new Course(courseID, title_raw, Description, price, AdminID, CategoryID, ThumbnailURL, CreateDate);
            }
        } catch (SQLException e) {

        }
        return course;
    }

    public void updateCourse(Course u) {
        String sql = "UPDATE Courses SET Title = ?, Description = ?, Price = ? , ThumbnailURL = ? ,CategoryID=?  WHERE CourseID = ?";
        try (
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, u.getTitle());
            ps.setString(2, u.getDescription());
            ps.setDouble(3, u.getPrice());
            ps.setString(4, u.getThumbnailURL());
            ps.setInt(5, u.getCategory());
            ps.setInt(6, u.getCourseID());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Course> getinformationAllCourses() {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT c.CourseID, c.Title, c.Description, c.Price, c.ThumbnailURL, c.CategoryID, "
                + "cat.CategoryName, "
                + "CASE "
                + "  WHEN cat.CategoryName LIKE 'Semester 1%' THEN 1 "
                + "  WHEN cat.CategoryName LIKE 'Semester 2%' THEN 2 "
                + "  WHEN cat.CategoryName LIKE 'Semester 3%' THEN 3 "
                + "  WHEN cat.CategoryName LIKE 'Semester 4%' THEN 4 "
                + "  WHEN cat.CategoryName LIKE 'Semester 5%' THEN 5 "
                + "  ELSE NULL "
                + "END AS Semester "
                + "FROM Courses c "
                + "LEFT JOIN Categories cat ON c.CategoryID = cat.CategoryID";

        try (
                PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Course course = new Course();
                course.setCourseID(rs.getInt("CourseID"));
                course.setTitle(rs.getString("Title"));
                course.setDescription(rs.getString("Description"));
                course.setPrice(rs.getDouble("Price"));
                course.setThumbnailURL(rs.getString("ThumbnailURL"));
                course.setCategory(rs.getInt("CategoryID"));
                course.setCategoryName(rs.getString("CategoryName"));
                course.setSemester(rs.getInt("Semester"));  // semester từ category
                courses.add(course);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return courses;
    }

    public List<Course> getCoursesByUser(int userID) {
        List<Course> list = new ArrayList<>();
        String sql = """
            SELECT c.CourseID, c.Title, c.Description, c.ThumbnailURL, c.Price
            FROM Courses c
            INNER JOIN Enrollments e ON c.CourseID = e.CourseID
            WHERE e.UserID = ?
        """;
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
            System.out.println("🔎 [CourseDAO] getCoursesByUser(" + userID + ") -> " + list.size() + " result(s)");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Course> listcourseandNumberSell() {
        String sql = "SELECT \n"
                + "    c.*,\n"
                + "    COUNT(e.CourseID) AS SoLuongBanRa\n"
                + "FROM Courses c\n"
                + "LEFT JOIN Enrollments e ON c.CourseID = e.CourseID\n"
                + "GROUP BY c.CourseID, c.Title, c.Price ,c.AdminID,c.CategoryID,c.CreateDate,c.Description,c.ThumbnailURL\n"
                + "ORDER BY SoLuongBanRa DESC;";
        try {
            PreparedStatement stm = c.prepareStatement(sql);

            ResultSet rs = stm.executeQuery();

            List<Course> listcCourses = new ArrayList<>();

            while (rs.next()) {
                int courseID = rs.getInt("CourseID");
                String title = rs.getString("Title");
                String Description = rs.getString("Description");
                double price = rs.getDouble("Price");
                int AdminID = rs.getInt("AdminID");
                int CategoryID = rs.getInt("CategoryID");
                String ThumbnailURL = rs.getString("ThumbnailURL");

                Date CreateDate = rs.getDate("CreateDate");
                int nuumberSell = rs.getInt("SoLuongBanRa");

                listcCourses.add(new Course(courseID, title, Description, price, AdminID, CategoryID, ThumbnailURL, CreateDate,nuumberSell));
            }
            return listcCourses;

        } catch (Exception e) {
            return null;
        }
    }

}
