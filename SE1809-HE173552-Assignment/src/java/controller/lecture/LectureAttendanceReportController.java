/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.lecture;

import controller.authorization.BaseRBACController;
import dal.AttendanceDBContext;
import dal.GroupDBContext;
import dal.StudentDBContext;
import dal.SubjectDBContext;
import dal.TermDBContext;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.DecimalFormat;
import java.util.ArrayList;
import model.Account;
import model.Attendance;
import model.Group;
import model.Role;
import model.Student;
import model.Subject;
import model.Term;

/**
 *
 * @author Admin
 */
@WebServlet(name = "LectureAttendanceReportController", urlPatterns = "/lecture_attendance_report")
public class LectureAttendanceReportController extends BaseRBACController {

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

        String subid = request.getParameter("subid");
        String teid_raw = request.getParameter("termid");
        String gid = request.getParameter("gid");
        Account account1 = (Account) request.getSession().getAttribute("account");
        String sid = request.getParameter("sid");
        int numOfAbsent = 0;
        double absentRate = 0;
        DecimalFormat df = new DecimalFormat("#.##");
        
        StudentDBContext sddc = new StudentDBContext();
        GroupDBContext gdb = new GroupDBContext();
        SubjectDBContext sdc = new SubjectDBContext();
        TermDBContext tdc = new TermDBContext();
        AttendanceDBContext adc = new AttendanceDBContext();

        String lid = account1.getUsername();
        ArrayList<Group> groups;

        if (subid != null && teid_raw != null) {
            groups = gdb.listGroupByLidAndSubid(lid.substring(lid.length() - 8), Integer.parseInt(subid), Integer.parseInt(teid_raw));
            request.setAttribute("groups", groups);
            request.setAttribute("subid", subid);
        }

        ArrayList<Term> terms = tdc.listAll();
        ArrayList<Subject> subjects = null;
        if (teid_raw != null) {
            subjects = sdc.listByTermAndLid(Integer.parseInt(teid_raw), lid.substring(lid.length() - 8));
            request.getSession().setAttribute("termid", teid_raw);
        }

        if (subid != null && gid != null && teid_raw != null) {
            ArrayList<Attendance> attendances = adc
                    .getAttendanceByGroup(lid.substring(lid.length() - 8), Integer.parseInt(subid), Integer.parseInt(teid_raw), Integer.parseInt(gid));
            request.setAttribute("attendances", attendances);
            Subject sub = sdc.getSubjectById(Integer.parseInt(subid));
            request.setAttribute("subject", sub);
        }

        if (sid != null && subid != null && teid_raw != null) {
            Student stu = sddc.getStuById(sid);
            ArrayList<Attendance> student_attendances = adc.viewAttendanceByStuIdAndTermid(sid,
                    Integer.parseInt(subid), Integer.parseInt(teid_raw));
            if (!student_attendances.isEmpty()) {
                for (Attendance attendance : student_attendances) {
                    if (attendance.getStatus() == null) {
                        continue;
                    }
                    if (attendance.getStatus().equals("Absent")) {
                        numOfAbsent++;
                    }
                }
                absentRate = (numOfAbsent * 1.0 / student_attendances.size()) * 100;
                request.setAttribute("student", stu);
                request.setAttribute("student_attendances", student_attendances);
                request.setAttribute("rate", df.format(absentRate));
                request.setAttribute("absent", numOfAbsent);
            }
        }

        request.setAttribute("gid", gid);
        request.setAttribute("sid", sid);
        request.setAttribute("terms", terms);
        request.setAttribute("subjects", subjects);
        request.setAttribute("termid", teid_raw);
        request.getRequestDispatcher("view/lecture/lecture_attendance_report.jsp").forward(request, response);
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
        processRequest(request, response);
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
