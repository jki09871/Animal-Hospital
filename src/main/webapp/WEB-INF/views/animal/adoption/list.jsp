<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>

<style>
    .img {
        width: 100%; /* 부모 요소의 너비에 맞춰서 이미지를 조정 */
        height: 250px; /* 고정된 높이 */
        object-fit: cover; /* 이미지의 비율을 유지하면서 크기 조정, 잘라내기 */
    }
</style>


<div class="container-stories">
    <div class="container">
        <h1 style="text-align: center">보호동물 입양목록</h1>

        <div style="text-align: right">
        <a href="/adoption/animal/register"><button type="button" class="btn btn-danger"> 입양동물 작성</button></a>
        </div>

        <c:set var="cnt" value="1" />

        <c:forEach var="list" items="${list}" varStatus="st">

            <c:if test="${cnt == 1}">
                <div class="row">
            </c:if>
            <div class="col-md-4">
                <div class="well">
                    <a href="/adoption/animal/read?adoption_id=${list.adoption_id}">
                        <img class="img"  src="/common/img?fName=${list.stored_file_name}&folder=${list.folder_nm}"/>
                        <p style="text-align: center; font-size: large" >${list.species} 분양</p>
                    </a>
                </div>
            </div>
            <c:set var="cnt" value="${cnt + 1}" />

            <c:if test="${cnt == 4}">
                </div>
                <c:set var="cnt" value="1" />
            </c:if>
        </c:forEach>

    </div>
</div>

<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>
