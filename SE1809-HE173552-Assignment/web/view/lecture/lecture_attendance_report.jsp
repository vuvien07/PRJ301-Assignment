<%-- 
    Document   : lecture_attendance_report
    Created on : Mar 11, 2024, 11:57:10 PM
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
        <link rel="stylesheet" href="../${pageContext.request.contextPath}/css/lecture_attendance_report.css"/>
    </head>
    <div class="lecturer">
        <div class="header">
            <img src="${pageContext.request.contextPath}/image/Logo_FPT_Education.png" alt="" onclick="window.location.href = 'home'"/>
            <h1>Attendance report for ${sessionScope.account.username}</h1>
        </div>
        <div>
            <form action="lecture_attendance_report">
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
                    <input type="hidden" name="lid" value="${sessionScope.account.username.substring(sessionScope.account.username.length() - 8)}">
                    <input type="submit" value="View">
                </div>
            </form>
            <c:if test="${requestScope.subjects.size() gt 0}">
                <span class="banner" style="margin-left: 10px">View subject</span>
                <div class="lecture_report">
                    <c:forEach items="${requestScope.subjects}" var="s">
                        <div class="lecture_subject" onclick="window.location.href = 'lecture_attendance_report?&subid=${s.subid}&termid=${requestScope.termid}'">
                            <p class="ssss">${s.subname}</p>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
            <c:if test="${requestScope.groups.size() > 0}">
                <div class="group_report">
                    <span class="banner">View group</span>
                    <div class="group_view">
                        <c:forEach items="${requestScope.groups}" var="g">
                            <div class="group_subject" onclick="window.location.href = 'lecture_attendance_report?subid=${requestScope.subid}&gid=${g.gid}&termid=${sessionScope.termid}'">
                                <p class="group_name">${g.gname}</p>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>

            <c:if test="${requestScope.attendances.size() > 0}">
                <div class="group_attendance_report">
                    <div class="group_attendance_report_header">
                        <h2>Attendance for group ${requestScope.groups[0].gname}</h2>
                        <p>Subject: ${requestScope.subject.subname}</p>
                        <p>Lecturer: ${sessionScope.account.username}</p>
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
                                    <td><a href="lecture_attendance_report?sid=${att.student.sid}&subid=${requestScope.subject.subid}&termid=${sessionScope.termid}&gid=${requestScope.gid}">View</a></td>
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
            </html>
