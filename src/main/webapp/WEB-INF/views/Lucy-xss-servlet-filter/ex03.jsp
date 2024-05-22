<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="/resources/jquery-3.7.1.js"></script>

<!DOCTYPE html>
<html>
<head>
    <title>XSS Filter Example</title>
    <script>
        function sendMsg() {
            var params = {
                msg : $("#inputMsg").val()
            };

            $.ajax({
                type       : "POST",
                async      : false,
                url        : "/xss/jsonFilter.do",
                cache      : false,
                dataType   : "json",
                data       : JSON.stringify(params),
                contentType: "application/json; charset=utf-8",
                success: function(data) {
                    console.log(data.msg)
                    var msg = data.msg;

                    $("#result").html(msg);
                },
                error : function(request, status, error) {
                    alert("code : " + request.status + "\n" + "message : " + request.responseText + "\n" + "error : " + error);
                }
            });
        }

    </script>
</head>
<body>
<form id="testForm" method="post">
    <div class="container">
        <div class="row border-bottom mb-3">
            <div class="col-12">
                <p class="h1">EX03. Lucy-xss-servlet-filter JSON 데이터는?</p>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-2">
                <label for="inputLabel" class="visually-hidden"></label>
                <input type="text" readonly class="form-control-plaintext" id="inputLabel" value="메세지">
            </div>
            <div class="col-auto">
                <label for="inputMsg" class="visually-hidden"></label>
                <input type="text" class="form-control" id="inputMsg" name="inputMsg">
            </div>
            <div class="col-auto">
                <button type="button" class="btn btn-primary mb-3" onclick="sendMsg()">SEND</button>
            </div>
        </div>

        <div class="row">
            <div class="col-auto">
                결과 : <span id="result"></span>
            </div>
        </div>
    </div>

</form>
</body>
</html>