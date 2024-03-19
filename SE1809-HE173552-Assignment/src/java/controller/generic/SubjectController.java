/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.generic;

import controller.authorization.BaseRBACController;
import dal.AssesmentDBContext;
import dal.SubjectDBContext;
import dal.TrainingDepartmentDBContext;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.Assesment;
import model.Role;
import model.Subject;
import model.TrainingDepartment;

/**
 *
 * @author Admin
 */
@WebServlet(name = "SubjectController", urlPatterns = {"/subject"})
public class SubjectController extends BaseRBACController {

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
        TrainingDepartmentDBContext tddc = new TrainingDepartmentDBContext();
        SubjectDBContext sdc = new SubjectDBContext();
        List<TrainingDepartment> tdepts = tddc.listAll();
        int size = tdepts.size();
        int page, numPerPage = 5;
        int num = (size % numPerPage == 0 ? (size / numPerPage) : ((size / 6) + 1));
        String xPage = request.getParameter("page");
        String trid = request.getParameter("trid");
        if (trid != null) {
            List<Subject> subjects = sdc.listByTdeptId(Integer.parseInt(trid));
            request.setAttribute("subjects", subjects);
        }
        if (xPage == null) {
            page = 1;
        } else {
            page = Integer.parseInt(xPage);
        }
        int start, end = 0;
        start = (page - 1) * numPerPage;
        end = Math.min(page * numPerPage, size);
        List<TrainingDepartment> tdepts1 = tddc.getListByPage((ArrayList<TrainingDepartment>) tdepts, start, end);
        request.setAttribute("num", num);
        request.setAttribute("page", page);
        request.setAttribute("tdepts", tdepts);
        request.setAttribute("tdepts1", tdepts1);
        request.getRequestDispatcher("view/subject.jsp").forward(request, response);
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
        String subid = request.getParameter("subid");
        AssesmentDBContext adc = new AssesmentDBContext();
        Account saccount = (Account) request.getSession().getAttribute("account");
        ArrayList<Assesment> assesments = adc.getAssesmentBySubid(Integer.parseInt(subid));
        request.setAttribute("assesments", assesments);
        request.getRequestDispatcher("view/subject.jsp").forward(request, response);
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
