/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import model.Mark;
import java.sql.*;
import model.Group;
import model.Student;
import model.Subject;
import model.Term;

/**
 *
 * @author Admin
 */
public class MarkReportDBContext extends DBContext<Mark> {

    @Override
    public ArrayList<Mark> listAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void insert(Mark entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Mark entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Mark entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public ArrayList<Mark> listBySubidAndSubid(String sid, int gid, int subid) {
        ArrayList<Mark> marks = new ArrayList<>();
        try {
            String sql = "SELECT stu.[sid], stu.sname, sub.subid, sub.subname, t.teid, t.tename , g.gname, MIN(ss.date) AS [start_date], MAX(ss.date) AS [end_date]\n"
                    + "FROM Student stu \n"
                    + "JOIN Group_Student gs ON stu.sid = gs.sid\n"
                    + "JOIN [Group] g ON g.gid = gs.gid \n"
                    + "JOIN [Subject] sub ON sub.subid = g.subid\n"
                    + "JOIN TrainingDepartment td ON td.trid = sub.trid \n"
                    + "JOIN Term_TrainingDepartment ttd ON td.trid = ttd.trid \n"
                    + "JOIN Term t ON t.teid = ttd.teid AND g.teid = t.teid\n"
                    + "JOIN Lecture l ON l.lid = g.pic \n"
                    + "JOIN [Session] ss ON l.lid = ss.lid AND g.gid = ss.gid\n";
            if (sid != null) {
                sql += "WHERE stu.sid = ?\n";
            }
            if (subid != 0 && gid != 0) {
                sql += " WHERE g.gid = ? AND sub.subid = ?";
            }

            sql += " GROUP BY stu.[sid], stu.sname, sub.subid, sub.subname, t.teid, t.tename, g.gname";
            PreparedStatement ps = connection.prepareStatement(sql);
            if (sid != null) {
                ps.setString(1, sid);
            }
            if (subid != 0 && gid != 0) {
                ps.setInt(1, gid);
                ps.setInt(2, subid);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Term t = new Term();
                t.setTeid(rs.getInt("teid"));
                t.setTename(rs.getString("tename"));
                Subject sub = new Subject();
                sub.setSubid(rs.getInt("subid"));
                sub.setSubname(rs.getString("subname"));
                Group group = new Group();
                group.setGname(rs.getString("gname"));
                Student stu = new Student();
                stu.setSid(rs.getString("sid"));
                stu.setSname(rs.getString("sname"));
                Mark mark = new Mark();
                mark.setTerm(t);
                mark.setSubject(sub);
                mark.setGroup(group);
                mark.setStartDate(rs.getDate("start_date"));
                mark.setEndDate(rs.getDate("end_date"));
                mark.setStudent(stu);
                marks.add(mark);
            }
        } catch (SQLException e) {
        }
        return marks;
    }

}
