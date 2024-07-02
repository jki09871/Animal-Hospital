<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/cmmn/header.jsp" %>

<style>
    table {
        width: 100%;
        border: 1px solid #444444;
        border-collapse: collapse;
    }

    th, td {
        border: 1px solid #444444;
        white-space: nowrap; /* 텍스트 줄바꿈 방지 */
        overflow: hidden; /* 넘치는 텍스트 숨김 */
        text-overflow: ellipsis; /* 넘치는 텍스트 생략 표시 (...) */
        max-width: 150px; /* 필요한 경우 셀의 최대 너비 설정 */
    }


</style>
<body>
<div class="container">
    <div class="basic animal">
        <h1 class="text-center">배너 게시판</h1>
        <div class="basic banner">
            <a href="/banner/register">
                <button type="button" class="btn-danger create" style="margin-left: 96%">작성</button>
            </a>
            <table class="table table-striped table-bordered" id="dataTable">
                <thead class="thead-dark">
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>내용</th>
                    <th>시작 시간</th>
                    <th>종료 시간</th>
                    <th>팝업 상태</th>
                    <th>상세</th>

                </tr>
                </thead>
                <tbody>
                <c:forEach var="banner" items="${list}">
                    <tr>
                        <td><c:out value="${banner.banner_id}"/></td>
                        <td><c:out value="${banner.title}"/></td>
                        <td><c:out value="${banner.content}"/></td>
                        <td><fmt:formatDate value="${banner.start_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        <td><fmt:formatDate value="${banner.end_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        <td><c:out value="${banner.status}"/></td>
                        <td>
                            <a class=".move" href="/banner/modify?banner_id=${banner.banner_id}">
                                <button type="button">수정</button>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <form class="form" method="get">

            </form>
        </div>
    </div>
</div>

<script>
    let form = $('.form');
    // $('.move').on('click',function (e) {
    //     e.preventDefault();
    //     form.find('#id').remove();
    //     form.append("<input type='hidden' name='id' id='id' value='" + $(this).attr("href")+"'>")
    //     form.attr('action', '/banner/modify');
    //     form.submit();
    // });
</script>


<%@include file="/WEB-INF/views/cmmn/footer.jsp" %>
