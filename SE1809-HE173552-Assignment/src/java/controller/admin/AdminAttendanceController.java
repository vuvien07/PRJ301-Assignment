/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import controller.authorization.BaseRBACController;
import dal.AttendanceDBContext;
import dal.SessionDBContext;
import dal.StudentDBContext;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Account;
import model.Attendance;
import model.Role;
import model.Session;
import model.Student;

/**
 *
 * @author Admin
 */
public class AdminAttendanceController extends BaseRBACController {

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
        String page = request.getParameter("page");
        String userid = request.getParameter("userid");
        String userid1 = request.getParameter("userid1");
        SessionDBContext ssdc = new SessionDBContext();
        String sesid = request.getParameter("sesid");
        ArrayList<Attendance> atts = ssdc.getAttendanceBySesId(Integer.parseInt(sesid));
        request.setAttribute("atts", atts);
        request.setAttribute("sesid", sesid);
        request.setAttribute("page", page);
        request.setAttribute("userid", userid);
         request.setAttribute("userid1", userid1);
        request.getRequestDispatcher("view/admin/admin_attendance.jsp").forward(request, response);
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
        String week = (String) request.getSession().getAttribute("weeks");
        String page = request.getParameter("page");
        String userid = request.getParameter("userid");
        String userid1 = request.getParameter("userid1");
        int sesid = Integer.parseInt(request.getParameter("sesid"));
        StudentDBContext sdc = new StudentDBContext();
        SessionDBContext ssdc = new SessionDBContext();
        ArrayList<Student> students = sdc.listBySession(sesid);
        ArrayList<Attendance> atts = new ArrayList<>();
        Session session = new Session();
        session.setSesid(sesid);
        for (Student student : students) {
            Attendance att = new Attendance();
            att.setSession(session);
            att.setStudent(student);
            att.setStatus(request.getParameter("present" + student.getSid())
                    .equals("yes") ? "Present" : "Absent");
            att.setDescription(request.getParameter("description" + student.getSid()));
            atts.add(att);
        }
        AttendanceDBContext adc = new AttendanceDBContext();
        adc.patchupdateByLesson(sesid, atts);
        request.getSession().removeAttribute("sessions");
        response.sendRedirect("admin_timetable?page=" + page + "&userid=" + userid + "&weeks=" + week + "&userid1=" + userid1);
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
