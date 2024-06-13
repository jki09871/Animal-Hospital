<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="/resources/jquery-3.7.1.js"></script>

<!DOCTYPE html>
<html>
<head>
    <title>XSS Filter Example</title>
    <script>
        $(document).ready(function() {
            $("#btnOn").click(function() {
                $("#testForm").prop("action", "/xss/useFilter.do");
                var url = $("#testForm").attr("action");
                var data = $("#testForm").serialize();

                $.post(url, data).done();
            });

            $("#btnOff").click(function() {
                $("#testForm").prop("action", "/xss/noneFilter.do");
                var url = $("#testForm").attr("action");
                var data = $("#testForm").serialize();

                $.post(url, data).done();
            });
        });
    </script>
</head>
<body>
<form id="testForm" method="post">
    <div class="container">
        <div class="row border-bottom mb-3">
            <div class="col-12">
                <p class="h1">EX01. Lucy-xss-servlet-filter 적용</p>
            </div>
        </div>

        <div class="row">
            <div class="col-5">
                <div class="row">
                    <div class="col-2">
                        <label for="inputLabel" class="visually-hidden"></label>
                        <input type="text" readonly class="form-control-plaintext" id="inputLabel" value="메세지">
                    </div>
                    <div class="col-auto">
                        <label for="inputMsg" class="visually-hidden"></label>
                        <input type="text" class="form-control" id="inputMsg" name="inputMsg">
                    </div>
                    <div class="col-auto">
                        <button type="submit" class="btn btn-primary mb-3" id="btnOn">ON</button>
                    </div>
                    <div class="col-auto">
                        <button type="submit" class="btn btn-primary mb-3" id="btnOff">OFF</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
</body>
</html>