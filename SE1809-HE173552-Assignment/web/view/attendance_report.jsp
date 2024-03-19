<%-- 
    Document   : attendance_report
    Created on : Mar 4, 2024, 4:55:55 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="myTag" tagdir="/WEB-INF/tags/" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/attendance_report.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    </head>
    <body>
        <div class="student">
            <div class="header">
                <img src="${pageContext.request.contextPath}/image/Logo_FPT_Education.png" alt="" onclick="window.location.href = 'home'"/>
                <h1>Attendance report for ${sessionScope.account.username}</h1>
            </div>
            <form action="attendance_report">
                <input type="hidden" name="sid" value="${sessionScope.account.username.substring(sessionScope.account.username.length() - 8)}" />
                <div class="dropdown">
                    <div class="dropdown-select">
                        <span>Select term</span>
                        <select name="termid">
                            <c:forEach items="${requestScope.terms}" var="t">
                                <option value="${t.teid}"
                                        <c:if test="${requestScope.termid eq t.teid}">selected</c:if>
                                        >${t.tename}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <input type="submit" value="View">
                </div>
            </form>

            <c:if test="${requestScope.subjects.size() gt 0}">
                <div class="student_report">
                    <c:forEach items="${requestScope.subjects}" var="s">
                        <div class="student_subject" onclick="window.location.href = 'attendance_report?sid=${sessionScope.account.username.substring(sessionScope.account.username.length() - 8)}&subid=${s.subid}&termid=${requestScope.termid}'">
                            <p class="ssss">${s.subname}</p>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
            <myTag:attendance_analysis analysis="Atendance report" attendances="${requestScope.attendances}" absent="${requestScope.absent}" rate="${requestScope.rate}"/>
        </div>
        <script src="${pageContext.request.contextPath}/js/attendance_report.js"></script>
    </body>
</html>
