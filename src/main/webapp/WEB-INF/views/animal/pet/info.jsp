<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--<link rel="stylesheet" href="/resources/styles.css">--%>
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>
<style>
    .pet-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }
    .pet-table th, .pet-table td {
        padding: 10px;
        border-bottom: 1px solid #ddd;
        text-align: left;
    }
    .pet-table th {
        background-color: #f4f4f4;
        font-weight: bold;
    }
    .pet-table td {
        background-color: #fcfcfc;
    }
    .btn-group {
        margin-top: 20px;
    }
    .btn-modify {
        padding: 10px 20px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        text-align: right;
    }
    .btn-modify:hover {
        background-color: #45a049;
    }
    .btn-modify a {
        color: inherit;
        text-decoration: none;
    }
</style>
<div class="container-stories">
    <div class="container">
        <div class="basic animal">
            <h1 class="text-primary text-center" style="margin-top: 90px;">PET INFO</h1>
                <form name="petForm" class="infoForm" id="petForm" action="/animal/pet/info" method="get">
                    <table class="pet-table">
                        <tr>
                            <th>강아지 이름</th>
                            <th>강아지 나이</th>
                            <th>강아지 품종</th>
                            <th>마이크로칩 번호</th>
                            <th>특이사항</th>
                            <th></th> <!-- 수정 버튼 셀 -->
                        </tr>
                        <c:forEach var="pet" items="${pet}">
                            <tr class="pet_info">
                                <td><c:out value="${pet.pet_name}"/></td>
                                <td><c:out value="${pet.age}"/></td>
                                <td><c:out value="${pet.species}"/></td>
                                <td><c:out value="${pet.pet_Id}"/></td>
                                <td><c:out value="${pet.significant}"/></td>
                                <td>
                                    <button type="button" class="btn-modify">
                                        <a href="/pet/info/modify?pet_Id=${pet.pet_Id}" style="color: inherit; text-decoration: none;">수정</a>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </form>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>

<script>

</script>
