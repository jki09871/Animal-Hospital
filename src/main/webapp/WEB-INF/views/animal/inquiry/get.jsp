<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fmf" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>글 읽기</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <script src="/resources/jquery-3.7.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 50px;
        }
        .panel-body {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .form-group input, .form-group textarea {
            background-color: #e9ecef;
            border: none;
        }
        .btn a {
            color: #fff;
            text-decoration: none;
        }
        .btn a:hover {
            color: #fff;
        }
        #comment-list table {
            width: 100%;
            margin-top: 20px;
        }
        #comment-list th, #comment-list td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        #comment-list th {
            background-color: #f2f2f2;
        }
        #comment-form {
            margin-top: 20px;
        }
        #comment-form input {
            width: calc(100% - 110px);
            margin-right: 10px;
        }
        #comment-form button {
            width: 100px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1 class="text-center">글 읽기</h1>
    <div class="panel-body">
        <div class="form-group">
            <label for="inquiryNum">게시물 번호</label>
            <input type="text" class="form-control" id="inquiryNum" name="inquiryNum" value="<c:out value='${board.inquiryNum}'/>" readonly>
        </div>
        <div class="form-group">
            <label for="title">제목</label>
            <input type="text" class="form-control" id="title" name="title" value="<c:out value='${board.title}'/>" readonly>
        </div>
        <div class="form-group">
            <label for="content">내용</label>
            <textarea rows="3" class="form-control" id="content" name="content" readonly><c:out value='${board.content}'/></textarea>
        </div>
        <div class="form-group">
            <label for="writer">작성자</label>
            <input type="text" class="form-control" id="writer" name="writer" value="<c:out value='${board.writer}'/>" readonly>
        </div>
        <div class="text-center">
            <a href="/pet/inquiry/modify?inquiryNum=${board.inquiryNum}" class="btn btn-warning">수정</a>
            <a href="/pet/inquiry/list" class="btn btn-info">목록</a>
        </div>

        <div id="comment-list">
            <table>
                <tr>
                    <th>작성자</th>
                    <th>내용</th>
                    <th>작성시간</th>
                </tr>
                <c:forEach items="${commentList}" var="comment">
                    <tr>
                        <td>${comment.commentWriter}</td>
                        <td>${comment.commentContent}</td>
                        <td><fmt:formatDate value="${comment.commentCreateTime}" pattern="yyyy-MM-dd"/></td>
                    </tr>
                </c:forEach>
            </table>
        </div>

        <c:if test="${sessionScope.loginId.grade == 99}">
        <div id="comment-form">
            <input type="hidden" id="commentWriter" value="<c:out value="${sessionScope.loginId.owner_Id}"/>">
            <input type="text" id="commentContent" placeholder="내용">
            <button id="comment-write-btn" class="btn btn-primary" onclick="commentWrite()">답변</button>
        </div>
        </c:if>
    </div>
</div>

<script>

    function commentWrite(){
        const writer = $('#commentWriter').val();
        const content = $('#commentContent').val();
        const board = '${board.inquiryNum}';

        $.ajax({
            type: "post",
            url: "/inquiry/comment/save",
            data: {
                commentWriter: writer,
                commentContent: content,
                boardId: board
            },
            dataType: "json",
            success: function (commentList) {
                console.log("작성성공");
                console.log(commentList);

                let output = "<table>";
                output += "<tr><th>작성자</th>";
                output += "<th>내용</th>";
                output += "<th>작성시간</th></tr>";
                for (let i in commentList) {
                    let formattedDate = moment(commentList[i].commentCreateTime).format('YYYY-MM-DD');
                    output += "<tr>";
                    output += "<td>" + commentList[i].commentWriter + "</td>";
                    output += "<td>" + commentList[i].commentContent + "</td>";
                    output += "<td>" + formattedDate + "</td>";
                    output += "</tr>";
                }
                output += "</table>";
                $('#comment-list').html(output);
                $('#commentWriter').val('');
                $('#commentContent').val('');
            },
            error: function (request, status, error) {
                console.error("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });
    }
</script>
</body>
</html>
