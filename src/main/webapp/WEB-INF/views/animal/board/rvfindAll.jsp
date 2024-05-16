<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/resources/jquery-3.7.1.js"></script>

<html>
<head>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        #header {
            width: 100%;
            background-color: #f8f9fa;
            padding: 10px 0;
            text-align: center;
        }
        #header .menu {
            margin-top: 10px;
        }
        #header .menu button {
            margin: 0 5px;
            padding: 5px 10px;
            border: none;
            border-radius: 3px;
            background-color: #007bff;
            color: #fff;
            cursor: pointer;
        }
        #header .menu button a {
            color: #fff;
            text-decoration: none;
        }
        .basic.animal {
            margin-top: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .table-cell {
            width: 80%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        .table-cell th, .table-cell td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        .pageInfo {
            list-style: none;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 20px;
        }
        .pageInfo_btn {
            margin: 0 5px;
        }
        .pageInfo_btn a {
            text-decoration: none;
            color: #333;
            padding: 5px 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }
        .pageInfo_btn a:hover {
            background-color: #f0f0f0;
        }
        .active a {
            background-color: #007bff;
            color: #fff;
            border: 1px solid #007bff;
        }
    </style>
    <title>AnimalReviewList</title>
</head>
<body>
<div id="header">
    <h1>AnimalReviewList</h1>
    <div class="menu">
        <c:if test="${sessionScope.loginId.owner_Id != null}">
            <button id="regBtn">Write</button>
            <button><a href="/animal/logout">Logout</a></button>
            <button><a href="/animal/myInfo">My Info</a></button>
        </c:if>
        <c:if test="${sessionScope.loginId == null}">
            <button><a href="/animal/login">Login</a></button>
        </c:if>
        <button><a href="/">Home</a></button>
    </div>
</div>
<div class="basic animal">
    <table class="table-cell">
        <thead>
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>수정일</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="animal" items="${list}">
            <tr>
                <td><c:out value="${animal.reviewNum}"></c:out></td>
                <td><a class="move" href="${animal.reviewNum}"><c:out value="${animal.title}"></c:out></a></td>
                <td><c:out value="${animal.writer}"></c:out></td>
                <td><fmt:formatDate value="${animal.regdate}" pattern="yyyy-MM-dd"/></td>
                <td><fmt:formatDate value="${animal.updatetdate}" pattern="yyyy-MM-dd"/></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="pageInfo_wrap">
        <div class="pageInfo_area">
            <ul class="pageInfo" id="pageInfo">
                <c:if test="${pageMaker.prev}">
                    <li class="pageInfo_btn previous"><a href="${pageMaker.startPage-1}">prev</a></li>
                </c:if>
                <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                    <li class="pageInfo_btn ${pageMaker.pagingCriteria.pageNum == num ? 'active':''}"><a href="${num}">${num}</a></li>
                </c:forEach>
                <c:if test="${pageMaker.next}">
                    <li class="pageInfo_btn next"><a href="${pageMaker.endPage + 1}">next</a></li>
                </c:if>
            </ul>
        </div>
    </div>
    <form id="pageMove" method="get">
        <input type="hidden" name="pageNum" value="<c:out value='${pageMaker.pagingCriteria.pageNum}'/>">
        <input type="hidden" name="amount" value="<c:out value='${pageMaker.pagingCriteria.amount}'/>">
    </form>
</div>
</body>
<script>
    $(document).ready(function () {
        console.log("${sessionScope.loginId}");
        $('#regBtn').on('click', function (e){
            self.location = "/animal/review";
        });
    });

    $('.move').on('click', function (e) {
        e.preventDefault();
        let pageMove = $('#pageMove');
        pageMove.find('#newinput').remove();
        pageMove.append("<input type='hidden' id='newinput' name='reviewNum' value='" + $(this).attr("href") + "'>");
        pageMove.attr('action', '/animal/viewDetails');
        pageMove.submit();
    });

    $(".pageInfo a").on("click", function(e){
        e.preventDefault();
        let pageMove = $('#pageMove');
        pageMove.find("input[name='pageNum']").val($(this).attr("href"));
        pageMove.attr("action", "/animal/reviewList");
        pageMove.submit();
    });
</script>
</html>
