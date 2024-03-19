/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import model.Student;
import java.sql.*;

/**
 *
 * @author Admin
 */
public class StudentDBContext extends DBContext<Student> {

    @Override
    public ArrayList<Student> listAll() {
        ArrayList<Student> list = new ArrayList<>();
        try {
            String sql = "select * from Student";
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Student s = new Student();
                s.setSid(rs.getString("sid"));
                s.setSname(rs.getString("sname"));
                s.setEmail(rs.getString("email"));
                s.setSaccid(rs.getInt("saccid"));
                s.setMaid(rs.getInt("maid"));
                list.add(s);
            }
        } catch (SQLException e) {
        }
        return list;
    }

    @Override
    public void insert(Student entity) {
        try {
            String sql = "INSERT INTO Student VALUES(?, ?, ?, ?, ?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, entity.getSid());
            ps.setString(2, entity.getSname());
            ps.setString(3, entity.getEmail());
            ps.setInt(4, entity.getSaccid());
            ps.setInt(5, entity.getMaid());
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    @Override
    public void update(Student entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Student entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public boolean isExistStudent(String sid) {
        try {
            String sql = "SELECT  * FROM Student s WHERE s.sid = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, sid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
        }
        return false;
    }

    public ArrayList<Student> listBySession(int sesid) {
        ArrayList<Student> lists = new ArrayList<>();
        try {
            String sql = "SELECT s.[sid], s.sname FROM Student s JOIN Group_Student gs ON s.[sid] = gs.[sid]\n"
                    + "JOIN [Group] g ON g.gid = gs.gid JOIN [Session] ss ON g.gid = ss.gid\n"
                    + "WHERE ss.sesid = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, sesid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Student student = new Student();
                student.setSid(rs.getString("sid"));
                student.setSname(rs.getString("sname"));
                lists.add(student);
            }
        } catch (SQLException e) {
        }
        return lists;
    }

    public Student getStuByUserId(String username) {
        try {
            String sql = "SELECT * FROM Student s JOIN Account a ON a.accid = s.saccid\n"
                    + "                     WHERE a.username = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Student s = new Student();
                s.setSid(rs.getString("sid"));
                s.setSname(rs.getString("sname"));
                return s;
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public Student getStuById(String sid) {
        try {
            String sql = "SELECT * FROM Student s JOIN Account a ON a.accid = s.saccid\n"
                    + "                     WHERE s.[sid] = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, sid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Student s = new Student();
                s.setSid(rs.getString("sid"));
                s.setSname(rs.getString("sname"));
                return s;
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public ArrayList<Student> listGradeBySubIdAndGid(int subid, int teid, int gid) {
        ArrayList<Student> students = new ArrayList<>();
        try {
            String sql = "SELECT stu.[sid], stu.[sname], SUM(ass.[weight] * g.score / 100) AS avg_grade\n"
                    + "FROM [Subject] sub \n"
                    + "JOIN Assesment ass ON sub.subid = ass.subid\n"
                    + "JOIN [Group] gr ON sub.subid = gr.subid \n"
                    + "JOIN Group_Student gs ON gr.gid = gs.gid\n"
                    + "JOIN Student stu ON stu.[sid] = gs.[sid] \n"
                    + "LEFT JOIN Grade g ON ass.asid = g.asid AND sub.subid = g.subid AND stu.[sid] = g.[sid]\n"
                    + "WHERE sub.subid = ? AND gr.teid = ? AND gr.gid = ?\n"
                    + "GROUP BY stu.[sid], stu.[sname]";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, subid);
            ps.setInt(2, teid);
            ps.setInt(3, gid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Student stu = new Student();
                stu.setSid(rs.getString("sid"));
                stu.setSname(rs.getString("sname"));
                stu.setAverage(rs.getFloat("avg_grade"));
                students.add(stu);
            }
        } catch (SQLException e) {
        }
        return students;
    }
    
     public ArrayList<Student> getListByPage(ArrayList<Student> lists, int start, int end) {
       ArrayList<Student> depts= new ArrayList<>();
        for (int i = start; i < end; i++) {
            depts.add(lists.get(i));
        }
        return depts;
    }
     
     public ArrayList<Student> listAllBySearch(String str) {
        ArrayList<Student> list = new ArrayList<>();
        try {
            String sql = "select * from Student s WHERE s.sname LIKE '%' + ? + '%'";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, str);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Student s = new Student();
                s.setSid(rs.getString("sid"));
                s.setSname(rs.getString("sname"));
                s.setEmail(rs.getString("email"));
                s.setSaccid(rs.getInt("saccid"));
                s.setMaid(rs.getInt("maid"));
                list.add(s);
            }
        } catch (SQLException e) {
        }
        return list;
    }

}
