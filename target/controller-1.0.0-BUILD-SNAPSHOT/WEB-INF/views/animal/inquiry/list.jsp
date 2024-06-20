<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>
<link rel="stylesheet" href="/resources/inquiry.css">
<link rel="stylesheet" href="/resources/inquiry.css">


<div class="container-stories">
    <div class="container" style=" margin-top: 150px;">


        <div class="basic animal">
    <h1 class="text-center">문의 게시판</h1>
    <div class="mb-3 text-right">
        <button id="regBtn" onclick="multiple_btn('R');" class="btn btn-success">글쓰기</button>
        <button id="homBtn" onclick="multiple_btn('H');" class="btn btn-success">홈</button>
    </div>
    <div class="basic board">
        <table class="table table-striped table-bordered" id="dataTable">
            <thead class="thead-dark">
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="board" items="${list}">
                <tr>
                    <td><c:out value="${board.INQUIRY_NUM}"/></td>
                    <c:choose>
                        <c:when test="${board.CNT > 0}">
                            <td><a href="/pet/inquiry/get?inquiry_Num=${board.INQUIRY_NUM}"><c:out value="${board.TITLE}"/>(<c:out value="답변완료" />)</a></td>
                        </c:when>
                        <c:otherwise>
                            <td><a href="/pet/inquiry/get?inquiry_Num=${board.INQUIRY_NUM}"><c:out value="${board.TITLE}"/></a></td>
                        </c:otherwise>
                    </c:choose>
                    <td><c:out value="${board.HIDDENWRITER}"/></td>
                    <td><fmt:formatDate value="${board.REGDATE}" pattern="yyyy-MM-dd"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
    </div>
</div>

<script>

function multiple_btn(es){
    switch (es) {
        case 'R' :
            self.location = "/pet/inquiry/register";
            break;
        default :
            self.location = "/";
    }

};

</script>
<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>
