<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/resources/jquery-3.7.1.js"></script>

<html>
<head>
    <script type="text/javascript" src="/resources/summernote" charset="UTF-8"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/summernote/summernote-lite.css">
    <title>Title</title>
</head>
<body>
<form id="myForm" action="/board/save" method="post">
    <div class="mb-4">
<c:choose>
    <c:when test="${sessionScope.naversessionId != null}">
        <input type="hidden" name="writer" placeholder="writer" value="${sessionScope.naversessionId}">
    </c:when>
    <c:when test="${sessionScope.kakaosessionId != null}">
        <input type="hidden" name="writer" placeholder="writer" value="${sessionScope.kakaosessionId}">
    </c:when>
    <c:when test="${loginEmail != null}">
        <input type="hidden" name="writer" placeholder="writer" value="${loginEmail}">
    </c:when>
</c:choose>
    </div>
    <input type="text" name="title" placeholder="title">
    <div class="col-md-10" style="margin-left:80px;">
        <textarea id="summernote" rows="5" name="content" style="width:100%; height:250px;"></textarea>
    </div>
    <input type="submit" value="작성">
</form>
</body>
<%--<script src="${pageContext.request.contextPath}/resources/summernote/lang/summernote-ko-KR.js"></script>--%>
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
                for (var i = files.length -1; i>=0; i--){
                    sendFile(files[i],this);
                }
            }
        }
    });

    function sendFile(file, editor){
        var formData = new FormData();
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
