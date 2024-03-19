/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Account;
import model.Subject;
import model.TrainingDepartment;

/**
 *
 * @author Admin
 */
public class SubjectDBContext extends DBContext<Subject> {

    @Override
    public ArrayList<Subject> listAll() {
        ArrayList<Subject> subjects = new ArrayList<>();
        try {
            String sql = "SELECT * FROM [Subject]";
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Subject sub = new Subject();
                sub.setSubid(rs.getInt("subid"));
                sub.setSubname(rs.getString("subname"));
                subjects.add(sub);
            }
        } catch (SQLException e) {
        }
        return subjects;
    }

    @Override
    public void insert(Subject entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Subject entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Subject entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public ArrayList<Subject> listByTermAndLid(int teid, String lid) {
        ArrayList<Subject> subjects = new ArrayList<>();
        try {
            String sql = "SELECT DISTINCT sub.subid, sub.subname FROM [Subject] sub\n"
                    + "INNER JOIN TrainingDepartment td ON td.trid = sub.trid\n"
                    + "INNER JOIN Term_TrainingDepartment ttd ON td.trid = ttd.trid INNER JOIN "
                    + "Term t ON t.teid = ttd.teid\n"
                    + " INNER JOIN [Group] g ON sub.subid = g.subid\n"
                    + "	INNER JOIN Lecture l ON l.lid = g.pic "
                    + "Where t.teid = ? AND l.lid = ? AND g.teid = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, teid);
            ps.setString(2, lid);
            ps.setInt(3, teid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Subject sub = new Subject();
                sub.setSubid(rs.getInt("subid"));
                sub.setSubname(rs.getString("subname"));
                subjects.add(sub);
            }
        } catch (SQLException e) {
        }
        return subjects;
    }

    public ArrayList<Subject> listByTermId(int teid, String sid) {
        ArrayList<Subject> subjects = new ArrayList<>();
        try {
            String sql = "SELECT * FROM [Subject] sub INNER JOIN [Group] g ON sub.subid = g.subid\n"
                    + "	INNER JOIN Group_Student gs ON g.gid = gs.gid INNER JOIN Student stu ON stu.[sid] = gs.[sid]\n"
                    + "	Where g.teid = ? AND stu.[sid] = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, teid);
            ps.setString(2, sid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Subject sub = new Subject();
                sub.setSubid(rs.getInt("subid"));
                sub.setSubname(rs.getString("subname"));
                subjects.add(sub);
            }
        } catch (SQLException e) {
        }
        return subjects;
    }

    public Subject getSubjectById(int subid) {
        try {
            String sql = "SELECT * FROM [Subject] s WHERE s.subid = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, subid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Subject sub = new Subject();
                sub.setSubid(rs.getInt("subid"));
                sub.setSubname(rs.getString("subname"));
                return sub;
            }

        } catch (SQLException e) {
        }
        return null;
    }

    public ArrayList<Subject> listByTdeptId(int trid) {
        ArrayList<Subject> subjects = new ArrayList<>();
        try {
            String sql = "SELECT * FROM [Subject] sub JOIN TrainingDepartment td ON td.trid = sub.trid\n"
                    + "	WHERE td.trid = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, trid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Subject sub = new Subject();
                sub.setSubid(rs.getInt("subid"));
                sub.setSubname(rs.getString("subname"));
                subjects.add(sub);
            }
        } catch (SQLException e) {
        }
        return subjects;
    }

    public ArrayList<Subject> getListByPage(ArrayList<Subject> lists, int start, int end) {
        ArrayList<Subject> depts = new ArrayList<>();
        for (int i = start; i < end; i++) {
            depts.add(lists.get(i));
        }
        return depts;
    }

}
