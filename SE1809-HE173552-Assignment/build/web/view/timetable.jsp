<%-- 
    Document   : lectureTimetable
    Created on : Feb 29, 2024, 11:37:25 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page import="java.time.LocalDate" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            function changeYear() {
                var year = document.getElementById('year').value;
                window.location.href = 'timetable?year=' + year;
            }

            function submitForm() {
                document.forms["timetableForm"].submit();
            }
        </script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/timetable.css"/>
    </head>
    <body>
        <div class="banner">
            <img src="${pageContext.request.contextPath}/image/Logo_FPT_Education.png" alt="" onclick="window.location.href = 'home'"/>
            <h2>View schedule</h2>
        </div>
        <c:if test="${!sessionScope.roles.contains('Admin')}">
            <c:set var="currentTime" value="<%= Date.valueOf(LocalDate.now()) %>" />
            <h1>Time table for ${sessionScope.account.username}</h1>
            <div class="selectyear">
                Select year:
                <select name="year" id="year" onchange="changeYear()">
                    <option value="2023" <c:if test="${sessionScope.year eq '2023'}">selected</c:if>>2023</option>
                    <option value="2024" <c:if test="${sessionScope.year eq '2024'}">selected</c:if>>2024</option>
                    </select><br>
                </div>
                <form id="timetableForm" action="timetable" method="post">
                <c:if test="${sessionScope.roles.contains('Lecturer')}">
                    <input type="hidden" name="lectureid" value="${sessionScope.account.username}">
                </c:if>
                <c:if test="${sessionScope.roles.contains('Student')}">
                    <input type="hidden" name="studentid" value="${sessionScope.account.username}">
                </c:if>
                <table>
                    <tr>
                        <td style="background-color: #00BFFF">
                            Select week:
                            <select name="weeks" onchange="submitForm()">
                                <c:forEach var="entry" items="${sessionScope.weeks_on_year}">
                                    <c:set var="key" value="${entry.key}"/>
                                    <c:set var="value" value="${entry.value}"/>                                                      
                                    <option value="${key} ${value}" <c:if test="${sessionScope.fromdate == key}">selected</c:if> 
                                            >
                                        ${key.toString().split("-")[2]}-${key.toString().split("-")[1]} 
                                        to ${value.toString().split("-")[2]}-${value.toString().split("-")[1]}

                                    </option>
                                </c:forEach>
                            </select>
                        </td>
                        <td style="text-align: center; background-color: #00BFFF">Mon<br>${sessionScope.dates[0].toString().split("-")[2]}-${sessionScope.dates[0].toString().split("-")[1]}</td>
                        <td style="text-align: center;background-color: #00BFFF">Tue<br>${sessionScope.dates[1].toString().split("-")[2]}-${sessionScope.dates[1].toString().split("-")[1]}</td>
                        <td style="text-align: center;background-color: #00BFFF">Wed<br>${sessionScope.dates[2].toString().split("-")[2]}-${sessionScope.dates[2].toString().split("-")[1]}</td>
                        <td style="text-align: center;background-color: #00BFFF">Ths<br>${sessionScope.dates[3].toString().split("-")[2]}-${sessionScope.dates[3].toString().split("-")[1]}</td>
                        <td style="text-align: center;background-color: #00BFFF">Fri<br>${sessionScope.dates[4].toString().split("-")[2]}-${sessionScope.dates[4].toString().split("-")[1]}</td>
                        <td style="text-align: center;background-color: #00BFFF">Sat<br>${sessionScope.dates[5].toString().split("-")[2]}-${sessionScope.dates[5].toString().split("-")[1]}</td>
                        <td style="text-align: center;background-color: #00BFFF">Sun<br>${sessionScope.dates[6].toString().split("-")[2]}-${sessionScope.dates[6].toString().split("-")[1]}</td>

                    </tr>
                    <c:forEach items="${sessionScope.slots}" var="r">
                        <tr>
                            <td>Slot ${r.slid}</td>
                            <c:forEach var="d" items="${sessionScope.dates}">
                                <td>
                                    <c:forEach items="${sessionScope.sessions}" var="ss">
                                        <c:if test="${(ss.date eq d) and (ss.slot.slid eq r.slid)}">
                                            ${ss.group.subject.subname}-${ss.group.gname}<br>
                                            at ${ss.room.rname}<br> by ${ss.lecture.lid}<br>
                                            <c:if test="${roles.contains('Lecturer')}">
                                                <c:if test="${!ss.isAttended}">
                                                    <a href="attendance?sesid=${ss.sesid}">Take</a>
                                                </c:if>
                                                <c:if test="${ss.isAttended}">
                                                    <a href="attendance?sesid=${ss.sesid}">Edit</a>
                                                </c:if>
                                            </c:if>
                                            <c:if test="${roles.contains('Student')}">
                                                <c:if test="${ss.attendances[0].status.equals('Absent')}">
                                                    <p style="color: red;margin: 0">Absent</p>
                                                </c:if>
                                                <c:if test="${ss.attendances[0].status.equals('Present')}">
                                                    <p style="color: green;margin: 0">Present</p>
                                                </c:if>
                                                    <c:if test="${ss.attendances[0].status eq null}">
                                                    <p style="color: red;margin: 0">Not yet</p>
                                                </c:if>
                                            </c:if>
                                        </c:if>
                                    </c:forEach>
                                </td>
                            </c:forEach>
                        </tr>
                    </c:forEach>
                </table>
                <!--            <input type="submit" name="name" value="Submit">-->
            </form>
        </c:if>
    </body>
</html>
