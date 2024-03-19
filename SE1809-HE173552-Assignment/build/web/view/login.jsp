<%-- 
    Document   : login
    Created on : Feb 25, 2024, 4:46:49 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="css/login.css">
    </head>
    <body>
        <div class="container">
            <div class="center-vertical">
                <div>
                    <h1 style="text-align: center;
                        font-family: sans-serif">FPT University</h1>
                </div>
                <div class="login">
                    <div class="card-header" style="text-align: center;
                         font-weight: bold;
                         font-size: 30px">Login</div>
                    <div class="card-body">
                        <form action="login" method="POST">
<!--                            <div class="role mb-2">
                                <label for="password">Choose role</label>
                                <select id="role" name="role">
                                    <option value="student">Student</option>
                                    <option value="teacher">Lecturer</option>
                                </select>
                            </div>-->
                            <div class="form-group mb-2">
                                <input type="text" id="username" name="username" 
                                       placeholder="Username or email" class="form-control" required>
                                <span id="usernameError" class="error-message"></span>
                            </div>
                            <div class="form-group">
                                <input type="password" id="password" name="password" placeholder="Password" class="form-control mb-2" required>
                            </div>
                            <button type="submit" class="btn btn-primary btn-block mb-2">Login</button>
                            <div class="register">
                                <p>Don't have a account?<a href="sign-up">Register</a></p>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="error01">
                    
                </div>
            </div>
        </div>

    </body>
</html>
