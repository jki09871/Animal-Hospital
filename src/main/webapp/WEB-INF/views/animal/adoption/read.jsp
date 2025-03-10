<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/cmmn/header.jsp" %>

<style>
    .table {
        text-align: center;
    }

    .bold {
        font-weight: bold;
    }
</style>


<div class="container-stories">
    <div class="container" style="width: 1244px">

        <h1>동물 정보</h1>
        <table class="table table-bordered">
            <tbody>
            <tr>
                <td rowspan='3'>
                    <img src="/common/img?fName=${read.stored_file_name}&folder=${read.folder_nm}"
                         style="height: 200px; width: 200px;">
                </td>
                <td class="bold">입양 여부</td>
                <td>
                    <c:choose>
                        <c:when test="${read.adoptionStatus == 'Y'}">O</c:when>
                        <c:when test="${read.adoptionStatus == 'N'}">X</c:when>
                        <c:otherwise>알 수 없음</c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <td class="bold">동물 이름</td>
                <td><c:out value="${read.animal_name}"/></td>
                <td class="bold">종</td>
                <td><c:out value="${read.species}"/></td>
                <td class="bold">중성화 여부</td>
                <td>
                    <c:choose>
                        <c:when test="${read.neutering == 'Y'}">O</c:when>
                        <c:when test="${read.neutering == 'N'}">X</c:when>
                        <c:otherwise>알 수 없음</c:otherwise>
                    </c:choose>
                </td>
                <td class="bold">좋아하는 것</td>
                <td><c:out value="${read.ILike}"/></td>
            </tr>
            <tr>
                <td class="bold">나이</td>
                <td><c:out value="${read.age}"/></td>
                <td class="bold">성별</td>
                <td>
                    <c:choose>
                        <c:when test="${read.gender == 'M'}">수컷</c:when>
                        <c:when test="${read.gender == 'F'}">암컷</c:when>
                        <c:otherwise>알 수 없음</c:otherwise>
                    </c:choose>
                </td>
                <td class="bold">접종 여부</td>
                <td><c:out value="${read.inoculation}"/></td>
                <td class="bold">싫어하는 것</td>
                <td><c:out value="${read.disLike}"/></td>
            </tr>
            <tr>
                <td class="bold">상세 내용</td>
                <td colspan="8"><c:out value="${read.content}"/></td>
            </tr>
            </tbody>
        </table>
        <div style="text-align: right;">
            <c:if test="${sessionScope.loginId.grade == 99}">
                <button type="button" class="btn btn-danger" onclick="anything_btn('E');">수정</button>
            </c:if>
            <button type="button" class="btn btn-danger" onclick="anything_btn('L');">목록으로</button>
        </div>
    </div>
</div>
<script>

    function anything_btn(es) {
        switch (es) {
            case 'E' :
                self.location = '/adoption/animal/information/modify?adoption_id=' + <c:out value="${read.adoption_id}"/>;
                break;
            case 'L' :
                self.location = '/adoption/animal/list';
        }
    }

</script>
<%@include file="/WEB-INF/views/cmmn/footer.jsp" %>
