<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="/resources/inquiry.css">
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>

<div class="container-stories">
    <div class="container">
        <div class="basic animal">
            <h1 class="text-primary text-center" style="margin-top: 90px;">PET REVIEWS</h1>
            <form id="updateForm" action="/animal/correction" method="post" enctype="multipart/form-data">
                <input type="hidden" name="reviewNum" id="reviewNum" value="<c:out value="${animal.reviewNum}"/>">
                <input type="hidden" name="pageNum" id="pageNum" value="<c:out value="${cri.pageNum}"/>">
                <input type="hidden" name="amount" id="amount" value="<c:out value="${cri.amount}"/>">
                <input type="hidden" name="writer" id="writer" value="<c:out value="${animal.writer}"/>">

                <table>
                    <tr>
                        <th>title</th>
                        <td><input type="text" name="title" value="<c:out value="${animal.title}"/>"></td>
                    </tr>
                    <tr>
                        <th>content</th>
                        <td>
                            <!-- Editor -->
                            <textarea id="summernote" rows="5" name="content" style="width:100%; height:250px;">${animal.content}</textarea>
                        </td>
                        <td><input type="submit" value="수정"></td>
                        <td><input type="button" onClick="history.back();" value="취소"></td>
                    </tr>
                </table>
                <!-- File Uploads -->
                <div>
                    <div id="fileIndex">
                        <c:forEach var="file" items="${file}" varStatus="var">
                            <div>
                                <a href="#" id="fileName" class="${file.FILE_NO}">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}kb)
                                <button type="button" class="fileRemove" onclick="fnDel('${file.BNO}', '${file.FILE_NO}', this)">삭제</button>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <button type="button" id="fileAdd_btn">파일추가</button>
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
    $('#fileAdd_btn').on('click', function () {
        $("#fileIndex").append("<div><input type='file' style='float:left;' name='file_" + fileIndex++ + "'>"
            + "<button type='button' class='fileRemove' id='fileDel'>삭제</button></div>");

    });

    function fnDel(reviewNum, fileNo, element) {


        if (reviewNum != '' && reviewNum != null) {
            $(element).closest('div').remove();
            $.ajax({
                url: '/animal/fileRemove',
                method: 'POST',
                data: {fileNo: fileNo, reviewNum: reviewNum},
                success: function () {
                    console.log("reviewNum: " + reviewNum);
                    console.log("fileNo: " + fileNo);
                    console.log("파일 삭제 성공");
                },
                error: function (request, status, error) {
                    console.error("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                }
            });
        }
        $(element).closest('div').remove();
    }


    $(document).ready(function() {
        // 삭제 버튼에 대한 클릭 이벤트 핸들러 설정
        $(document).off('click', '.fileRemove').on('click', '.fileRemove', function() {
            var reviewNum = $(this).data('reviewnum');
            var fileNo = $(this).data('fileno');
            fnDel(reviewNum, fileNo, this);
        });
    });
</script>
<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>
