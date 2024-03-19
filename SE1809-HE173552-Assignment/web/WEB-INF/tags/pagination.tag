<%-- 
    Document   : pagination
    Created on : Mar 13, 2024, 10:42:20 PM
    Author     : Admin
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- The list of normal or fragment attributes can be specified here: --%>
<%@ attribute name="subject" required="true" type="java.lang.String" %>
<%@ attribute name="currentPage" required="true" type="java.lang.Integer" %>
<%@ attribute name="totalPages" required="true" type="java.lang.Integer" %>

<%-- any content can be specified here e.g.: --%>
<style>
    .pagination {
        margin-top: 20px;
        text-align: center;
    }

    .pagination a {
        display: inline-block;
        padding: 5px 10px;
        margin: 0 2px;
        border: 1px solid #ccc;
        background-color: #f1f1f1;
        color: #333;
        text-decoration: none;
        border-radius: 3px;
    }

    .pagination a.current-page {
        background-color: #333;
        color: #fff;
    }

    .pagination a:hover {
        background-color: #ddd;
    }

</style>
<div class="pagination">
    <c:set var="currentPage" value="${currentPage}" />
    <c:set var="totalPages" value="${totalPages}" />
    <c:set var="maxPagesToShow" value="5" />

    <c:choose>
        <c:when test="${currentPage > maxPagesToShow / 2 + 1}">
            <a href="${subject}page=1">1</a> ...
        </c:when>
        <c:otherwise>
            <c:forEach var="i" begin="1" end="${currentPage - 1}" varStatus="loop">
                <a href="${subject}page=${i}">${i}</a>
            </c:forEach>
        </c:otherwise>
    </c:choose>

    <span class="current-page">${currentPage}</span>

    <c:choose>
        <c:when test="${totalPages - currentPage > maxPagesToShow / 2}">
            <c:forEach var="i" begin="${currentPage + 1}" end="${currentPage + maxPagesToShow / 2}" varStatus="loop">
                <a href="${subject}page=${i}">${i}</a>
            </c:forEach>
            ... <a href="${subject}page=${totalPages}">${totalPages}</a>
        </c:when>
        <c:otherwise>
            <c:forEach var="i" begin="${currentPage + 1}" end="${totalPages}" varStatus="loop">
                <a href="${subject}page=${i}">${i}</a>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>