<%-- 
    Document   : subject
    Created on : Mar 13, 2024, 8:28:37 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="myTag" tagdir="/WEB-INF/tags/" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/subject.css"/>
        <script>
            function submitForm(subid) {
                document.getElementById('subid').value = subid;
                document.getElementById('subject_form').submit();
            }
        </script>
    </head>
    <body>
        <c:set var="tdept" value="${requestScope.tdepts}"/>
        <div>
            <div class="banner">
                <img src="${pageContext.request.contextPath}/image/Logo_FPT_Education.png" alt="FPT Education Logo" onclick="window.location.href = 'home'"/>
                <h2>View course</h2>
            </div>
            <c:if test="${requestScope.tdepts.size() gt 0}">
                <div id="ss" class="training_department">
                    <h2>Select training department</h2>
                    <c:forEach var="td" items="${requestScope.tdepts1}">
                        <div class="tdept" onclick="window.location.href = 'subject?trid=${td.trid}&page=${requestScope.page}';
                                document.getElementById('ss').innerHTML = ''">${td.trname}</div>
                    </c:forEach>
                    <myTag:pagination currentPage="${requestScope.page}" subject="subject?" totalPages="${requestScope.num}"/>
                </c:if>
                <c:if test="${requestScope.subjects.size() gt 0}">
                    <div>
                        <h2 style="text-align: center">Select subject</h2>
                        <form id="subject_form" action="subject" method="post">
                            <div class="subject">
                                <c:forEach items="${requestScope.subjects}" var="s">
                                    <div class="course" onclick="submitForm('${s.subid}')">${s.subname}</div>
                                    <input type="hidden" name="subid" id="subid" value="${s.subid}">
                                </c:forEach>
                            </div>
                        </form>
                    </div>
                </c:if>
                    <c:if test="${requestScope.assesments.size() gt 0 and requestScope.status != 'Studying'}">
                    <div class="subject_assesments">
                        <h2 style="text-align: center">More information about ${requestScope.assesments[0].subject.subname}</h2>
                        <table>
                            <tr>
                                <td style="background-color: #00BFFF">Id</td>
                                <td style="background-color: #00BFFF">Name</td>
                                <td style="background-color: #00BFFF">Weight</td>
                                <td style="background-color: #00BFFF">Description</td>
                            </tr>
                            <c:forEach items="${requestScope.assesments}" var="ass">
                                <tr>
                                    <td>${ass.asid}</td>
                                    <td>${ass.asname}</td>
                                    <td>${ass.weight}%</td>
                                    <td>
                                        <c:forEach items="${ass.descriptions}" var="s">
                                            ${s}<br>
                                        </c:forEach>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </c:if>
            </div>

        </div>
    </body>
</html>
