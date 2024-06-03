<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>
<link rel="stylesheet" href="/resources/styles.css">

<header>
    <nav>
        <a href="/">홈</a>
    </nav>
</header>
<div class="container-stories">
    <div class="container">
        <div class="basic animal" style="margin-top: 250px;">
            <div class="container">
                <div class="panel-body">
                    <table>
                        <tr>
                            <th>아이디</th>
                            <td>${animal.owner_Id}</td>
                        </tr>
                        <tr>
                            <th>이메일</th>
                            <td>${animal.email}</td>
                        </tr>
                        <tr>
                            <th>핸드폰 번호</th>
                            <td>${animal.phoneNumber}</td>
                        </tr>
                        <tr>
                            <th>내가 쓴 게시물</th>
                            <td>
                                <c:choose>
                                    <c:when test="${animal.post > 0}">
                                        <a href="/animal/postIWrote?ownerId=${animal.owner_Id}">${animal.post}개</a>
                                    </c:when>
                                    <c:otherwise>
                                        -
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>내가 쓴 댓글</th>
                            <td>
                                <c:choose>
                                    <c:when test="${animal.comment > 0}">
                                        <a href="/animal/commentIWrote?ownerId=${animal.owner_Id}">${animal.comment}개</a>
                                    </c:when>
                                    <c:otherwise>
                                        -
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </table>
                    <div class="btn-group">
                        <button type="button" class="btn" onclick="fnDynamic('E');">정보수정</button>
                        <button type="button" class="btn" onclick="fnDynamic('W');">애견등록</button>
                        <button type="button" class="btn" onclick="fnDynamic('I');">애견등록확인</button>
                        <button type="button" class="btn" onclick="fnDynamic('L');">이전</button>
                    </div>
                    <form id="petForm" action="/animal/myInfo" method="get">
                        <input type="hidden" name="ownerId" id="ownerId" value="<c:out value='${animal.owner_Id}'/>">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    let form = $('#petForm');
    let url = '';

    function fnDynamic(es) {
        switch (es) {
            case 'E' :
                url = '/animal/editInfo';
                break;
            case 'L' :
                url = '/animal/reviewList';
                break;
            case 'W' :
                url = '/pet/info/write';
                break;
            case 'P' :
                url = '/animal/postIWrote';
                break;
            default :
                url = '/pet/info';
                break;
        }
        form.attr('action', url);
        form.submit();
    }
</script>
<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>
