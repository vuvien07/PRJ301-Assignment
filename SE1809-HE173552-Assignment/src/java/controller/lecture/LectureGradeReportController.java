/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.lecture;

import controller.authorization.BaseRBACController;
import dal.AssesmentDBContext;
import dal.AttendanceDBContext;
import dal.GroupDBContext;
import dal.MarkReportDBContext;
import dal.SessionDBContext;
import dal.StudentDBContext;
import dal.SubjectDBContext;
import dal.TermDBContext;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Account;
import model.Assesment;
import model.Attendance;
import model.Group;
import model.Mark;
import model.Role;
import model.Session;
import model.Student;
import model.Subject;
import model.Term;

/**
 *
 * @author Admin
 */
@WebServlet(name = "LectureGradeReportController", urlPatterns = {"/lecture_grade_report"})
public class LectureGradeReportController extends BaseRBACController {

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
        TermDBContext tdc = new TermDBContext();
        StudentDBContext sddc = new StudentDBContext();
        GroupDBContext gdb = new GroupDBContext();
        SubjectDBContext sdc = new SubjectDBContext();
        AttendanceDBContext atdc = new AttendanceDBContext();
        MarkReportDBContext mrdc = new MarkReportDBContext();
        SessionDBContext ssdc = new SessionDBContext();
        AssesmentDBContext asdc = new AssesmentDBContext();

        ArrayList<Session> sess;
        String subid = request.getParameter("subid");
        String teid_raw = request.getParameter("termid");
        String gid = request.getParameter("gid");
        Account account1 = (Account) request.getSession().getAttribute("account");
        String sid = request.getParameter("sid");
        String lid = account1.getUsername().substring(account1.getUsername().length() - 8);
        ArrayList<Term> terms = tdc.listAll();
        ArrayList<Subject> subjects = null;
        ArrayList<Group> groups;
        ArrayList<String> situations = new ArrayList<>();
        ArrayList<String> statuses = new ArrayList<>();
        ArrayList<Double> absentRates = new ArrayList<>();

        if (teid_raw != null) {
            subjects = sdc.listByTermAndLid(Integer.parseInt(teid_raw), lid);
            request.getSession().setAttribute("termid", teid_raw);
        }

        if (subid != null && teid_raw != null) {
            groups = gdb.listGroupByLidAndSubid(lid.substring(lid.length() - 8), Integer.parseInt(subid), Integer.parseInt(teid_raw));
            request.setAttribute("groups", groups);
            request.setAttribute("subid", subid);
        }

        if (gid != null && subid != null && teid_raw != null) {

            ArrayList<Mark> marks = mrdc.listBySubidAndSubid(null, Integer.parseInt(gid), Integer.parseInt(subid));
            request.setAttribute("marks", marks);

            ArrayList<Student> students
                    = sddc.listGradeBySubIdAndGid(Integer.parseInt(subid), Integer.parseInt(teid_raw), Integer.parseInt(gid));
            for (Student student : students) {
                int sessionAttended = 0;
                sess = ssdc.listSessionByStudentIdAndSubid(student.getSid(), Integer.parseInt(subid), Integer.parseInt(teid_raw));
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
                        = atdc.viewAttendanceByStuIdAndTermid(student.getSid(), Integer.parseInt(subid), Integer.parseInt(teid_raw));
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
                }
            }
            request.setAttribute("students", students);

            ArrayList<Assesment> assessments
                    = asdc.getGradeBySubid(Integer.parseInt(subid), sid);
            float average = 0;
            for (Assesment assessment : assessments) {
                average += assessment.getWeight() * assessment.getGrade().getScore() / 100;
            }
            request.setAttribute("aver", average);
        }

        if (subid != null && sid != null && teid_raw != null) {
            ArrayList<Assesment> assessments
                    = asdc.getGradeBySubid(Integer.parseInt(subid), sid);
            request.setAttribute("assesments", assessments);

            Student stu = sddc.getStuById(sid);
            request.setAttribute("student", stu);

        }

        request.setAttribute("lid", lid);
        request.setAttribute("situations", situations);
        request.setAttribute("statuses", statuses);
        request.setAttribute("absentRates", absentRates);
        request.setAttribute("gid", gid);
        request.setAttribute("sid", sid);
        request.setAttribute("terms", terms);
        request.setAttribute("subjects", subjects);
        request.setAttribute("termid", teid_raw);
        request.setAttribute("terms", terms);
        request.getRequestDispatcher("view/lecture/lecture_grade_report.jsp").forward(request, response);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response,
            Account account, ArrayList<Role> roles)
            throws ServletException, IOException {
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
