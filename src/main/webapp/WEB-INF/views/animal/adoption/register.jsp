<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>

<style>
    .bold{
        font-weight: bold;
    }
</style>

<div class="container-stories">
    <div class="container">
        <div>
            <form role="form" action="/adoption/animal/register" method="post" enctype="multipart/form-data">
                <input type="hidden" name="folder_nm" id="folder_nm" value="adoption">
                <input type="hidden" id="adoptionStatus" name="adoptionStatus" value="Y">
                <div style="text-align: center;">
                    <h1>동물 정보 입력</h1>
                </div>
                <div>
                    <table class="table table-bordered">
                        <tbody>
                        <tr>
                            <td class="bold">동물 이름</td>
                            <td><input type="text" class="form-control" name="animal_name"></td>
                        </tr>
                        <tr>
                            <td class="bold">나이</td>
                            <td><input type="text" class="form-control" name="age"></td>
                        </tr>
                        <tr>
                            <td class="bold">종</td>
                            <td><input type="text" class="form-control" name="species"></td>
                        </tr>
                        <tr>
                            <td class="bold">성별</td>
                            <td>
                                <label class="radio-inline"><input type="radio" name="gender" value="M"> 수컷</label>
                                <label class="radio-inline"><input type="radio" name="gender" value="F"> 암컷</label>
                            </td>
                        </tr>
                        <tr>
                            <td class="bold">중성화 여부</td>
                            <td>
                                <label class="radio-inline"><input type="radio" name="neutering" value="Y"> 예</label>
                                <label class="radio-inline"><input type="radio" name="neutering" value="N"> 아니오</label>
                            </td>
                        </tr>
                        <tr>
                            <td class="bold">접종 종류</td>
                            <td><input type="text" class="form-control" name="inoculation"></td>
                        </tr>
                        <tr>
                            <td class="bold">좋아하는 것</td>
                            <td><input type="text" class="form-control" name="iLike"></td>
                        </tr>
                        <tr>
                            <td class="bold">싫어하는 것</td>
                            <td><input type="text" class="form-control" name="disLike"></td>
                        </tr>
                        <tr>
                            <td class="bold">상세 내용</td>
                            <td><textarea class="form-control" id="summernote" rows="5" name="content"></textarea></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="fileIndex">
                    <div>
                        <input type="file" name="thumbnails" multiple>
                    </div>
                </div>
                <div>
                    <button class="fileAdd btn" type="button">파일추가</button>
                    <button type="submit" class="btn">등록</button>
                    <button type="reset" onclick="history.back()" class="btn btn-cancel">취소</button>
                </div>
            </form>
        </div>
    </div>
</div>


<script>
    $(document).on("click",".fileDel_btn", function(){
        $(this).parent().remove();
    });



    // var  fileIndex = 1;
    // $('.fileAdd').on('click', function(){
    //    $('.fileIndex').append("<div><input type='file' style='float:left;' name='file_"+ fileIndex++ +"'>"
    //        + "<button type='button' class='fileDel_btn'>삭제</button></div>");
    // });

    $('.fileAdd').on('click', function() {
        $('.fileIndex').append(
            "<div>" +
            "<input type='file' style='float:left;' name='files' multiple>" +
            "<button type='button' class='fileDel_btn'>삭제</button>" +
            "</div>"
        );
    });

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

</script>

<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>
