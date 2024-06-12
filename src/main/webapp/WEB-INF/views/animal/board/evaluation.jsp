<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>




<div class="container-stories">
    <div class="container">
        <div >
            <form role="form" action="/animal/review" method="post" enctype="multipart/form-data">
                <h1>글쓰기</h1>
                <div>
                    <label>제목</label>
                    <input class="form-control" name="title">
                </div>
                <div>
                    <label>내용</label>
                    <textarea cols="form-control" rows="3" id="summernote" name="content"></textarea>
                </div>
                <div>
                    <input type="hidden" name="writer" value="<c:out value="${sessionScope.loginId.owner_Id}"/>">
                </div>
                <div class="fileIndex">
                    <div>
                        <input type="file" name="file" style='float:left;'>
                        <button type="button" class="fileDel_btn">삭제</button>
                    </div>
                </div>
                <button class="fileAdd btn" type="button">파일추가</button>
                <button type="submit" class="btn">등록</button>
                <button type="reset" onclick="history.back()" class="btn btn-cancel">취소</button>
            </form>
        </div>
    </div>
</div>


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
    $('.fileAdd').on('click', function () {
        $(".fileIndex").append("<div><input type='file' style='float:left;' name='file_" + fileIndex++ + "'>"
            + "<button type='button' class='fileDel_btn'>삭제</button></div>");

    });
    $(document).on("click",".fileDel_btn", function(){
        $(this).parent().remove();

    });

</script>
<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>
