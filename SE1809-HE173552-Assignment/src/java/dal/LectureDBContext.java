/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.*;
import java.util.ArrayList;
import model.Lecturer;

/**
 *
 * @author Admin
 */
public class LectureDBContext extends DBContext<Lecturer> {

    @Override
    public ArrayList<Lecturer> listAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void insert(Lecturer entity) {
        try {
            String sql = "INSERT INTO Lecture VALUES(?, ?, ?, ?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, entity.getLid());
            ps.setString(2, entity.getLname());
            ps.setString(3, entity.getEmail());
            ps.setInt(4, entity.getLaccid());
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    @Override
    public void update(Lecturer entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Lecturer entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public boolean isExistLecturer(String lid) {
        try {
            String sql = "SELECT  * FROM Lecture l WHERE l.lid = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, lid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
        }
        return false;
    }

    public Lecturer getLecByUserId(String username) {
        try {
            String sql = "SELECT * FROM Lecture l JOIN Account a ON a.accid = l.laccid\n"
                    + "WHERE a.username = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                Lecturer lec = new Lecturer();
                lec.setLid(rs.getString("lid"));
                lec.setLname(rs.getString("lname"));
                return lec;
            }
        } catch (SQLException e) {
        }
        return null;
    }
}
