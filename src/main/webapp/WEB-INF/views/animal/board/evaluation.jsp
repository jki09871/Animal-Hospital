<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>글쓰기</h1>
<div>
    <form role="form" action="/animal/review" method="post">
        <div>
            <label>제목</label>
            <input class="form-control" name="title">
        </div>
        <div>
            <label>내용</label>
            <textarea cols="form-control" rows="3" name="content"></textarea>
        </div>
        <div>
            <label>작성자</label>
            <input class="form-control" name="writer">
        </div>
        <button type="submit" class="btn btn-default">등록</button>
        <button type="reset" class="btn btn-default">취소</button>
    </form>
</div>
</body>
</html>
