/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.sql.*;

/**
 *
 * @author Admin
 */
public class Account_RoleDBContext extends DBContext<Object>{

    @Override
    public ArrayList<Object> listAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void insert(Object entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Object entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Object entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    public void insert(int accid, int roleid) throws SQLException{
        try {
            connection.setAutoCommit(false);
            String sql = "INSERT INTO Account_Role(accid, roleid) VALUES(?, ?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, accid);
            ps.setInt(2, roleid);
            ps.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            connection.rollback();
        }finally{
            connection.setAutoCommit(true);
        }
    }
    
}
