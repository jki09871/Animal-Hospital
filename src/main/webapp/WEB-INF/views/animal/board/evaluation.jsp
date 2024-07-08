<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>




<div class="container-stories">
    <div class="container">
        <div >
            <form role="form" action="/animal/review" method="post" id="form" enctype="multipart/form-data">
                <input type="hidden" name="folderNm" id="folderNm" value="review">
                <h1>글쓰기</h1>
                <div>
                    <label>제목</label>
                    <input type="text" name="title" id="title">
                </div>
                <div>
                    <label>내용</label>
                    <textarea cols="form-control" rows="3" id="summernote" name="content"></textarea>
                </div>
                <div>
                    <label>작성자</label>
                    <input name="writer" type="text" id="writer" value="<c:out value="${sessionScope.loginId.owner_Id}"/>" readonly>
                </div>
                <div class="fileIndex">
                    <div>
                        <input type="file" name="file" style='float:left;' multiple>
                        <button type="button" class="fileDel_btn">삭제</button>
                    </div>
                </div>
                <button class="fileAdd btn" type="button">파일추가</button>
                <button type="button" class="btn submit-btn">등록</button>
                <button type="reset" onclick="history.back()" class="btn btn-cancel">취소</button>
            </form>
        </div>
    </div>
</div>


<script>




    $('.submit-btn').on('click', function () {
        let title = $('#title').val();
        let content = $('#summernote').val();
        let writer = $('#writer').val();

       if (title != '' && content != '' && writer != ''){
           alert("작성이 완료 되었습니다.");
           $('#form').submit();
       } else {
           alert("빈칸을 채워주세요");
       }
    });


    $('#summernote').summernote({
        codeviewFilter: true,
        codeviewIframeFilter: true,
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
        $(".fileIndex").append("<div><input type='file' style='float:left;' name='file' multiple>"
            + "<button type='button' class='fileDel_btn'>삭제</button></div>");

    });
    $(document).on("click",".fileDel_btn", function(){
        $(this).parent().remove();
location.href = 'www.naver.com';
    });

</script>
<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>
