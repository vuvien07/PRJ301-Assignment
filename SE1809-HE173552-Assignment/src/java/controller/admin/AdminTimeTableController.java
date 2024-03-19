/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import controller.authorization.BaseRBACController;
import dal.AccountDBContext;
import dal.LectureDBContext;
import dal.RoleDBContext;
import dal.SessionDBContext;
import dal.SlotDBContext;
import dal.StudentDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Map;
import model.Account;
import model.Lecturer;
import model.Role;
import model.Session;
import model.Slot;
import model.Student;
import util.DateTimeTool;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AdminTimeTableController", urlPatterns = {"/admin_timetable"})
public class AdminTimeTableController extends BaseRBACController {

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
     * @param account
     * @param roles
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, Account account, ArrayList<Role> roles)
            throws ServletException, IOException {
        request.getSession().removeAttribute("sessions");
        String year = request.getParameter("year");
        Map<java.sql.Date, java.sql.Date> week_on_year;
        ArrayList<Slot> slots;
        SlotDBContext sdc = new SlotDBContext();
        SessionDBContext ssdc = new SessionDBContext();
        if (year == null) {
            week_on_year = DateTimeTool.getWeeksByYear(2023);
             request.setAttribute("year", "2023");
        } else {
            week_on_year = DateTimeTool.getWeeksByYear(Integer.parseInt(year));
            switch (year) {
                case "2023":
                    request.setAttribute("year", "2023");
                    break;
                case "2024":
                    request.setAttribute("year", "2024");
                    break;
            }
        }
        slots = sdc.listAll();
        request.getSession().setAttribute("slots", slots);
        request.getSession().setAttribute("week_on_year", week_on_year);
        AccountDBContext adc = new AccountDBContext();
        RoleDBContext rdc = new RoleDBContext();
        String userid = request.getParameter("userid");
        if (userid != null) {
            ArrayList<Account> accounts = adc.getAccountsBySearch(userid);
            int size = accounts.size();
            int page, numPerPage = 5;
            int num = (size % numPerPage == 0 ? (size / numPerPage) : ((size / 6) + 1));
            String xPage = request.getParameter("page");
            if (xPage == null) {
                page = 1;
            } else {
                page = Integer.parseInt(xPage);
            }
            int start, end = 0;
            start = (page - 1) * numPerPage;
            end = Math.min(page * numPerPage, size);

            ArrayList<Account> pageTimetable = adc.getListByPage(accounts, start, end);
            request.getSession().setAttribute("search_accounts", pageTimetable);
            request.setAttribute("num", num);
            request.setAttribute("page", page);
        }

        String userid1 = request.getParameter("userid1");
        Account a = adc.getAccountByUsername(userid1);
        if (a != null) {
            request.getSession().setAttribute("search_account", a);
        }

        String week = request.getParameter("weeks");
        if (week != null && !week.equals("")) {
            request.setAttribute("weef", week.split(" ")[0]);
            String weekss[] = week.split(" ");
            java.sql.Date from = java.sql.Date.valueOf(weekss[0]);
            java.sql.Date to = java.sql.Date.valueOf(weekss[1]);
            ArrayList<java.sql.Date> dates = DateTimeTool.getDatesBetween(from, to);
            Account a1 = (Account) request.getSession().getAttribute("search_account");
            String roless = a1.getRoleAccount();
            LectureDBContext ldc = new LectureDBContext();
            StudentDBContext stdc = new StudentDBContext();

            ArrayList<Session> sessions;
            if (roless.contains("Lecturer")) {
                Lecturer lec = ldc.getLecByUserId(userid1);
                sessions = ssdc.listBy(lec.getLid(), "Lecturer", from, to);
            } else {
                Student student = stdc.getStuByUserId(userid1);
                sessions = ssdc.listBy(student.getSid(), "Student", from, to);
            }
            
            request.getSession().setAttribute("dates", dates);
            request.getSession().setAttribute("fromdate", weekss[0]);
            request.setAttribute("selectedfromdate", "selected");
            request.getSession().setAttribute("sessions", sessions);
            request.setAttribute("uu", "selected");
            request.setAttribute("uu1", "selected");
        }
          request.setAttribute("userid1", userid1);
        request.setAttribute("userid", userid);
        request.getSession().setAttribute("weeks", week);

        request.getRequestDispatcher("view/admin/admin_timetable.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @param account
     * @param roles
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, Account account, ArrayList<Role> roles)
            throws ServletException, IOException {
    }
}
