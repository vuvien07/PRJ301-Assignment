<%-- 
    Document   : signup
    Created on : Feb 27, 2024, 10:29:23 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/register.css">
        <script src="${pageContext.request.contextPath}/js/register.js"></script>
    </head>
    <body>
        <div class="container ass">
            <div class="image">
                <img src="image/Logo_FPT_Education.png" alt="alt" onclick="window.location.href = 'login'"/>
            </div>
            <span id="error"></span>
            <span id="sucess">${requestScope.success}</span>
            <form class="forms" action="sign-up" onsubmit="checkPassword(event)" method="post">
                <div>
                    <h1>Sign up</h1>
                </div>
                <div class="form-group full-name">
                    <label>Enter full name:</label>
                    <input type="text" name="fullname" pattern="^[A-Z][a-z]* (?:[A-Z][a-z]* ){1}[A-Z][a-z]*$" required>
                </div>
                <div class="role01">
                    <label>Select role:</label>
                    <select id="role" name="role" onchange="displayMajor()">
                        <c:forEach var="r" items="${requestScope.roles}">
                            <option value="${r.roleid}">${r.rolename}</option>
                        </c:forEach>
                    </select><br>
                    <div id="select-major">
                        <label>Select major:</label>
                        <select id="major" name="major">
                            <option value="IT">Information Technology</option>
                            <option value="GD">Graphic Design</option>
                            <option value="BA">Business Administration</option>
                            <option value="AI">Artificial Intelligence</option>
                        </select>
                    </div>

                </div>
                <!--                <div class="phone">
                                    <label>Enter phone number:</label>
                                    <input id="phone" type="text" name="phone" required pattern="[0-9]{10}" title="Phone number must be 10 digits">
                                </div>-->
                <div class="form-group pass">
                    <label>Enter new password:</label>
                    <input id="password" type="password" name="password" required>
                </div>
                <div class="re-pass" style="margin-bottom: 10px">
                    <label>Re-enter new password:</label>
                    <input id="re-password" type="password" name="re-password" required>
                </div>
                <button type="submit" class="btn btn-primary btn-block mb-2">Submit</button>

            </form>
        </div>
    </body>
</html>
