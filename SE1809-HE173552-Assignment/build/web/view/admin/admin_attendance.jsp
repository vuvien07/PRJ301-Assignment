<%-- 
    Document   : admin_attendance
    Created on : Mar 17, 2024, 8:36:47 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="../${pageContext.request.contextPath}/css/attendance.css"/>
    </head>
    <body>
        <div class="banner">
            <img src="${pageContext.request.contextPath}/image/Logo_FPT_Education.png" alt="" onclick="window.location.href = 'home'"/>
            <h1>Take attendance</h1>
        </div>
        <form action="admin_attendance?userid1=${requestScope.userid1}" method="post">
            <input type="hidden" name="sesid" value="${requestScope.sesid}"/>
            <input type="hidden" name="page"  value="${requestScope.page}"/>
            <input type="hidden" name="userid" value="${requestScope.userid}"/>
            <table border="1px">
                <tr>
                    <td style="background-color: #00BFFF">Num order</td>
                    <td style="background-color: #00BFFF">Id</td>
                    <td style="background-color: #00BFFF">Name</td>
                    <td style="background-color: #00BFFF">Is presented</td>
                    <td style="background-color: #00BFFF">Description</td>
                    <td style="background-color: #00BFFF">Att time</td>
                </tr>
                <c:set var="counter" value="1" />
                <c:forEach items="${requestScope.atts}" var="a">
                    <tr>
                        <td>${counter}</td>
                        <td>${a.student.sid}</td>
                        <td>${a.student.sname}</td>
                        <td>
                            <input type="radio" 
                                   ${(empty a.status || a.status eq 'Absent') ? "checked=\"checked\"":""}
                                   name="present${a.student.sid}"
                                   value="no"/>No
                            <input type="radio" 
                                   ${(a.status eq 'Present') ? "checked=\"checked\"":""}
                                   name="present${a.student.sid}"
                                   value="yes"/>Yes
                        </td>
                        <td><input name="description${a.student.sid}" type="text" value="${a.description}"></td>   
                        <td>
                            ${a.dateTime}
                        </td>
                    </tr>
                    <c:set var="counter" value="${counter + 1}" />
                </c:forEach>
            </table>
            <input type="submit" value="Save">
        </form>
    </body>
</html>
