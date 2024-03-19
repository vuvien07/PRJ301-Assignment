<%-- 
    Document   : admin_attendance_report
    Created on : Mar 17, 2024, 9:30:58 PM
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
        <link rel="stylesheet" href="../${pageContext.request.contextPath}/css/attendance_report.css"/>
        <link rel="stylesheet" href="../${pageContext.request.contextPath}/css/lecture_attendance_report.css"/>
        <link rel="stylesheet" href="../${pageContext.request.contextPath}/css/admin_attendance_report.css"/>
    </head>
    <body>
        <div class="admin_attreport">
            <div class="banner">
                <img src="${pageContext.request.contextPath}/image/Logo_FPT_Education.png" alt="" onclick="window.location.href = 'home'"/>
                <h2>View attendance report</h2>
            </div>
            <h1>Select subjects</h1>
            <div class="student_report">
                <c:forEach items="${requestScope.subjects}" var="s">
                    <div class="student_subject" >
                        <p class="ssss" onclick="window.location.href = 'admin_attendance_report?&subid=${s.subid}'">${s.subname}</p>
                    </div>
                </c:forEach>
            </div>
            <c:if test="${requestScope.groups.size() gt 0}">
                <h1>Select group</h1>
                <div class="student_report">
                    <c:forEach items="${requestScope.groups}" var="g">
                        <div class="student_subject" >
                            <p class="ssss" onclick="window.location.href = 'admin_attendance_report?&gid=${g.gid}&lid=${g.lecturer.lid}&termid=${g.term.teid}&subid=${requestScope.subid}'">${g.gname}</p>
                        </div>
                    </c:forEach>
                </div>
            </c:if>

            <c:if test="${requestScope.attendances.size() > 0}">
                <div class="group_attendance_report">
                    <div class="group_attendance_report_header">
                        <h2>Attendance for group ${requestScope.groups[0].gname}</h2>
                        <p>Subject: ${requestScope.subject.subname}</p>
                        <p>Lecturer: ${requestScope.lid}</p>
                    </div>
                    <div class="group_attendance_report_content">       
                        <table>
                            <tr>
                                <td style="background-color: #00BFFF;">No</td>
                                <td style="background-color: #00BFFF;">ID</td>
                                <td style="background-color: #00BFFF;">Name</td>
                                <td style="background-color: #00BFFF;">Absent rate</td>
                                <td style="background-color: #00BFFF;">View detail</td>
                            </tr>
                            <c:set var="count" value="1"/>
                            <c:forEach items="${requestScope.attendances}" var="att">
                                <tr>
                                    <td>${count}</td>
                                    <td>${att.student.sid}</td>
                                    <td>${att.student.sname}</td>
                                    <td>${String.format("%.2f", (att.numOfAbsent * 100.0 / att.totalSession))}%</td>
                                    <td><a href="admin_attendance_report?sid=${att.student.sid}&subid=${requestScope.subject.subid}&termid=${requestScope.termid}&gid=${requestScope.gid}&lid=${requestScope.lid}">View</a></td>
                                </tr>
                                <c:set var="count" value="${count + 1}"/>
                            </c:forEach>
                        </table>
                        <c:if test="${requestScope.student_attendances.size() gt 0}"> 
                            <myTag:attendance_analysis analysis="Attendance report for ${requestScope.student.sid}(${requestScope.student.sname})"
                                                       attendances="${requestScope.student_attendances}" absent="${requestScope.absent}" 
                                                       rate="${requestScope.rate}"/>     
                        </c:if>
                    </div>
                </div>
            </c:if>
        </div>
    </body>
</html>
