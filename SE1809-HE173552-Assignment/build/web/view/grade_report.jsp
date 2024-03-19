<%-- 
    Document   : grade_report
    Created on : Mar 10, 2024, 11:09:49 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="myTag" tagdir="/WEB-INF/tags/" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/grade_report.css"/>
    </head>
    <body>
        <c:set var="average" value="0"/>
        <c:forEach var="a" items="${requestScope.assesments}">
            <c:set var="average" value="${average + (a.grade.score * a.weight /100)}"/>
        </c:forEach>
        <div class="grade_report">
            <div class="header">
                <img src="${pageContext.request.contextPath}/image/Logo_FPT_Education.png" alt="" onclick="window.location.href = 'home'"/>
                <h1>Grade report for ${sessionScope.account.username}(${requestScope.marks[0].student.sname})</h1>
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
                    <c:set var="count1" value="0"/>
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
                                        <p style="margin: 0; color: green">Studying</p>
                                    </c:when>
                                    <c:when test="${requestScope.situations[count1] eq 'Studied'}">
                                        <c:choose>
                                            <c:when test="${requestScope.statuses[count1] eq 'Passed'}">
                                                <p style="margin: 0; color: green">Passed</p>
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
                            <td><a href="grade_report?subid=${m.subject.subid}&status=${requestScope.situations[count1]}&teid=${m.term.teid}&sid=${m.student.sid}&count1=${count1}">View detail</a></td>
                        </tr>
                        <c:set var="count" value="${count + 1}"/>
                        <c:set var="count1" value="${count1 + 1}"/>
                    </c:forEach>
                </table>
            </div>

            <c:if test="${requestScope.assesments.size() gt 0 and !requestScope.situations[requestScope.count1].equals('Studying')}">
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
                        <td>Average<br><br>Status</td>
                        <td><fmt:formatNumber value="${average}" pattern="#.#"/><br><br>
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
    </body>
</html>
