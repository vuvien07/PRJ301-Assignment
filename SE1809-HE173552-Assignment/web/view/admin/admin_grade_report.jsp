<%-- 
    Document   : admin_grade_report
    Created on : Mar 17, 2024, 11:29:56 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="myTag" tagdir="/WEB-INF/tags/" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .banner{
                display: flex;
                align-items: center;
                width: 40%;
            }

            .banner img{
                margin: 10px;
                width: 25%;
            }

        </style>
        <link rel="stylesheet" href="../${pageContext.request.contextPath}/css/grade_report.css"/>
        <link rel="stylesheet" href="../${pageContext.request.contextPath}/css/admin_grade_report.css"/>

    </head>
    <body>
        <div class="admin_gradereport">
            <div class="banner">
                <img src="${pageContext.request.contextPath}/image/Logo_FPT_Education.png" alt="" onclick="window.location.href = 'home'"/>
                <h2>View grade report</h2>
            </div>
            <form action="admin_grade_report" method="post">
                <div class="search">
                    <input type="text" name="text" placeholder="Search for student"><input type="submit" value="Search">
                </div>
            </form>
            <c:if test="${sessionScope.search_students.size() gt 0}">
                <div class="list_student">
                    <table class="student_table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>View</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="a" items="${sessionScope.search_students}">
                                <tr>
                                    <td>${a.sid}</td>
                                    <td>${a.sname}</td>
                                    <td>
                                        <form action="admin_grade_report?sid=${a.sid}&text=${requestScope.text}" method="post">
                                            <input type="submit" value="View Detail">
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <myTag:pagination currentPage="${requestScope.page}" subject="admin_grade_report?text=${requestScope.text}&" totalPages="${requestScope.num}"/>
                </div>
            </c:if>
            <c:if test="${requestScope.marks.size() gt 0 && requestScope.marks != null}">

                <c:set var="average" value="0"/>
                <c:forEach var="a" items="${requestScope.assesments}">
                    <c:set var="average" value="${average + (a.grade.score * a.weight /100)}"/>
                </c:forEach>
                <div class="grade_report">
                    <div class="header">
                        <h1>Grade report for ${requestScope.marks[0].student.sid}(${requestScope.marks[0].student.sname})</h1>
                    </div>
                    <div class="student_grade_report">
                        <table>
                            <tr>
                                <td>No</td>
                                <td>Subject code</td>
                                <td>Subject name</td>
                                <td>Semester</td>
                                <td>Start date</td>
                                <td>End date</td>
                                <td>Group</td>
                                <td>Average mark</td>
                                <td>Status</td>
                                <td>View</td>
                            </tr>
                            <c:set var="count" value="1"/>
                            <c:set  var="count1" value="0"/>
                            <c:forEach var="m" items="${requestScope.marks}">
                                <tr>
                                    <td>${count}</td>
                                    <td>${m.subject.subid}</td>
                                    <td>${m.subject.subname}</td>
                                    <td>${m.term.tename}</td>
                                    <td>${m.startDate}</td>
                                    <td>${m.endDate}</td>
                                    <td>${m.group.gname}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${requestScope.situations[count1] eq 'Studied'}">
                                                <fmt:formatNumber value="${requestScope.str[count1]}" pattern="#.#"/>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${requestScope.situations[count1] eq 'Studying'}">
                                                Studying
                                            </c:when>
                                            <c:when test="${requestScope.situations[count1] eq 'Studied'}">
                                                <c:choose>
                                                    <c:when test="${requestScope.absentRates[count1] <= 20 and requestScope.str[count1] > 5.0}">
                                                        Passed
                                                    </c:when>
                                                    <c:otherwise>
                                                        Not passed
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:when test="${requestScope.situations[count1] eq 'Not started'}">
                                                Not started
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <form action="admin_grade_report?subid=${m.subject.subid}&teid=${m.term.teid}&sid=${m.student.sid}&count1=${count1}&text=${requestScope.text}" method="post">
                                            <input type="submit" value="View detail">
                                        </form>
                                    </td>
                                </tr>
                                <c:set var="count" value="${count + 1}"/>
                                <c:set var="count1" value="${count1 + 1}"/>
                            </c:forEach>
                        </table>
                    </div>

                    <c:if test="${requestScope.assesments.size() gt 0 and requestScope.situations[requestScope.count1] != 'Studying'}">
                        <div class="grade_report_detail">
                            <h2>Grade detail for ${requestScope.student.sid}(${requestScope.student.sname})</h2>
                            <table>
                                <tr>
                                    <td>Grade category</td>
                                    <td>Weight</td>
                                    <td>Value</td>
                                </tr>
                                <c:forEach var="a" items="${requestScope.assesments}">
                                    <tr>
                                        <td>${a.asname}</td>
                                        <td>${a.weight}</td>
                                        <td><fmt:formatNumber value="${a.grade.score}" pattern="#.#"/></td>
                                    </tr>
                                </c:forEach>
                                <td rowspan="2">Course total</td>
                                <td>Average<br><br><br>Status</td>
                                <td><fmt:formatNumber value="${average}" pattern="#.#"/><br>
                                    <c:choose>
                                        <c:when test="${requestScope.situations[requestScope.count1] eq 'Studied'}">
                                            <c:choose>
                                                <c:when test="${requestScope.absentRates[requestScope.count1] <= 20 and average > 5.0}">
                                                    <p style="margin: 0; color: green">Passed</p>
                                                </c:when>
                                                <c:when test="${requestScope.absentRates[requestScope.count1] > 20}">
                                                    <p style="margin: 0; color: red">Not passed</p> (due to absent rate is<br> <fmt:formatNumber value="${requestScope.absentRates[requestScope.count1]}" pattern="#.#"/>% which more than 20% )
                                                </c:when>
                                                <c:otherwise>
                                                    <p style="margin: 0; color: red">Not passed</p>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:when test="${requestScope.situations[count1] eq 'Not started'}">
                                            Not started
                                        </c:when>
                                    </c:choose>
                                </td>
                            </table>
                        </div>
                    </c:if>
                </div>
            </c:if>
        </div>
    </body>
</html>
