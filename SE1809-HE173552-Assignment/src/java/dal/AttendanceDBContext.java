/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import model.Attendance;
import java.sql.*;
import model.Group;
import model.Lecturer;
import model.Room;
import model.Session;
import model.Slot;
import model.Student;

/**
 *
 * @author Admin
 */
public class AttendanceDBContext extends DBContext<Attendance> {

    @Override
    public ArrayList<Attendance> listAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void insert(Attendance entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Attendance entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Attendance entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public void patchupdateByLesson(int sesid, ArrayList<Attendance> atts) {
        try {
            connection.setAutoCommit(false);
            String delete_sql = "DELETE FROM Attendance WHERE sesid = ?";
            PreparedStatement ps_remove = connection.prepareStatement(delete_sql);
            ps_remove.setInt(1, sesid);
            ps_remove.executeUpdate();
            for (Attendance att : atts) {
                String insert_sql = "INSERT INTO Attendance(sesid, [sid], [dateTime], [status], [description]) VALUES(?, ?, GETDATE(), ?, ?)";
                PreparedStatement ps = connection.prepareStatement(insert_sql);
                ps.setInt(1, sesid);
                ps.setString(2, att.getStudent().getSid());
                ps.setString(3, att.getStatus());
                ps.setString(4, att.getDescription());
                ps.executeUpdate();
            }
            String sql_update = "UPDATE [Session] SET isAttended = 1 WHERE sesid = ?";
            PreparedStatement ps_update = connection.prepareStatement(sql_update);
            ps_update.setInt(1, sesid);
            ps_update.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException e1) {
            }
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e2) {
            }
        }
    }

    public Attendance getStudentByStatus(Date date, String sid, int sesid) {
        try {
            String sql = "SELECT s.[sid], att.[status] FROM Attendance att INNER JOIN [Session] ss ON ss.sesid = att.sesid\n"
                    + "INNER JOIN Student s ON s.[sid] = att.[sid] WHERE ss.[date] = ? AND s.[sid] = ?\n"
                    + "AND ss.sesid = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setDate(1, date);
            ps.setString(2, sid);
            ps.setInt(3, sesid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Student stu = new Student();
                stu.setSid(rs.getString("sid"));
                stu.setSname(rs.getString("sname"));
                Attendance att = new Attendance();
                att.setStatus(rs.getString("status"));
                att.setStudent(stu);
                return att;
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public ArrayList<Attendance> viewAttendanceByStuIdAndTermid(String sid, int subid, int teid) {
        ArrayList<Attendance> attendances = new ArrayList<>();
        try {
            String sql = "SELECT stu.[sid], stu.sname, ss.[date], g.gname, sl.slid, r.rname,\n"
                    + "l.lid, att.[status], att.[description] FROM [Session] ss\n"
                    + "INNER JOIN [Group] g ON g.gid = ss.gid\n"
                    + "INNER JOIN Lecture l ON l.lid = g.pic\n"
                    + "INNER JOIN Room r ON r.rid = ss.rid\n"
                    + "INNER JOIN Slot sl ON sl.slid = ss.slid\n"
                    + "INNER JOIN Group_Student gs ON g.gid = gs.gid\n"
                    + "INNER JOIN Student stu ON stu.[sid] = gs.[sid] LEFT JOIN Attendance att\n"
                    + "ON stu.[sid] = att.[sid] AND ss.sesid = att.sesid\n"
                    + "INNER JOIN [Subject] sub ON sub.subid = g.subid\n"
                    + "	INNER JOIN TrainingDepartment td ON td.trid = sub.trid\n"
                    + "	INNER JOIN Term_TrainingDepartment ttd ON td.trid = ttd.trid\n"
                    + "	INNER JOIN Term t ON t.teid = ttd.teid AND t.teid = g.teid\n"
                    + "	WHERE stu.[sid] = ? AND sub.subid = ? AND g.teid = ?"
                    + "ORDER BY ss.[date]";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, sid);
            ps.setInt(2, subid);
            ps.setInt(3, teid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Student stu = new Student();
                stu.setSid(rs.getString("sid"));
                stu.setSname(rs.getString("sname"));
                Group group = new Group();
                group.setGname(rs.getString("gname"));
                Slot slot = new Slot();
                slot.setSlid(rs.getInt("slid"));
                Room r = new Room();
                r.setRname(rs.getString("rname"));
                Lecturer lec = new Lecturer();
                lec.setLid(rs.getString("lid"));
                Session sess = new Session();
                sess.setDate(rs.getDate("date"));
                sess.setGroup(group);
                sess.setRoom(r);
                sess.setSlot(slot);
                sess.setLecture(lec);
                Attendance att = new Attendance();
                att.setStatus(rs.getString("status"));
                att.setDescription(rs.getString("description"));
                att.setSession(sess);
                attendances.add(att);
            }
        } catch (SQLException e) {
        }
        return attendances;
    }

    public ArrayList<Attendance> getAttendanceByGroup(String lid, int subid, int teid, int gid) {
        ArrayList<Attendance> attendances = new ArrayList<>();
        try {
            String sql = "SELECT stu.[sid], stu.sname,\n"
                    + "       COUNT(CASE WHEN att.[status] = 'absent' THEN 1 END) AS num_absent,\n"
                    + "       COUNT(DISTINCT ss.sesid) AS total_sessions\n"
                    + "FROM [Session] ss\n"
                    + "INNER JOIN [Group] g ON g.gid = ss.gid\n"
                    + "INNER JOIN Group_Student gs ON g.gid = gs.gid\n"
                    + "INNER JOIN Student stu ON stu.[sid] = gs.[sid]\n"
                    + "LEFT JOIN Attendance att ON stu.[sid] = att.[sid] AND ss.sesid = att.sesid\n"
                    + "INNER JOIN Lecture l ON l.lid = g.pic\n"
                    + "INNER JOIN Room r ON r.rid = ss.rid\n"
                    + "INNER JOIN Slot sl ON sl.slid = ss.slid\n"
                    + "INNER JOIN [Subject] sub ON sub.subid = g.subid\n"
                    + "INNER JOIN TrainingDepartment td ON td.trid = sub.trid\n"
                    + "INNER JOIN Term_TrainingDepartment ttd ON td.trid = ttd.trid\n"
                    + "INNER JOIN Term t ON t.teid = ttd.teid AND t.teid = g.teid\n"
                    + "WHERE g.pic = ? AND sub.subid = ? AND g.teid = ?  AND g.gid = ?\n"
                    + "GROUP BY stu.[sid], stu.sname\n"
                    + "ORDER BY stu.[sid]";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, lid);
            ps.setInt(2, subid);
            ps.setInt(3, teid);
            ps.setInt(4, gid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Attendance att = new Attendance();
                Student s = new Student();
                s.setSid(rs.getString("sid"));
                s.setSname(rs.getString("sname"));
                att.setStudent(s);
                att.setNumOfAbsent(rs.getInt("num_absent"));
                att.setTotalSession(rs.getInt("total_sessions"));
                attendances.add(att);
            }
        } catch (SQLException e) {
        }
        return attendances;
    }

}
