/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.authorization;

import controller.generic.BaseAuthController;
import dal.RoleDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import model.Account;
import model.Role;

/**
 *
 * @author Admin
 */
public abstract class BaseRBACController extends BaseAuthController {

    private ArrayList<Role> getRoles(HttpServletRequest req, Account account) {
        String url = req.getServletPath();
        RoleDBContext rdc = new RoleDBContext();
        return rdc.getbyUsernameAndUrl(account.getUsername(), url);
    }

    protected abstract void doPost(HttpServletRequest req, HttpServletResponse resp, Account account, ArrayList<Role> roles) throws ServletException, IOException;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException {
        ArrayList<Role> roles = getRoles(req, account);
        if (roles.size() < 1) {
            resp.getWriter().println("access denied!");
        }
        else{
            StringBuilder sb = new StringBuilder();
             for (Role role : roles) {
                sb.append(role.getRolename());
                sb.append(" ");
            }
             String roless = sb.toString();
             req.getSession().setAttribute("roles", roless);
            doPost(req, resp, account, roles);
        }
    }

    protected abstract void doGet(HttpServletRequest req, HttpServletResponse resp, Account account, ArrayList<Role> roles) throws ServletException, IOException;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException {
        ArrayList<Role> roles = getRoles(req, account);
        if (roles.size() < 1) {
            resp.getWriter().println("access denied!");
        }
        else{
             StringBuilder sb = new StringBuilder();
             for (Role role : roles) {
                sb.append(role.getRolename());
                sb.append(" ");
            }
             String roless = sb.toString();
             req.getSession().setAttribute("roles", roless);
            doGet(req, resp, account, roles);
        }
    }

}
