<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/resources/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath}/resources/summernote/summernote-lite.js"></script>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/summernote/summernote-lite.css">
    <title>Title</title>
</head>
<body>
<h1>글쓰기</h1>
<div>
    <form role="form" action="/animal/review" method="post" enctype="multipart/form-data">
        <div>
            <label>제목</label>
            <input class="form-control" name="title">
        </div>
        <div>
            <label>내용</label>
            <textarea cols="form-control" rows="3" id="summernote" name="content"></textarea>
        </div>
        <div>
            <input type="hidden" name="writer" value="<c:out value="${sessionScope.loginId}"/>">
        </div>
        <div id="fileIndex">
            <div>
            <input type="file" name="file"/>
            <button type="button" id="fileDel">파일삭제</button>
            </div>

        </div>
        <button class="fileAdd_btn" type="button">파일추가</button>
        <button type="submit" class="btn btn-default">등록</button>
        <button type="reset" class="btn btn-default">취소</button>
    </form>
</div>
</body>

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
    var fileIndex = 1;
    $('.fileAdd_btn').on('click', function () {
        $("#fileIndex").append("<div><input type='file' style='float:left;' name='file_" + fileIndex++ + "'>"
            + "<button type='button' class='fileRemove' onclick='fnDel(this)' id='fileDel'>삭제</button></div>");

    });
    $(document).on("click","#fileDel", function(){
        $(this).parent().remove();

    });

</script>
</html>
