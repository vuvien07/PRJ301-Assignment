<%-- 
    Document   : grade_report
    Created on : Mar 15, 2024, 10:25:14 PM
    Author     : Admin
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>

<%-- The list of normal or fragment attributes can be specified here: --%>
<%@attribute name="assesments" required="true" type="java.util.ArrayList"%>
<%@attribute name="marks" required="true" type="java.util.ArrayList"%>
<%@attribute name="situations" required="true" type="java.util.ArrayList"%>
<%@attribute name="str" required="true" type="java.util.ArrayList"%>
<%@attribute name="absentRates" required="true" type="java.util.ArrayList" %>

<%-- any content can be specified here e.g.: --%>
<style>
    .header{
    display: flex;
    align-items: center;
}
.header h1{
    font-size: 30px;
    font-family: 'Itim', cursive;
}

.header img{
    width: 15%;
    margin-right: 200px;
}

.student_grade_report {
    margin: 10px auto;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
    overflow: hidden;
    width: 80%;
}
table {
    width: 100%;
    border-collapse: collapse;
}
th, td {
    padding: 12px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}
th {
    background-color: #f2f2f2;
    font-weight: bold;
}
tr:hover {
    background-color: #f9f9f9;
}

</style>
<c:set var="average" value="0"/>
<c:forEach var="a" items="${assesments}">
    <c:set var="average" value="${average + (a.grade.score * a.weight /100)}"/>
</c:forEach>
<div class="grade_report">
    <div class="header">
        <img src="${pageContext.request.contextPath}/image/Logo_FPT_Education.png" alt="" onclick="window.location.href = 'home'"/>
        <h1>Grade report for (${marks[0].student.sname})</h1>
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
            <c:forEach var="m" items="${marks}">
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
                    <c:when test="${situations[count1] eq 'Studied'}">
                        <fmt:formatNumber value="${str[count1]}" pattern="#.#"/>
                    </c:when>
                </c:choose>
                </td>
                <td>
                <c:choose>
                    <c:when test="${situations[count1] eq 'Studying'}">
                        Studying
                    </c:when>
                    <c:when test="${situations[count1] eq 'Studied'}">
                        <c:choose>
                            <c:when test="${absentRates[count1] <= 20 && str[count1] >= 5.0}">
                                Passed
                            </c:when>
                            <c:otherwise>
                                Not passed
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:when test="${situations[count1] eq 'Not started'}">
                        Not started
                    </c:when>
                    <c:otherwise>
                    </c:otherwise>
                </c:choose>
                </td>
                <td><a href="grade_report?subid=${m.subject.subid}&status=${situations[count1]}&teid=${m.term.teid}&sid=${m.student.sid}">View detail</a></td>
                </tr>
                <c:set var="count" value="${count + 1}"/>
                <c:set var="count1" value="${count1 + 1}"/>
            </c:forEach>
        </table>
    </div>

    <c:if test="${assesments.size() gt 0 and requestScope.status != 'Studying'}">
        <div class="grade_report_detail">
            <table>
                <tr>
                    <td>Grade category</td>
                    <td>Weight</td>
                    <td>Value</td>
                </tr>
                <c:forEach var="a" items="${assesments}">
                    <tr>
                        <td>${a.asname}</td>
                        <td>${a.weight}</td>
                        <td><fmt:formatNumber value="${a.grade.score}" pattern="#.#"/></td>
                    <td></td>
                    </tr>
                </c:forEach>
                <td rowspan="2">Course total</td>
                <td>Average<br><br>Status</td>
                <td><fmt:formatNumber value="${average}" pattern="#.#"/><br><br>
                <c:if test="${average < 5 }">Not passed</c:if>
                </td>
            </table>
        </div>
    </c:if>
</div>