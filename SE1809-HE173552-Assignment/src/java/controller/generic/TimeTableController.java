/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.generic;

import controller.authorization.BaseRBACController;
import dal.LectureDBContext;
import dal.SessionDBContext;
import dal.SlotDBContext;
import java.io.IOException;
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
import util.DateTimeTool;

/**
 *
 * @author Admin
 */
@WebServlet(name = "TimeTableController", urlPatterns = {"/timetable"})
public class TimeTableController extends BaseRBACController {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
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
        Map<java.sql.Date, java.sql.Date> weeks_on_year;
        ArrayList<Slot> slots;
        SlotDBContext sdc = new SlotDBContext();
        if (year == null) {
            weeks_on_year = DateTimeTool.getWeeksByYear(2023);
            request.getSession().setAttribute("year", "2023");
        } else {
            weeks_on_year = DateTimeTool.getWeeksByYear(Integer.parseInt(year));
            switch (year) {
                case "2023":
                    request.getSession().setAttribute("year", "2023");
                    break;
                case "2024":
                    request.getSession().setAttribute("year", "2024");
                    break;
            }
        }
        slots = sdc.listAll();
        request.getSession().setAttribute("slots", slots);
        request.getSession().setAttribute("weeks_on_year", weeks_on_year);
        request.getRequestDispatcher("view/timetable.jsp").forward(request, response);

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
        request.getSession().removeAttribute("sessions");
        String week = request.getParameter("weeks");
        SessionDBContext sdc = new SessionDBContext();
        request.setAttribute("weef", week.split(" ")[0]);
        String weeks[] = week.split(" ");
        java.sql.Date from = java.sql.Date.valueOf(weeks[0]);
        java.sql.Date to = java.sql.Date.valueOf(weeks[1]);
        ArrayList<java.sql.Date> dates = DateTimeTool.getDatesBetween(from, to);
        String username = "";
        String roless = (String) request.getSession().getAttribute("roles");
        LectureDBContext ldc = new LectureDBContext();
        Account a = (Account) request.getSession().getAttribute("account");

        ArrayList<Session> sessions;
        if (roless.contains("Lecturer")) {
            Lecturer lec = ldc.getLecByUserId(username);
            sessions = sdc.listBy(a.getUsername().substring(a.getUsername().length() - 8), "Lecturer", from, to);
        } else {
            sessions = sdc.listBy(a.getUsername().substring(a.getUsername().length() - 8), "Student", from, to);
        }
        request.getSession().setAttribute("weeks", week);
        request.getSession().setAttribute("dates", dates);
        request.getSession().setAttribute("fromdate", weeks[0]);
        request.setAttribute("selectedfromdate", "selected");
        request.getSession().setAttribute("sessions", sessions);
        request.setAttribute("uu", "selected");
        request.setAttribute("uu1", "selected");

        request.getRequestDispatcher("view/timetable.jsp").forward(request, response);
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
