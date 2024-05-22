<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <title>XSS Filter Example</title>
    <script>
        $(document).ready(function() {
            $("#btnOn").click(function() {
                var url = $("#testForm").attr("action");
                var data = $("#testForm").serialize();

                $.post(url, data).done();
            });
        });
    </script>
    <script>alert("테스트")</script>
    <script>alert("nMsg")</script>
    <script>alert("msg")</script>
</head>
<body>
<form id="testForm" action="/xss/globalFilter.do" method="post">
    <div class="container">
        <div class="row border-bottom mb-3">
            <div class="col-12">
                <p class="h1">EX02. Lucy-xss-servlet-filter 필터 규칙사용</p>
            </div>
        </div>

        <div class="row mb-1">
            <div class="col-1">
                <label for="inputLabel1" class="visually-hidden"></label>
                <input type="text" readonly class="form-control-plaintext" id="inputLabel1" value="필터 미적용">
            </div>
            <div class="col-auto">
                <label for="inputMsg" class="visually-hidden"></label>
                <input type="text" class="form-control" id="nParam" name="nParam">
            </div>
        </div>

        <div class="row mb-1">
            <div class="col-1">
                <label for="inputLabel2" class="visually-hidden"></label>
                <input type="text" readonly class="form-control-plaintext" id="inputLabel2" value="필터 미적용">
            </div>
            <div class="col-auto">
                <label for="inputMsg" class="visually-hidden"></label>
                <input type="text" class="form-control" id="nMsg" name="nMsg">
            </div>
        </div>

        <div class="row mb-1">
            <div class="col-1">
                <label for="inputLabel3" class="visually-hidden"></label>
                <input type="text" readonly class="form-control-plaintext" id="inputLabel3" value="필터 적용">
            </div>
            <div class="col-auto">
                <label for="inputMsg" class="visually-hidden"></label>
                <input type="text" class="form-control" id="msg" name="msg">
            </div>
        </div>

        <div class="row">
            <div class="col-auto">
                <button type="submit" class="btn btn-primary mb-3" id="btnOn">SEND</button>
            </div>
        </div>
    </div>

</form>
</body>
</html>