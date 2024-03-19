/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.generic;

import dal.AccountDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import model.Account;

/**
 *
 * @author Admin
 */
public abstract class BaseAuthController extends HttpServlet {

    private Account getAuthentication(HttpServletRequest req) {
        Account account = (Account) req.getSession().getAttribute("account");
        return account;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Your session has been time out.Back to <a href='login'>login</a></h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    /**
     *
     * @param req
     * @param resp
     * @param account
     * @throws ServletException
     * @throws IOException
     */
    protected abstract void doPost(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException;

    protected abstract void doGet(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Account account = getAuthentication(req);
        if (account != null) {
            doPost(req, resp, account);
            req.getSession().setMaxInactiveInterval(10000);
            if (req.getSession().getMaxInactiveInterval() == 0) {
                processRequest(req, resp);
            }
        } else {
            resp.getWriter().println("Access Denied!");
             req.getRequestDispatcher("view/login.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Account account = getAuthentication(req);
        if (account != null) {
            doGet(req, resp, account);
            req.getSession().setMaxInactiveInterval(10000);
        } else {
            resp.getWriter().println("Access Denied!");
             req.getRequestDispatcher("view/login.jsp").forward(req, resp);
        }
    }

}
