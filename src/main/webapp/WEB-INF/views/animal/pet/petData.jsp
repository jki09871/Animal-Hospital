<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>


<style>
    body {
        background-color: #f8f9fa;
    }
    .container {
        margin-top: 50px;
    }
    .table th, .table td {
        vertical-align: middle;
    }
    .btn-back {
        margin-top: 20px;
    }
</style>
<div class="container-stories">
    <div class="container">
        <h1 class="text-primary text-center" style="margin-top: 90px;">REVIEW  DETAIL</h1>
        <div class="card">
            <div class="card-header">
                <h3 class="text-center">Subscriber Details</h3>
            </div>
            <div class="card-body">
                <table class="table table-bordered">
                    <tr>
                        <th>마이크로칩</th>
                        <td><c:out value="${data.pet_Id}"/></td>
                    </tr>
                    <tr>
                        <th>주인(ID)</th>
                        <td><c:out value="${data.owner_Id}"/></td>
                    </tr>
                    <tr>
                        <th>동물 이름</th>
                        <td><c:out value="${data.pet_name}"/></td>
                    </tr>
                    <tr>
                        <th>동물 종</th>
                        <td><c:out value="${data.species}"/></td>
                    </tr>
                    <tr>
                        <th>동물 나이</th>
                        <td><c:out value="${data.age}"/>(살)</td>
                    </tr>
                    <tr>
                        <th>특이사항</th>
                        <td><c:out value="${data.significant}"/></td>
                    </tr>
                </table>
                <div class="text-center">
                    <a href="/registered/animal" class="btn btn-primary btn-back">돌아가기</a>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>
