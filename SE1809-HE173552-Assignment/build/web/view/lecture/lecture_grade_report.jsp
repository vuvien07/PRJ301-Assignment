<%-- 
    Document   : lecture_grade_report
    Created on : Mar 15, 2024, 10:57:33 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="myTag" tagdir="/WEB-INF/tags/" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="../${pageContext.request.contextPath}/css/lecture_grade_report.css"/>
    </head>
    <body>
        <c:set var="average" value="0"/>
        <c:forEach var="a" items="${requestScope.assesments}">
            <c:set var="average" value="${average + (a.grade.score * a.weight /100)}"/>
        </c:forEach>
        <div class="lecture_grade_report1">
            <div class="header">
                <img src="${pageContext.request.contextPath}/image/Logo_FPT_Education.png" alt="" onclick="window.location.href = 'home'"/>
                <h1>View grade report</h1>
            </div>
            <div class="content">
                <form id="form1" action="lecture_grade_report">
                    <div class="dropdown">
                        <div class="dropdown-select">
                            <span>Select term</span>
                            <select name="termid">
                                <c:forEach items="${requestScope.terms}" var="t">
                                    <option value="${t.teid}"
                                            <c:if test="${requestScope.termid eq t.teid}">selected</c:if>    
                                            onchange="change()">${t.tename}</option>
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
                            <div class="lecture_subject" onclick="window.location.href = 'lecture_grade_report?&subid=${s.subid}&termid=${requestScope.termid}'">
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
                                <div class="group_subject" onclick="window.location.href = 'lecture_grade_report?subid=${requestScope.subid}&gid=${g.gid}&termid=${sessionScope.termid}'">
                                    <p class="group_name">${g.gname}</p>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
                <c:if test="${requestScope.students.size() > 0}">
                    <c:set var="count" value="0"/>
                    <div class="group_grade">
                        <c:forEach items="${requestScope.groups}" var="g">
                            <c:if test="${requestScope.gid eq g.gid}">
                                <h1>Grade information about ${g.gname}</h1>
                            </c:if>
                        </c:forEach>
                        <p>Subject: ${requestScope.subjects[0].subname}</p>
                        <p>Lecture: ${sessionScope.account.username}</p>
                        <p>Start date: ${requestScope.marks.get(0).startDate}</p>
                        <p>End date: ${requestScope.marks.get(0).endDate}</p>
                        <table>
                            <tr>
                                <td>ID</td>
                                <td>Name</td>
                                <td>Average</td>
                                <td>Status</td>
                                <td>View</td>
                            </tr>
                            <c:forEach items="${requestScope.students}" var="s">
                                <tr>
                                    <td>${s.sid}</td>
                                    <td>${s.sname}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${requestScope.situations[count] eq 'Studied'}">
                                                <fmt:formatNumber value="${s.average}" pattern="#.#"/>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${requestScope.situations[count] eq 'Studying'}">
                                                <p style="margin: 0; color: green">Studying</p>
                                            </c:when>
                                            <c:when test="${requestScope.situations[count] eq 'Studied'}">
                                                <c:choose>
                                                    <c:when test="${requestScope.absentRates[count] <= 20 and s.average > 5.0}">
                                                        <p style="margin: 0; color: green">Passed</p>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <p style="margin: 0; color: red">Not passed</p>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:when test="${requestScope.situations[count] eq 'Not started'}">
                                                Not started
                                            </c:when>
                                            <c:otherwise>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><a href="lecture_grade_report?sid=${s.sid}&subid=${requestScope.subid}&lid=${requestScope.lid}&termid=${requestScope.termid}&gid=${requestScope.gid}">View</a></td>
                                </tr>
                                <c:set var="count" value="${count + 1}"/>
                            </c:forEach>
                        </table>
                    </div>
                </c:if>

                <c:if test="${requestScope.students.size() > 0}">
                    <c:set var="count1" value="0"/>
                    <c:forEach items="${requestScope.students}" var="s">
                        <c:if test="${s.sid eq requestScope.sid}">
                            <c:if test="${requestScope.assesments.size() gt 0 and requestScope.situations[count1] != 'Studying'}">
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
                                        <td>Course total</td>
                                        <td>Average<br><br><br>Status</td>
                                        <td><fmt:formatNumber value="${average}" pattern="#.#"/><br><br>

                                            <c:choose>
                                                <c:when test="${requestScope.situations[count1] eq 'Studying'}">
                                                    Studying
                                                </c:when>
                                                <c:when test="${requestScope.situations[count1] eq 'Studied'}">
                                                    <c:choose>
                                                        <c:when test="${requestScope.absentRates[count1] <= 20 and s.average > 5.0}">
                                                            <p style="margin: 0; color: green">Passed</p>
                                                        </c:when>
                                                        <c:when test="${requestScope.absentRates[count1] > 20 and s.average > 5.0}">
                                                            <p style="color: red;margin: 0">Not passed</p> (due to absent rate is<br> <fmt:formatNumber value="${requestScope.absentRates[count1]}" pattern="#.#"/>% which more than 20% )
                                                        </c:when>
                                                        <c:otherwise>
                                                            <p style="color: red;margin: 0">Not passed<br>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                                <c:when test="${requestScope.situations[count1] eq 'Not started'}">
                                                    Not started
                                                </c:when>
                                                <c:otherwise>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </table>
                                </div>
                            </c:if>
                        </c:if>
                        <c:set var="count1" value="${count1 + 1}"/>
                    </c:forEach>
                </c:if>
            </div>
        </div>
    </body>
</html>
