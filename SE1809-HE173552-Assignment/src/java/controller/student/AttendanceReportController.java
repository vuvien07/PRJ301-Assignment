/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.student;

import controller.authorization.BaseRBACController;
import dal.AttendanceDBContext;
import dal.SubjectDBContext;
import dal.TermDBContext;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.DecimalFormat;
import java.util.ArrayList;
import model.Account;
import model.Attendance;
import model.Role;
import model.Subject;
import model.Term;

/**
 *
 * @author Admin
 */
public class AttendanceReportController extends BaseRBACController {

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
        String teid_raw = request.getParameter("termid");
        SubjectDBContext sdc = new SubjectDBContext();
        TermDBContext tdc = new TermDBContext();
        ArrayList<Term> terms = tdc.listAll();
        ArrayList<Subject> subjects = null;
        AttendanceDBContext adc = new AttendanceDBContext();
        String sid = request.getParameter("sid");
        if (teid_raw != null) {
            subjects = sdc.listByTermId(Integer.parseInt(teid_raw), sid);
        }
        String subid = request.getParameter("subid");
        int numOfAbsent = 0;
        double absentRate = 0;
        DecimalFormat df = new DecimalFormat("#.##");
        if (sid != null && subid != null && teid_raw != null) {
            ArrayList<Attendance> attendances = adc.viewAttendanceByStuIdAndTermid(request.getParameter("sid"),
                    Integer.parseInt(subid), Integer.parseInt(teid_raw));
            if (attendances != null) {
                for (Attendance attendance : attendances) {
                    if (attendance.getStatus() == null) {
                        continue;
                    }
                    if (attendance.getStatus().equals("Absent")) {
                        numOfAbsent++;
                    }
                }
                absentRate = (numOfAbsent * 1.0 / attendances.size()) * 100;
                request.setAttribute("attendances", attendances);
            }
        }
        request.setAttribute("rate", df.format(absentRate));
        request.setAttribute("absent", numOfAbsent);
        request.setAttribute("terms", terms);
        request.setAttribute("subjects", subjects);
        request.setAttribute("termid", teid_raw);
        request.getRequestDispatcher("view/attendance_report.jsp").forward(request, response);
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

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
