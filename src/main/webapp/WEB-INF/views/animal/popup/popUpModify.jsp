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
        <form class="form" action="/popup/modify" method="post" enctype="multipart/form-data">
          <input type="hidden" name="id" id="id" value="<c:out value="${popUp.id}"/>">
          <input type="hidden" name="folder_nm" id="folder_nm" value="popup" />
          <input type="hidden" name="FILE_NO" id="FILE_NO" value="" />
          <div>
            <label>제목</label>
            <input type="text" id="title" name="title" value="${popUp.title}" autocomplete="off" required>
          </div>
          <div>
            <label>내용</label>
            <textarea type="text" id="summernote" name="content" value="${popUp.content}" autocomplete="off" required>${popUp.content}</textarea>
          </div>
          <div>
            <label>링크URL</label>
            <input type="text" id="link_url" name="link_url" value="${popUp.link_url}" autocomplete="off" required>
          </div>
          <div>
          <label>시작 날짜</label>
          <input type="datetime-local" id="start_date" name="start_date"
                 value="<fmt:formatDate value='${popUp.start_date}' pattern='yyyy-MM-dd\'T\'HH:mm'/>"
                 autocomplete="off" required>
          </div>
          <div>
            <label>끝 날짜</label>
            <input type="datetime-local" id="end_date" name="end_date"
                   value="<fmt:formatDate value='${popUp.end_date}' pattern='yyyy-MM-dd\'T\'HH:mm'/>"
                   autocomplete="off" required>
          </div>
          <div>
            <label>상태</label>
              <select class="status" name="status" required>
                <option value="">---</option>
                <option value="ACTIVE" <c:if test="${popUp.status == 'ACTIVE'}">selected</c:if>>ACTIVE</option>
                <option value="INACTIVE" <c:if test="${popUp.status == 'INACTIVE'}">selected</c:if>>INACTIVE</option>
              </select>
          </div>
          <div class="form-group">
            <div>
              <input type="file" name="file" class="file">
              <div id="fileIndex">
                <c:forEach var="file" items="${file}" varStatus="var">
                  <div>
                    <a href="#" id="fileName" onclick="fn_fileDown('${file.FILE_NO}', '${file.FOLDER_NM}'); return false;" class="${file.FILE_NO}">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}kb)
                    <button type="button" class="fileDel_btn" onclick="fnDel('${file.BNO}', '${file.FILE_NO}', this)">삭제</button>
                  </div>
                </c:forEach>
              </div>
            </div>
          </div>
        </form>
        <button type="button" class="btn-danger popUpRegister">수정</button>
        <button type="button" class="btn-danger cancel">취소</button>
      </div>
    </div>
  </div>
</div>

<script>

  function toggleFileAddButton() {
    if ($("#fileIndex").children().length > 0) {
      $(".file").css('display', 'none');
    } else {
      $(".file").css('display', 'flex');

    }
  }

  $(document).ready(function() {
    toggleFileAddButton();
  });

  $('.popUpRegister').on('click', function() {
    $('.form').submit();
  });
  $('.cancel').on('click', function() {
    self.location.href = '/popUp/list';
  });

  function fnDel(reviewNum, fileNo, element) {

    let folder_nm = "${popUp.folder_nm}";


    if (reviewNum != '' && reviewNum != null) {
      $(element).closest('div').remove();
      $.ajax({
        url: '/animal/fileRemove',
        method: 'POST',
        data: {fileNo: fileNo, reviewNum: reviewNum, folder_nm : folder_nm},
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
  var fileIndex = 1;
  $('.fileAdd').on('click', function () {
    $("#fileIndex").append("<div><input type='file' style='float:left;' name='file_" + fileIndex++ + "'>"
            + "<button type='button' class='fileDel_btn'>삭제</button></div>");
    $(".file").css('display', 'none');

  });

  $(document).on("click",".fileDel_btn", function(){
    $(this).parent().remove();
    $(".file").css('display', 'flex');


  });


  function fn_fileDown(fileNo, folder){
    var formObj = $(".form");
    $("#FILE_NO").attr("value", fileNo);
    $("#FOLDER_NM").attr("value", folder);
    formObj.attr("action", "/animal/fileDown");
    formObj.submit();
  }

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
