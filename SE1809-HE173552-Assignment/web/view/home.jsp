<%-- 
    Document   : home
    Created on : Feb 26, 2024, 4:17:25 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Attendance and Grade Management System</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css"/>
    </head>
    <body>
        <div class="header">
            <div class="header-text">
                <h1>${sessionScope.account.username}</h1>
                <h1><a href="logout">Log out</a></h1>
            </div>
        </div>
        <div class="logo">
            <img src="${pageContext.request.contextPath}/image/Logo_FPT_Education.png" alt="alt"/>
        </div>
        <div class="container content">
            <div class="title">
                <h1>Attendance Taking & Student Grade<br> Management System</h1>
            </div>
            <div class="content-menu">
                <div class="menu">
                    <ul>
                        <li><a class="btn btn-primary" href="subject">
                                <i class="bi bi-zoom-out"></i>
                                <span class="btn-text">View course</span>
                            </a></li>
                        <li><a class="btn btn-primary"

                               <c:if test="${sessionScope.roles.contains('Admin')}">href="admin_timetable"</c:if>
                               <c:if test="${!sessionScope.roles.contains('Admin')}">href="timetable"</c:if>
                                   >
                                   <i class="bi bi-table"></i>
                                   <span class="btn-text">View schedule</span>
                               </a></li>
                            <li><a class="btn btn-primary"
                                <c:if test="${sessionScope.roles.contains('Student')}">href="grade_report"</c:if>
                                <c:if test="${sessionScope.roles.contains('Lecturer')}">href="lecture_grade_report"</c:if>
                                <c:if test="${sessionScope.roles.contains('Admin')}">href="admin_grade_report"</c:if>
                                    >
                                    <i class="bi bi-bar-chart-fill"></i>
                                    <span class="btn-text">View grade report</span>
                                </a></li>
                            <li><a class="btn btn-primary"
                                <c:if test="${sessionScope.roles.contains('Student')}">href="attendance_report"</c:if>
                                <c:if test="${sessionScope.roles.contains('Lecturer')}">href="lecture_attendance_report"</c:if>
                                <c:if test="${sessionScope.roles.contains('Admin')}">href="admin_attendance_report"</c:if>
                                    >
                                    <i class="bi bi-card-checklist"></i>
                                    <span class="btn-text">View attendance report</span>
                                </a></li>
                        </ul>
                    </div>
                    <div class="banner">
                        <img src="${pageContext.request.contextPath}/image/snapedit_1709956536893.jpg" alt=""/>
                </div>
            </div>
        </div>

    </body>
</html>
