/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import model.Group;
import java.sql.*;
import model.Lecturer;
import model.Term;

/**
 *
 * @author Admin
 */
public class GroupDBContext extends DBContext<Group> {

    @Override
    public ArrayList<Group> listAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void insert(Group entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Group entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Group entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public ArrayList<Group> listGroupByLidAndSubid(String lid, int subid, int teid) {
        ArrayList<Group> groups = new ArrayList<>();
        try {
            String sql = "SELECT g.gid, g.gname FROM [Group] g INNER JOIN Lecture l ON l.lid = g.pic\n"
                    + "INNER JOIN [Subject] sub ON sub.subid = g.subid\n"
                    + "WHERE l.lid = ? AND sub.subid = ? AND g.teid = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, lid);
            ps.setInt(2, subid);
            ps.setInt(3, teid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Group g = new Group();
                g.setGid(rs.getInt("gid"));
                g.setGname(rs.getString("gname"));
                groups.add(g);
            }
        } catch (SQLException e) {
        }
        return groups;
    }
    
    public ArrayList<Group> listGroupBySubid(int subid) {
        ArrayList<Group> groups = new ArrayList<>();
        try {
            String sql = "SELECT g.gid, g.gname, l.lid, l.lname, g.teid FROM [Group] g INNER JOIN Lecture l ON l.lid = g.pic\n"
                    + "INNER JOIN [Subject] sub ON sub.subid = g.subid\n"
                    + "WHERE sub.subid = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, subid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Lecturer l = new Lecturer();
                l.setLid(rs.getString("lid"));
                l.setLname(rs.getString("lname"));
                Term t = new Term();
                t.setTeid(rs.getInt("teid"));
                Group g = new Group();
                g.setGid(rs.getInt("gid"));
                g.setGname(rs.getString("gname"));
                g.setLecturer(l);
                g.setTerm(t);
                groups.add(g);
            }
        } catch (SQLException e) {
        }
        return groups;
    }
}
