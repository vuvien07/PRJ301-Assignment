/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import model.Assesment;
import java.sql.*;
import java.text.DecimalFormat;
import model.Grade;
import model.Subject;

/**
 *
 * @author Admin
 */
public class AssesmentDBContext extends DBContext<Assesment> {

    @Override
    public ArrayList<Assesment> listAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void insert(Assesment entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Assesment entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Assesment entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public ArrayList<Assesment> getGradeBySubid(int subid, String sid) {
        ArrayList<Assesment> assesments = new ArrayList<>();
        DecimalFormat df = new DecimalFormat("#.#");
        try {
            String sql = "SELECT ass.asid, ass.asname, ass.[weight], ass.[description], sub.subname, g.score FROM [Subject] sub JOIN Assesment ass ON sub.subid = ass.subid\n"
                    + "JOIN [Group] gr ON sub.subid = gr.subid JOIN Group_Student gs ON gr.gid = gs.gid\n"
                    + "JOIN Student stu ON stu.[sid] = gs.[sid] LEFT JOIN Grade g ON ass.asid = g.asid AND sub.subid = g.subid\n"
                    + "AND stu.[sid] = g.[sid] \n"
                    + "WHERE sub.subid = ? AND stu.[sid] = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, subid);
            ps.setString(2, sid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Assesment ass = new Assesment();
                ass.setAsid(rs.getInt("asid"));
                ass.setAsname(rs.getString("asname"));
                ass.setWeight(rs.getInt("weight"));
                if (rs.getString("description") != null) {
                    String description = rs.getString("description");
                    String descriptions[] = description.split("-");
                    ass.setDescriptions(descriptions);
                }
                Subject sub = new Subject();
                sub.setSubname(rs.getString("subname"));
                ass.setSubject(sub);
                Grade g = new Grade();
                String formattedGrade = df.format(rs.getFloat("score"));
                g.setScore(Float.parseFloat(formattedGrade));
                ass.setGrade(g);
                assesments.add(ass);
            }
        } catch (SQLException e) {
        }
        return assesments;
    }

    public ArrayList<Assesment> getAssesmentBySubid(int subid) {
        ArrayList<Assesment> assesments = new ArrayList<>();
        DecimalFormat df = new DecimalFormat("#.#");
        try {
            String sql = "SELECT  ass.asid, ass.asname, ass.[weight], ass.[description], sub.subname FROM [Subject] sub JOIN Assesment ass ON sub.subid = ass.subid\n"
                    + "WHERE sub.subid = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, subid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Assesment ass = new Assesment();
                ass.setAsid(rs.getInt("asid"));
                ass.setAsname(rs.getString("asname"));
                ass.setWeight(rs.getInt("weight"));
                if (rs.getString("description") != null) {
                    String description = rs.getString("description");
                    String descriptions[] = description.split("-");
                    ass.setDescriptions(descriptions);
                }
                Subject sub = new Subject();
                sub.setSubname(rs.getString("subname"));
                ass.setSubject(sub);
                assesments.add(ass);
            }
        } catch (SQLException e) {
        }
        return assesments;
    }

}
