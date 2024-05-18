<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <title>글 읽기</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
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
    </style>
</head>
<body>
<div class="container">
    <h1 class="text-center">글 읽기</h1>
    <div class="panel-body">
        <div class="form-group">
            <label for="inquiryNum">게시물 번호</label>
            <input type="text" class="form-control" id="inquiryNum" name="inquiryNum" value="<c:out value="${board.inquiryNum}"/>" readonly>
        </div>
        <div class="form-group">
            <label for="title">제목</label>
            <input type="text" class="form-control" id="title" name="title" value="<c:out value="${board.title}"/>" readonly>
        </div>
        <div class="form-group">
            <label for="content">내용</label>
            <textarea rows="3" class="form-control" id="content" name="content" readonly><c:out value="${board.content}"/></textarea>
        </div>
        <div class="form-group">
            <label for="writer">작성자</label>
            <input type="text" class="form-control" id="writer" name="writer" value="<c:out value="${board.writer}"/>" readonly>
        </div>
        <div class="text-center">
            <a href="/pet/inquiry/modify?inquiryNum=${board.inquiryNum}" class="btn btn-warning">수정</a>
            <a href="/pet/inquiry/list" class="btn btn-info">목록</a>
        </div>
        <div>
            <input type="text" id="commentWriter" placeholder="작성자">
            <input type="text" id="commentContents" placeholder="내용">
            <button id="comment-write-btn" onclick="commentWrite()">댓글작성</button>
        </div>
    </div>
</div>
</body>
<script>
    function commentWrite(){
        const writer = $('#commentWriter').val();
        const content = $('#commentContents').val();
        const board = '${board.inquiryNum}';

        $.ajax({
           type : "post",
           url : "/comment/save",
           data : {
               commentWriter : writer,
               commentContents : content,
               boardId : board
           },
           dataType : "json",
           success : function (commentList){
               console.log("작성성공")
           },
            error: function (request, status, error) {
                console.error("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });
    }
</script>
</html>
