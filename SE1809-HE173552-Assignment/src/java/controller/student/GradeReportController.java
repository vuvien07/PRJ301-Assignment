/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.student;

import controller.authorization.BaseRBACController;
import dal.AssesmentDBContext;
import dal.AttendanceDBContext;
import dal.MarkReportDBContext;
import dal.SessionDBContext;
import dal.StudentDBContext;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Account;
import model.Assesment;
import model.Attendance;
import model.Mark;
import model.Role;
import model.Session;
import model.Student;

/**
 *
 * @author Admin
 */
@WebServlet(name = "GradeReportController", urlPatterns = {"/grade_report"})
public class GradeReportController extends BaseRBACController {

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
        MarkReportDBContext mrdc = new MarkReportDBContext();
        AssesmentDBContext adc = new AssesmentDBContext();
        SessionDBContext sdc = new SessionDBContext();
        AttendanceDBContext atdc = new AttendanceDBContext();
        StudentDBContext stdc = new StudentDBContext();

        ArrayList<Session> sess;
        Account saccount = (Account) request.getSession().getAttribute("account");
        String subid = request.getParameter("subid");
        String sid = saccount.getUsername().substring(saccount.getUsername().length() - 8);
        String termid = request.getParameter("teid");
        ArrayList<Mark> marks = mrdc.listBySubidAndSubid(sid, 0, 0);
        ArrayList<String> str = new ArrayList<>();
        ArrayList<String> situations = new ArrayList<>();
        ArrayList<String> statuses = new ArrayList<>();
        ArrayList<Double> absentRates = new ArrayList<>();

        for (Mark mark : marks) {
            int sessionAttended = 0;
            sess = sdc.listSessionByStudentIdAndSubid(sid, mark.getSubject().getSubid(), mark.getTerm().getTeid());
            for (Session ses : sess) {
                if (ses.isIsAttended()) {
                    sessionAttended++;
                }
            }
            if (!sess.isEmpty() && sessionAttended != sess.size()) {
                situations.add("Studying");
            } else if (sessionAttended == sess.size()) {
                situations.add("Studied");
            } else {
                situations.add("Not started");
            }
            ArrayList<Attendance> attendances
                    = atdc.viewAttendanceByStuIdAndTermid(sid, mark.getSubject().getSubid(), mark.getTerm().getTeid());
            if (attendances != null) {
                int numOfAbsent = 0;
                double absentRate = 0;
                for (Attendance attendance : attendances) {
                    if (attendance.getStatus() == null) {
                        continue;
                    }
                    if (attendance.getStatus().equals("Absent")) {
                        numOfAbsent++;
                    }
                }
                absentRate = (numOfAbsent * 1.0 / attendances.size()) * 100;
                absentRates.add(absentRate);

                ArrayList<Assesment> assessments
                        = adc.getGradeBySubid(mark.getSubject().getSubid(), sid);
                float average = 0;
                for (Assesment assessment : assessments) {
                    average += assessment.getWeight() * assessment.getGrade().getScore() / 100;
                }
                str.add(average + "");
                if (absentRate > 20 || average < 5) {
                    statuses.add("Not passed");
                } else {
                    statuses.add("Passed");
                }
            }

        }

        if (subid != null && sid != null && termid != null) {
            Student student = stdc.getStuById(sid);
            String count1 = request.getParameter("count1");
            ArrayList<Assesment> assessments
                    = adc.getGradeBySubid(Integer.parseInt(subid), sid);
            request.setAttribute("assesments", assessments);
            request.setAttribute("count1", count1);
            request.setAttribute("student", student);
        }

        request.setAttribute("absentRates", absentRates);
        request.setAttribute("situations", situations);
        request.setAttribute("str", str);
        request.setAttribute("statuses", statuses);
        request.setAttribute("marks", marks);
        request.getRequestDispatcher("view/grade_report.jsp").forward(request, response);
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
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
