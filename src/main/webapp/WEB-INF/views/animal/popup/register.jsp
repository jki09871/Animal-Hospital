<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>
<style>






    .inner {
        width: 100%;
        padding: 20px;
        background: #fff;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }


    .title {
        font-size: 24px;
        font-weight: bold;
        text-align: center;
    }


    label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
    }


    button {
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }


    .cancel {
        margin-left: 10px;
    }



</style>



<div class="container" >
    <div class="basic animal">
        <div class="inner" >
            <div class="top">
                <div class="title">팝업 등록</div>
            </div>
            <div class="ct">
                <form class="form" action="/popup/register/post" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="folder_nm" id="folder_nm" value="popup" />
                    <div>
                        <label>제목</label>
                        <input type="text" id="title" name="title" autocomplete="off" required>
                    </div>
                    <div>
                        <label>내용</label>
                        <input type="text" id="content" name="content" autocomplete="off" required>
                    </div>
                    <div>
                        <label>링크URL</label>
                        <input type="text" id="link_url" name="link_url" autocomplete="off" required>
                    </div>
                    <div>
                        <label>시작 날짜</label>
                        <input type="datetime-local" id="start_date" name="start_date" autocomplete="off" required>
                    </div>
                    <div>
                        <label>끝 날짜</label>
                        <input type="datetime-local" id="end_date" name="end_date" autocomplete="off" required>
                    </div>
                    <div>
                        <label>상태</label>
                        <select class="status" name="status" required>
                            <option value="">---</option>
                            <option value="ACTIVE">ACTIVE</option>
                            <option value="INACTIVE">INACTIVE</option>
                        </select>
                    </div>
                    <div class="fileIndex">
                        <div>
                            <input type="file" name="file" >
                        </div></br>
                    </div>
                </form>
                <button class="fileAdd btn-danger" type="button">파일추가</button>
                <button type="button" class="btn-danger popUpRegister">작성</button>
                <button type="button" class="btn-danger cancel">취소</button>
            </div>
        </div>
    </div>
</div>

<script>
    $('.popUpRegister').on('click', function() {
        $('.form').submit();
    });
    $('.cancel').on('click', function() {
        self.location.href = '/popUp/list';
    });

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
