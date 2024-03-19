/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import model.Term;
import java.sql.*;

/**
 *
 * @author Admin
 */
public class TermDBContext extends DBContext<Term>{

    @Override
    public ArrayList<Term> listAll() {
        ArrayList<Term> terms = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Term";
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Term term = new Term();
                term.setTeid(rs.getInt("teid"));
                term.setTename(rs.getString("tename"));
                terms.add(term);
            }
        } catch (SQLException e) {
        }
        return terms;
    }

    @Override
    public void insert(Term entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Term entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Term entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
