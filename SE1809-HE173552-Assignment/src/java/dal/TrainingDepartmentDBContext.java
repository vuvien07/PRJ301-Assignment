/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import model.TrainingDepartment;
import java.sql.*;

/**
 *
 * @author Admin
 */
public class TrainingDepartmentDBContext extends DBContext<TrainingDepartment> {

    @Override
    public ArrayList<TrainingDepartment> listAll() {
        ArrayList<TrainingDepartment> depts = new ArrayList<>();
        try {
            String sql = "SELECT * FROM TrainingDepartment";
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                TrainingDepartment td = new TrainingDepartment();
                td.setTrid(rs.getInt("trid"));
                td.setTrname(rs.getString("trname"));
                depts.add(td);
            }
        } catch (SQLException e) {
        }
        return depts;
    }

    @Override
    public void insert(TrainingDepartment entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(TrainingDepartment entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(TrainingDepartment entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public ArrayList<TrainingDepartment> getListByPage(ArrayList<TrainingDepartment> lists, int start, int end) {
       ArrayList<TrainingDepartment> depts= new ArrayList<>();
        for (int i = start; i < end; i++) {
            depts.add(lists.get(i));
        }
        return depts;
    }

}
