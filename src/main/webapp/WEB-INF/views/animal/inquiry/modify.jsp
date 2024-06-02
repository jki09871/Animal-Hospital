<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="/resources/jquery-3.7.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="/resources/inquiry.css">

</head>
<body>
<div class="container">
    <div class="panel-body">
        <form role="form" id="modifyForm" action="/pet/inquiry/modify" method="post">
            <input type="hidden" name="inquiry_Num" value="${board.inquiry_Num}">
            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" class="form-control" id="title" name="title" value="<c:out value='${board.title}'/>">
            </div>
            <div class="form-group">
                <label for="content">내용</label>
                <textarea rows="3" class="form-control" id="content" name="content"><c:out value='${board.content}'/></textarea>
            </div>
            <div class="form-group">
                <label for="writer">작성자</label>
                <input type="text" class="form-control" id="writer" name="writer" value="<c:out value='${board.writer}'/>">
            </div>
            <div class="btn-toolbar">
                <button type="button" data-oper="modify" onclick="fnInquiry('M');" class="btn btn-success mr-2">등록</button>
                <button type="button" data-oper="remove" onclick="fnInquiry('R');" class="btn btn-danger mr-2">삭제</button>
                <button type="button" data-oper="list" onclick="fnInquiry('L');" class="btn btn-secondary">목록</button>
            </div>
        </form>
    </div>
</div>

<script>
    function fnInquiry(se) {
        let from = $('#modifyForm');
        let url = '';
        switch (se) {
            case 'M':
                url = "/pet/inquiry/modify";
                break;
            case 'R':
                url = "/pet/inquiry/remove";
                break;
            default:
                url = "/pet/inquiry/list";
        }
        from.attr('action', url);
        from.submit();
    }
</script>
</body>
</html>
<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>
