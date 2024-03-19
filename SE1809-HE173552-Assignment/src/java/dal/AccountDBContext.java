/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;

/**
 *
 * @author Admin
 */
public class AccountDBContext extends DBContext<Account> {

    @Override
    public ArrayList<Account> listAll() {
        ArrayList<Account> list = new ArrayList<>();
        try {
            String sql = "select * from Account";
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Account a = new Account();
                a.setAccid(rs.getInt("accid"));
                list.add(a);
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public Account getAccount(String username, String password) {
        try {
            String sql = "SELECT a.username, a.password FROM Account a WHERE a.username = ? AND a.password = ?";

            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Account a = new Account();
                a.setUsername(rs.getString("username"));
                a.setPassword(rs.getString("password"));
                return a;
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public Account getAccountByUsername(String username) {
        try {
            String sql = "SELECT * FROM Account a JOIN Account_Role ar ON a.accid = ar.accid JOIN [Role] r ON r.roleid = ar.roleid WHERE\n"
                    + "	a.username = ?";

            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                StringBuilder sb = new StringBuilder();
                Account a = new Account();
                a.setAccid(rs.getInt("accid"));
                a.setUsername(rs.getString("username"));
                a.setPassword(rs.getString("password"));
                sb.append(rs.getString("rolename") + " ");
                a.setRoleAccount(sb.toString());
                return a;
            }
        } catch (SQLException e) {
        }
        return null;
    }
    
     public Account getAccountByUser(String username) {
        try {
            String sql = "SELECT * FROM Account a WHERE\n"
                    + "	a.username = ?";

            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                StringBuilder sb = new StringBuilder();
                Account a = new Account();
                a.setAccid(rs.getInt("accid"));
                a.setUsername(rs.getString("username"));
                a.setPassword(rs.getString("password"));
                a.setRoleAccount(sb.toString());
                return a;
            }
        } catch (SQLException e) {
        }
        return null;
    }

    @Override
    public void insert(Account entity) {
        String sql = "INSERT INTO Account VALUES(?, ?)";
        PreparedStatement ps;
        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, entity.getUsername());
            ps.setString(2, entity.getPassword());
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    @Override
    public void update(Account entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Account entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public static void main(String[] args) {
        AccountDBContext acc = new AccountDBContext();
        System.out.println(acc.connection);
        java.sql.Date d = java.sql.Date.valueOf(LocalDate.now());
        System.out.println(d);
    }

    public ArrayList<Account> getAccountsBySearch(String username) {
        ArrayList<Account> accounts = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Account a JOIN Account_Role ar ON a.accid = ar.accid JOIN [Role] r ON r.roleid = ar.roleid WHERE\n"
                    + "a.username LIKE '%' + ? + '%' AND  a.username != 'admin'";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                StringBuilder sb = new StringBuilder();
                Account a = new Account();
                a.setUsername(rs.getString("username"));
                a.setPassword(rs.getString("password"));
                sb.append(rs.getString("rolename")).append(" ");
                a.setRoleAccount(sb.toString());
                accounts.add(a);
            }
        } catch (SQLException e) {
        }
        return accounts;
    }
    
      public ArrayList<Account> getListByPage(ArrayList<Account> lists, int start, int end) {
       ArrayList<Account> depts= new ArrayList<>();
        for (int i = start; i < end; i++) {
            depts.add(lists.get(i));
        }
        return depts;
    }
}
