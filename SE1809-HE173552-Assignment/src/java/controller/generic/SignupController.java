/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.generic;

import dal.AccountDBContext;
import dal.Account_RoleDBContext;
import dal.LectureDBContext;
import dal.RoleDBContext;
import dal.StudentDBContext;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.Lecturer;
import model.Role;
import model.Student;

/**
 *
 * @author Admin
 */
@WebServlet(name = "SignupController", urlPatterns = {"/sign-up"})
public class SignupController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RoleDBContext rdc = new RoleDBContext();
        ArrayList<Role> roles = rdc.listAll();
        request.setAttribute("roles", roles);
        request.getRequestDispatcher("view/register.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Account_RoleDBContext ardc = new Account_RoleDBContext();
        String nums = "0123456789";
        Random rand = new Random();
        String fullname = request.getParameter("fullname");
        String role = request.getParameter("role");
        String password = request.getParameter("password");
        StringBuilder sb = new StringBuilder();
        String path[] = fullname.split(" ");
        int majorid = 0;
        if (role.equals("2")) {
            String major = request.getParameter("major");
            switch (major) {
                case "BA" -> {
                    sb.append("HS");
                    majorid = 3;
                }
                case "AI" -> {
                    sb.append("AI");
                    majorid = 4;
                }
                case "IT" -> {
                    sb.append("HE");
                    majorid = 1;
                }
                default -> {
                    sb.append("HE");
                    majorid = 2;
                }
            }
            for (int i = 0; i < 6; i++) {
                sb.append(nums.charAt(rand.nextInt(nums.length() - 1)));
            }
            try {
                StudentDBContext sdc = new StudentDBContext();
                AccountDBContext adc = new AccountDBContext();
                if (!sdc.isExistStudent(sb.toString())) {
                    Account a = new Account();
                    a.setUsername(path[2] + path[0].charAt(0) + path[1].charAt(0) + sb.toString());
                    a.setPassword(password);
                    adc.insert(a);
                    ArrayList<Account> list = adc.listAll();
                    Student s = new Student();
                    s.setSid(sb.toString());
                    s.setSname(fullname);
                    s.setEmail(path[2] + path[0].charAt(0) + path[1].charAt(0) + sb.toString() + "@fpt.edu.vn");
                    s.setSaccid(list.get(list.size() - 1).getAccid());
                    s.setMaid(majorid);
                    sdc.insert(s);
                    Account acc = adc.getAccountByUser(a.getUsername());
                    ardc.insert(acc.getAccid(), Integer.parseInt(role));
                }
            } catch (Exception e) {
            }
        } else {
            sb.append("FU");
            for (int i = 0; i < 6; i++) {
                sb.append(nums.charAt(rand.nextInt(nums.length() - 1)));
            }
            LectureDBContext ldc = new LectureDBContext();
            AccountDBContext adc = new AccountDBContext();
            if (!ldc.isExistLecturer(sb.toString())) {

                Account a = new Account();
                a.setUsername(path[2] + path[0].charAt(0) + path[1].charAt(0) + sb.toString());
                a.setPassword(password);
                adc.insert(a);
                ArrayList<Account> list = adc.listAll();
                Lecturer lec = new Lecturer();
                lec.setLid(sb.toString());
                lec.setLname(fullname);
                lec.setEmail(path[2] + path[0].charAt(0) + path[1].charAt(0) + sb.toString() + "@fu.edu.vn");
                lec.setLaccid(list.get(list.size() - 1).getAccid());
                ldc.insert(lec);
                Account acc = adc.getAccountByUser(a.getUsername());
                try {
                    ardc.insert(acc.getAccid(), Integer.parseInt(role));
                } catch (SQLException ex) {
                    Logger.getLogger(SignupController.class.getName()).log(Level.SEVERE, null, ex);
                }

            }
        }

        request.setAttribute("success", "Sign up sucessfully!<a href='login'>Back to login</a>");
        request.getRequestDispatcher("view/register.jsp").forward(request, response);

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
