<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/resources/jquery-3.7.1.js"></script>
<!-- 스마트 에디터 스크립트 추가 -->

<html>
<head>
    <script type="text/javascript" src="/resources/summernote" charset="UTF-8"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/summernote/summernote-lite.css">
    <title>Title</title>
</head>
<body>
<form id="updateForm" action="/board/update" method="post">
    <table>
        <tr>
            <th>title</th>
            <td><input type="text" name="title" value="<c:out value="${board.title}"/>"></td>
        </tr>
        <tr>
            <th>content</th>
            <td style="width: 600px;">
                <!-- 에디터를 표시할 textarea -->
                <textarea id="summernote" rows="5" name="content" style="width:100%; height:250px;">${board.content}</textarea>
            </td>
            <td><input type="submit" value="수정"></td>
        </tr>
    </table>
    <input type="hidden" name="bno" id="bno" value="<c:out value="${board.bno}"/>">
</form>
</body>
<script src="${pageContext.request.contextPath}/resources/summernote/summernote-lite.js"></script>

<script>
    $('#summernote').summernote({
        height: 300,
        width: 1000,
        minHeight: null,
        maxHeight: null,
        focus: true,
        lang: "ko-KR",
        callbacks: {
            onImageUpload : function(files) {
                for (var i = files.length - 1; i >= 0; i--) {
                    sendFile(files[i], this);
                }
            }
        }
    });

    function sendFile(file, editor){
        let formData = new FormData();
        formData.append("file", file);
        console.log(file);
        $.ajax({
            data : formData,
            type : "POST",
            url : "/ajaxUpload",
            contentType : false,
            processData : false,

            success : function (data){
                console.log(data);
                $(editor).summernote("insertImage", data.url);
            }
        });
    }


</script>
</html>
