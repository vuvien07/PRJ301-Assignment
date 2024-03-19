/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import model.Role;
import java.sql.*;

/**
 *
 * @author Admin
 */
public class RoleDBContext extends DBContext<Role> {

    public ArrayList<Role> getbyUsernameAndUrl(String username, String url) {
        ArrayList<Role> roles = new ArrayList<>();
        try {
            String sql = "SELECT r.roleid, r.rolename FROM Account a "
                    + "JOIN Account_Role ar ON a.accid = ar.accid\n"
                    + "JOIN [Role] r ON r.roleid = ar.roleid JOIN Role_Feature rf ON r.roleid = rf.roleid\n"
                    + "JOIN Feature f ON f.feaid = rf.feaid WHERE a.username = ? AND f.[url] = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, url);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Role r = new Role();
                r.setRoleid(rs.getInt("roleid"));
                r.setRolename(rs.getString("rolename"));
                roles.add(r);
            }
        } catch (SQLException e) {
        }
        return roles;
    }

    @Override
    public ArrayList<Role> listAll() {
        ArrayList<Role> roles = new ArrayList<>();
        try {
            String sql = "SELECT * FROM [Role] r WHERE r.rolename != 'Admin'";
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
               Role role = new Role();
               role.setRoleid(rs.getInt("roleid"));
               role.setRolename(rs.getString("rolename"));
               roles.add(role);
            }
        } catch (SQLException e) {
        }
        return roles;
    }

    @Override
    public void insert(Role entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Role entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Role entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public static void main(String[] args) {
        RoleDBContext a = new RoleDBContext();
        ArrayList<Role> roles = a.getbyUsernameAndUrl("AnhKDFU484522", "/timetable");
        StringBuilder sb = new StringBuilder();
        for (Role role : roles) {
            sb.append(role.getRolename());
            sb.append(" ");
        }
        String roless = sb.toString();
        System.out.println(roless);
        System.out.println(roless.contains("Lecturer"));
    }

}
