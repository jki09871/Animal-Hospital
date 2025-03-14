<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>

<style>
    .panel-body {

        background-color: #f9f9f9;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        width: 520px;
        text-align: center;
        margin: auto;

    }

    .panel-body table {
        width: 100%;
        border-collapse: collapse;
        margin: auto;

    }

    .panel-body th,
    .panel-body td {
        text-align: left;
        padding: 8px;
        border-bottom: 1px solid #ddd;
    }

    .panel-body th {
        background-color: #007bff;
        color: white;
    }

    .panel-body a {
        color: #007bff;
        text-decoration: none;
    }

    .panel-body a:hover {
        text-decoration: underline;
    }

    .btn-group {
        text-align: center;
        margin-top: 20px;
    }

    .btn-group .btn {
        padding: 10px 20px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        margin-right: 10px; /* Adds space between buttons */
    }

    .btn-group .btn:hover {
        background-color: #0056b3;
    }

    .btn-group .btn:last-child {
        margin-right: 0; /* Removes margin from the last button */
    }

</style>

<div class="container-stories" >
    <div class="basic animal">
        <div class="container-about">
            <div class="panel-body">
                <table>
                    <h2>My Info</h2>
                    <tr>
                        <th>아이디</th>
                        <td><c:out value="${animal.owner_Id}"/></td>
                    </tr>
                    <tr>
                        <th>이메일</th>
                        <td><c:out value="${animal.email}"/></td>
                    </tr>
                    <tr>
                        <th>핸드폰 번호</th>
                        <td><c:out value="${animal.phoneNumber}"/></td>
                    </tr>
                    <tr>
                        <th>내가 쓴 게시물</th>
                        <td>
                            <c:choose>
                                <c:when test="${animal.post > 0}">
                                    <a href="/animal/postIWrote?ownerId=${animal.owner_Id}"><c:out value="${animal.post}"/>개</a>
                                </c:when>
                                <c:otherwise>
                                    -
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th>내가 쓴 문의</th>
                        <td>
                            <c:choose>
                                <c:when test="${animal.inquiry > 0}">
                                    <a href="/animal/inquiryIWrote?ownerId=${animal.owner_Id}"><c:out value="${animal.inquiry}"/>개</a>
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
                                    <a href="/animal/commentIWrote?ownerId=${animal.owner_Id}"><c:out value="${animal.comment}"/>개</a>
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
                    <button type="button" class="btn" onclick="fnDynamic('P');">비밀변호 변경</button>
                </div>
                <form id="petForm" action="/animal/myInfo" method="get">
                    <input type="hidden" name="ownerId" id="ownerId" value="<c:out value='${animal.owner_Id}'/>">
                </form>
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
                url = '/animal/pwChange';
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
