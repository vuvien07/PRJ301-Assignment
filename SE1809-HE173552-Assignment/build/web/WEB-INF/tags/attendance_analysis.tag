<%-- 
    Document   : attendance_analysis
    Created on : Mar 13, 2024, 11:25:53 AM
    Author     : Admin
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- The list of normal or fragment attributes can be specified here: --%>
<%@attribute name="analysis" required="true" %>
<%@attribute name="attendances" required="true" type="java.util.ArrayList" %>
<%@attribute name="rate" required="true" type="java.lang.Double"%>
<%@attribute name="absent" required="true" type="java.lang.Integer"%>

<%-- any content can be specified here e.g.: --%>
<style>
    .attendance_analysis {
        background-color: #f8f8f8; /* Màu nền cho phần analysis */
        padding: 20px; /* Khoảng cách phía trong */
        border-radius: 10px; /* Bo góc cho phần analysis */
        animation: Fade 0.3s ease;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.3); /* Đổ bóng cho phần analysis */
        margin: 10px;
    }

    .attendance_analysis h2 {
        color: #333; /* Màu chữ cho tiêu đề */
    }

    .attendance_analysis table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px; /* Khoảng cách từ bảng đến tiêu đề */
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
    }

    .attendance_analysis table th,
    .attendance_analysis table td {
        padding: 10px;
        border: 1px solid #ddd;
        text-align: center;
    }

    .attendance_analysis table th {
        background-color: #00BFFF; /* Màu nền cho tiêu đề cột */
        color: white; /* Màu chữ cho tiêu đề cột */
    }

    .attendance_analysis table tr:nth-child(even) {
        background-color: #f2f2f2; /* Màu nền cho hàng chẵn */
    }

    .attendance_analysis table tr:hover {
        background-color: #e6e6e6; /* Màu nền khi hover */
    }

    .attendance_analysis table td.status-absent {
        color: red; /* Màu chữ cho status 'Absent' */
    }

    .attendance_analysis table td.status-present {
        color: green; /* Màu chữ cho status 'Present' */
    }
</style>
<c:if test="${attendances.size() > 0}">
    <div class="attendance_analysis">
        <h2>${analysis}</h2>
        <p>Start date: ${attendances[0].session.date}</p>
        <p>End date: ${attendances[attendances.size() - 1].session.date}</p>
        <p>Group: ${attendances[0].session.group.gname}</p>
        <p>Absent: ${rate}% so far (${absent} of ${attendances.size()} total)</p>
        <table>
            <tr>
                <td style="background-color: #00BFFF">No</td>
                <td style="background-color: #00BFFF">Date</td>
                <td style="background-color: #00BFFF">Slot</td>
                <td style="background-color: #00BFFF">Status</td>
                <td style="background-color: #00BFFF">Comment</td>
            </tr>
            <c:set var="count" value="1"></c:set>
            <c:forEach items="${attendances}" var="a">
                <tr>
                    <td>${count}</td>
                    <td>${a.session.date}</td>
                    <td>${a.session.slot.slid}</td>
                    <td
                        <c:if test="${a.status.equals('Absent') or a.status eq null}">
                            style="color: red"
                        </c:if>

                        <c:if test="${a.status.equals('Present')}">
                            style="color: green"
                        </c:if>
                        >
                        ${a.status == null?'Not yet': a.status.equals('Absent') ? 'Absent':'Present'}
                    </td>
                    <td>${a.description}</td>
                </tr>
                <c:set var="count" value="${count + 1}"></c:set>
            </c:forEach>
        </table>
    </div>
</c:if>