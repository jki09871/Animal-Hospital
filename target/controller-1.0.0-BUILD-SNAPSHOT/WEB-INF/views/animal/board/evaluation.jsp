<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>



<%--<style>
    body {
        margin: 0;
        font-family: Arial, sans-serif;
        overflow-x: hidden; /* 수평 스크롤 막기 */
        display: flex;
        justify-content: center; /* 가로 중앙 정렬 */
        align-items: center; /* 세로 중앙 정렬 */
        min-height: 100vh; /* 화면 전체 높이만큼 최소 높이 설정 */
    }

    form {
        width: 100%;
        max-width: 1100px;
        border: 1px solid #ccc;
        border-radius: 5px;
        background-color: #f9f9f9;
        padding: 20px;
        box-sizing: border-box; /* 내부 padding과 border를 포함하여 크기 지정 */
    }

    h1 {
        text-align: center;
        margin-top: 0;
        margin-bottom: 20px;
    }

    label {
        font-weight: bold;
    }

    input[type="text"],
    input[type="file"],
    textarea {
        width: calc(100% - 20px);
        padding: 10px;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 3px;
        font-size: 16px;
        box-sizing: border-box; /* 내부 padding과 border를 포함하여 크기 지정 */
    }

    textarea {
        height: 200px;
        resize: vertical;
    }

    .fileIndex {
        margin-bottom: 20px;
    }

    .fileIndex div {
        margin-bottom: 10px;
    }

    .fileAdd_btn,
    .fileDel_btn,
    .btn,
    .btn-cancel {
        padding: 10px 20px;
        border: none;
        border-radius: 3px;
        cursor: pointer;
        transition: opacity 0.3s;
    }

    .fileAdd_btn {
        background-color: #007bff;
        color: #fff;
        margin-right: 10px;
    }

    .btn,
    .btn-cancel {
        background-color: #28a745;
        color: #fff;
    }

    .btn-cancel {
        background-color: #dc3545;
    }

    .btn:hover,
    .btn-cancel:hover,
    .fileAdd_btn:hover,
    .fileDel_btn:hover {
        opacity: 0.8;
    }
</style>--%>

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
                        <input type="file" name="file"/>
                        <button type="button" class="fileDel_btn">파일삭제</button>
                    </div>
                </div>
                <button class="fileAdd_btn" type="button">파일추가</button>
                <button type="submit" class="btn">등록</button>
                <button type="reset" class="btn btn-cancel">취소</button>
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
    $('.fileAdd_btn').on('click', function () {
        $(".fileIndex").append("<div><input type='file' style='float:left;' name='file_" + fileIndex++ + "'>"
            + "<button type='button' class='fileDel_btn'>삭제</button></div>");

    });
    $(document).on("click",".fileDel_btn", function(){
        $(this).parent().remove();

    });

</script>
<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>
