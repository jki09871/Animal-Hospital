<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/resources/jquery-3.7.1.js"></script>


<html>
<head>

    <script src="/resources/smarteditor2-2.8.2.3/js/HuskyEZCreator.js"></script>

    <title>Title</title>
</head>
<body>
    <form action="/board/save" method="post">
        <div class="mb-4">
        <input type="text" name="writer" placeholder="writer">
        </div>
        <input type="text" name="title" placeholder="title">
        <div class="post-form">
            <textarea rows="20" name="form-control" id="form-control"></textarea>
        </div>
        <input type="submit" value="작성">
    </form>
</body>
<script>
    $(document).ready(function () {

        <!-- SmartEditor2 텍스트편집기 -->
        var oEditors = [];
        function smartEditorIFrame() {

            nhn.husky.EZCreator.createInIFrame({
                oAppRef : oEditors,
                elPlaceHolder : "form-control",
                sSkinURI : "/resources/smarteditor2-2.8.2.3/SmartEditor2Skin.html",
                fCreator : "createSEditor2"
            });
        }
        smartEditorIFrame();
    });

</script>
</html>
