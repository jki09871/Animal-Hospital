<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>

<%--    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">--%>
<%--    <script src="/resources/jquery-3.7.1.js"></script>--%>
<%--    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>--%>
<%--    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>--%>
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
            <div class="card-body">
                <table class="table table-bordered">
                    <tr>
                        <th>OWNER_ID</th>
                        <td><c:out value="${data.owner_Id}"></c:out></td>
                    </tr>
                    <tr>
                        <th>EMAIL</th>
                        <td><c:out value="${data.email}"></c:out></td>
                    </tr>
                    <tr>
                        <th>PHONENUMBER</th>
                        <td><c:out value="${data.phoneNumber}"></c:out></td>
                    </tr>
                    <tr>
                        <th>REGDATE</th>
                        <td><fmt:formatDate value="${data.regDate}" pattern="yyyy-MM-dd"/></td>
                    </tr>
                </table>
                <div class="text-center">
                    <a href="/subscribers/member" class="btn btn-primary btn-back">돌아가기</a>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>
