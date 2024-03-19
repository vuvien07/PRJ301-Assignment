/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import model.Session;
import java.sql.*;
import model.Attendance;
import model.Group;
import model.Lecturer;
import model.Room;
import model.Slot;
import model.Student;
import model.Subject;

/**
 *
 * @author Admin
 */
public class SessionDBContext extends DBContext<Session> {

    @Override
    public ArrayList<Session> listAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void insert(Session entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Session entity) {
    }

    public void updateBySesid(int sesid) {
        try {
            String sql = "UPDATE [Session] \n"
                    + "SET isAttended = 1 WHERE sesid = ? \n";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setInt(1, sesid);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    @Override
    public void delete(Session entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public ArrayList<Session> listBy(String id, String role, Date from, Date to) {
        ArrayList<Session> lists = new ArrayList<>();
        try {
            String sql = "SELECT l.lid, l.lname,s.sesid, s.date, s.isAttended, gr.gid, gr.gname, su.subid, su.subname,l.lname, "
                    + "r.rname, sl.slid, sl.[from], sl.[to]";
            if (role.equals("Student")) {
                sql += ",att.[status] ";
            }
            sql += " FROM [Session] s "
                    + "INNER JOIN [Group] gr ON gr.gid = s.gid "
                    + "INNER JOIN Slot sl ON sl.slid = s.slid "
                    + "INNER JOIN Room r ON r.rid = s.rid "
                    + "INNER JOIN Lecture l ON l.lid = s.lid "
                    + "INNER JOIN [Subject] su ON su.subid = gr.subid ";
            String whereCondition = "s.[date] >= ? AND s.[date] <= ?";
            if (role.equals("Lecturer")) {
                whereCondition += " AND l.lid = ?";
            } else {
                sql += "INNER JOIN Group_Student grs ON gr.gid = grs.gid "
                        + "INNER JOIN Student stu ON stu.[sid] = grs.[sid] "
                        + " LEFT JOIN Attendance att ON stu.[sid] = att.[sid] AND s.sesid = att.sesid";
                whereCondition += " AND stu.[sid] = ?";
            }
            sql += " WHERE " + whereCondition;

            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setDate(1, from);
            ps.setDate(2, to);
            // Cập nhật vị trí của id trong trường hợp vai trò là teacher
            ps.setString(3, id);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Room room = new Room();
                room.setRname(rs.getString("rname"));
                Lecturer lecturer = new Lecturer();
                lecturer.setLid(rs.getString("lid"));
                lecturer.setLname(rs.getString("lname"));
                Subject sub = new Subject();
                sub.setSubid(rs.getInt("subid"));
                sub.setSubname(rs.getString("subname"));
                Slot slot = new Slot();
                slot.setSlid(rs.getInt("slid"));
                slot.setFrom(rs.getTime("from"));
                slot.setTo(rs.getTime("to"));
                Group group = new Group();
                group.setGid(rs.getInt("gid"));
                group.setGname(rs.getString("gname"));
                group.setSubject(sub);
                Session session = new Session();
                session.setSesid(rs.getInt("sesid"));
                session.setSlot(slot);
                session.setGroup(group);
                session.setLecture(lecturer);
                session.setRoom(room);
                session.setDate(rs.getDate("date"));
                session.setIsAttended(rs.getBoolean("isAttended"));
                if (role.equals("Student")) {
                    Attendance att = new Attendance();
                    att.setStatus(rs.getString("status"));
                    ArrayList<Attendance> attendances = new ArrayList<>();
                    attendances.add(att);
                    session.setAttendances(attendances);
                }
                lists.add(session);
            }
        } catch (SQLException e) {
        }
        return lists;
    }

    public ArrayList<Attendance> getAttendanceBySesId(int sesid) {
        ArrayList<Attendance> lists = new ArrayList<>();
        try {
            String sql = "SELECT s.[sid], s.sname, l.lid, l.lname, att.atid, att.[status], att.[description], att.[dateTime] FROM\n"
                    + "Student s JOIN Group_Student gr ON s.[sid] = gr.[sid]\n"
                    + "INNER JOIN [Group] g ON g.gid = gr.gid INNER JOIN [Session] ss ON g.gid = ss.gid\n"
                    + "INNER JOIN Lecture l ON l.lid = g.pic\n"
                    + "LEFT JOIN Attendance att ON ss.sesid = att.sesid AND s.[sid] = att.[sid]\n"
                    + "WHERE ss.sesid = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, sesid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Attendance a = new Attendance();
                Lecturer lec = new Lecturer();
                lec.setLid(rs.getString("lid"));
                lec.setLname(rs.getString("lname"));
                Student stu = new Student();
                stu.setSid(rs.getString("sid"));
                stu.setSname(rs.getString("sname"));
                Session sess = new Session();
                sess.setLecture(lec);
                a.setSession(sess);
                a.setStudent(stu);
                a.setAtid(rs.getInt("atid"));
                if (a.getAtid() != 0) {
                    a.setDateTime(rs.getDate("dateTime"));
                    a.setStatus(rs.getString("status"));
                    a.setDescription(rs.getString("description"));
                }
                lists.add(a);
            }
        } catch (SQLException e) {
        }
        return lists;
    }

    public Session getSessionBySesid(int sesid) {
        try {
            String sql = "Select * FROM [Session] s WHERE s.sesid = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, sesid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Session sess = new Session();
                sess.setSesid(sesid);
                sess.setIsAttended(true);
                return sess;
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public ArrayList<Session> listSessionByStudentIdAndSubid(String sid, int subid, int teid) {
        ArrayList<Session> sessions = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Student stu JOIN Group_Student gs ON stu.[sid] = gs.[sid]\n"
                    + "	JOIN [Group] g ON g.gid = gs.gid JOIN [Subject] sub ON sub.subid = g.subid\n"
                    + "	 JOIN TrainingDepartment td ON td.trid = sub.trid JOIN Term_TrainingDepartment ttd \n"
                    + "	ON td.trid = ttd.trid JOIN Term t ON t.teid = ttd.teid AND g.teid = t.teid\n"
                    + "	JOIN Lecture l ON l.lid = g.pic JOIN [Session] ss ON l.lid = ss.lid AND g.gid = ss.gid\n"
                    + "	WHERE stu.[sid] = ? AND sub.subid = ? AND g.teid = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, sid);
            ps.setInt(2, subid);
            ps.setInt(3, teid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Session sess = new Session();
                sess.setIsAttended(rs.getBoolean("isAttended"));
                sessions.add(sess);
            }
        } catch (Exception e) {
        }
        return sessions;
    }

    public ArrayList<Session> getListByPage(ArrayList<Session> lists, int start, int end) {
        ArrayList<Session> depts = new ArrayList<>();
        for (int i = start; i < end; i++) {
            depts.add(lists.get(i));
        }
        return depts;
    }
}
