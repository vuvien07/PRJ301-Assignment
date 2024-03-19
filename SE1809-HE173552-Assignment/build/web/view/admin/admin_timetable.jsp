<%-- 
    Document   : timetable
    Created on : Mar 17, 2024, 3:27:01 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page import="java.time.LocalDate" %>
<%@taglib prefix="myTag" tagdir="/WEB-INF/tags/" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="../${pageContext.request.contextPath}/css/timetable.css"/>
        <link rel="stylesheet" href="../${pageContext.request.contextPath}/css/admin_time_table.css"/>
        <script>
            function changeYear() {
                var year = document.getElementById('year').value;
                window.location.href = 'admin_timetable?year=' + year + '&page=${requestScope.page}&userid=${requestScope.userid}&userid1=${requestScope.userid1}';
            }

            function changeWeek() {
                var week = document.getElementById('weeks').value;
                var year = document.getElementById('year').value;
                window.location.href = 'week1?week=' + week + '&year=' + year;
            }

            function submitForm() {
                document.forms["timetableForm"].submit();
            }
        </script>
    </head>
    <body>
        <div class="admin_timetable1">
            <div class="banner">
                <img src="${pageContext.request.contextPath}/image/Logo_FPT_Education.png" alt="" onclick="window.location.href = 'home'"/>
                <h2>View schedule</h2>
            </div>
            <form action="admin_timetable" method="get">
                <div class="search">
                    <input type="text" name="userid" placeholder="Search student and lecturer"><input type="submit" value="Search">
                </div>
            </form>
            <c:if test="${sessionScope.search_accounts.size() gt 0}">
                <div class="listtimetable">
                    <table class="timetable-table">
                        <thead>
                            <tr>
                                <th>Username</th>
                                <th>Role</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="a" items="${sessionScope.search_accounts}">
                                <tr>
                                    <td>${a.username}</td>
                                    <td>${a.roleAccount}</td>
                                    <td><a href="admin_timetable?userid1=${a.username}&userid=${requestScope.userid}&page=${requestScope.page}&weeks=${sessionScope.weeks}">View detail</a></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <myTag:pagination currentPage="${requestScope.page}" subject="admin_timetable?userid=${requestScope.userid}&" totalPages="${requestScope.num}"/>
                </div>

            </c:if>

            <c:if test="${sessionScope.search_account != null}">
                <c:set var="currentTime" value="<%= Date.valueOf(LocalDate.now()) %>" />
                <h1>Time table for ${sessionScope.search_account.username}</h1>
                <div class="selectyear">
                    Select year:
                    <select name="year" id="year" onchange="changeYear()">
                        <option value="2023" <c:if test="${requestScope.year eq '2023'}">selected</c:if>>2023</option>
                        <option value="2024" <c:if test="${requestScope.year eq '2024'}">selected</c:if>>2024</option>
                        </select><br>
                    </div>
                    <form id="timetableForm" action="admin_timetable" method="get">
                    <input type="hidden" name="userid1" value="${requestScope.userid1}">
                    <input type="hidden" name="page" value="${requestScope.page}">
                    <input type="hidden" name="userid" value="${requestScope.userid}">
                    <input type="hidden" name="year" value="${requestScope.year}">
                    <c:if test="${sessionScope.account1.roleAccount.contains('Lecturer')}">
                        <input type="hidden" name="lectureid" value="${sessionScope.account.username}">
                    </c:if>
                    <c:if test="${sessionScope.account1.roleAccount.contains('Student')}">
                        <input type="hidden" name="studentid" value="${sessionScope.account.username}">
                    </c:if>
                    <table>
                        <tr>
                            <td style="background-color: #00BFFF">
                                Select week:
                                <select name="weeks" onchange="submitForm()">
                                    <c:forEach var="entry" items="${sessionScope.week_on_year}">
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
                                                <c:if test="${sessionScope.search_account.roleAccount.contains('Lecturer')}">
                                                    <c:if test="${!ss.isAttended}">
                                                        <a href="admin_attendance?sesid=${ss.sesid}&userid=${requestScope.userid}&page=${requestScope.page}&userid1=${requestScope.userid1}">Take</a>
                                                    </c:if>
                                                    <c:if test="${ss.isAttended}">
                                                        <a href="admin_attendance?sesid=${ss.sesid}&userid=${requestScope.userid}&page=${requestScope.page}&userid1=${requestScope.userid1}">Edit</a>
                                                    </c:if>
                                                </c:if>
                                                <c:if test="${sessionScope.search_account.roleAccount.contains('Student')}">
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
        </div>
    </body>
</html>
