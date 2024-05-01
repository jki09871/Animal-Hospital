<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/resources/jquery-3.7.1.js"></script>

<html>
<head>
    <title>AnimalReviewList</title>
</head>
    <h1>AnimalReviewList</h1>
    <div>
        <button id="regBtn" style="color: green;">글쓰기</button>
    </div>
    <div class="basic animal">
        <table class="table-cell" id="dataTable" >
            <thead>
            <tr>
                <th>번호</th>
                <th>재목</th>
                <th>작성자</th>
                <th>작성일</th>
                <th>수정일</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach var="animal" items="${list}">
                <tr>
                    <td><c:out value="${animal.reviewNum}"></c:out></td>
                    <td><a href="/animal/viewDetails?reviewNum=${animal.reviewNum}"><c:out value="${animal.reviewTitle}"></c:out></a> </td>
                    <td><c:out value="${animal.reviewWriter}"></c:out></td>
                    <td><fmt:formatDate value="${animal.reviewregdate}" pattern="yyyy-MM-dd"/></td>
                    <td><fmt:formatDate value="${animal.reviewUpdate}" pattern="yyyy-MM-dd"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</body>
    <script>
        $(document).ready(function () {
            console.log("목록 페이지")
            $('#regBtn').on('click', function (e){
                self.location = "/animal/review";
            });

        });
    </script>
</html>
