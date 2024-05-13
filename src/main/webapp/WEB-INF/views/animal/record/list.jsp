<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/resources/jquery-3.7.1.js"></script>

<html>
<head>
    <title>Title</title>
    <style>
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        h2 {
            /* 수평 중앙 정렬하기 */
            text-align: center;
        }
        .btn-container {
            text-align: center;
            margin-top: 20px;
        }
        .btn {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
        }
        .btn:hover {
            background-color: #45a049;
        }

        .pageInfo{
            list-style : none;
            display: inline-block;
            margin: 50px 0 0 100px;
        }
        .pageInfo li{
            float: left;
            font-size: 20px;
            margin-left: 18px;
            padding: 7px;
            font-weight: 500;
        }
        a:link {color:black; text-decoration: none;}
        a:visited {color:black; text-decoration: none;}
        a:hover {color:black; text-decoration: underline;}
        .active{
            background-color: #cdd5ec
        }
        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center; /* 가운데 정렬 */

        }

        .search_wrap {
            margin-bottom: 20px; /* 페이지 정보와의 간격 조정 */
        }
        .search_area input{
            height: 30px;
            width: 250px;
        }
        .search_area button{
            width: 100px;
            height: 36px;
        }

    </style>
</head>
<body>
<h2>Medical Records</h2>
<div class="btn-container">
    <a href="/" class="btn">Go back to Home</a>
    <a href="/pet/prescription/record" class="btn">RecordWrite</a>
</div>
<table>
    <tr>
        <th>Pet ID</th>
        <th>Pet Name</th>
        <th>Pet Age</th>
        <th>Date of Visit</th>
    </tr>
    <c:forEach var="list" items="${recordList}">
        <tr class="pet_info">
            <td>${list.pet_Id}</td>
            <td><a class="move" href="${list.pet_Id}">${list.pet_Name}</a></td>
            <td>${list.pet_Age}(${list.calculated_age}살)</td>
            <td><fmt:formatDate value="${list.date_Of_Visit}" pattern="yyyy-MM-dd"/></td>
        </tr>
    </c:forEach>
</table>
<div class="container">
    <div class="search_wrap">
        <div class="search_area">
            <input type="text" name="keyword" value="${pageMaker.pagingCriteria.keyword }">
            <button>Search</button>
        </div>
    </div>

        <div class="pageInfo_wrap">
            <div class="pageInfo_area">
                <ul class="pageInfo" id="pageInfo">
                    <%-- 이전 버튼 구현--%>
                    <c:if test="${pageMaker.prev}">
                        <li class="pageInfo_btn previous"><a href="${pageMaker.startPage-1}">prev</a></li>
                    </c:if>

                    <%-- 각 번호 페이지 버튼 --%>
                    <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                        <li class="pageInfo_btn ${pageMaker.pagingCriteria.pageNum == num ? "active":""}"><a href="${num}">${num}</a> </li>
                    </c:forEach>

                    <c:if test="${pageMaker.next}">
                        <li class="pageInfo_btn next"><a href="${pageMaker.endPage + 1}">next</a></li>
                    </c:if>
                </ul>
            </div>
        </div>
</div>
    <form id="pageMove" method="get" action="/pet/prescription/list">
        <input type="hidden" name="pageNum" value="<c:out value="${pageMaker.pagingCriteria.pageNum}"/>">
        <input type="hidden" name="amount" value="<c:out value="${pageMaker.pagingCriteria.amount}"/>">
        <input type="hidden" name="keyword" value="${pageMaker.pagingCriteria.keyword }">
    </form>
</body>

<script>
    let pageMove = $('#pageMove');

    $(".search_area button").on("click", function(e){
        e.preventDefault();
        let val = $("input[name='keyword']").val();
        pageMove.find("input[name='keyword']").val(val);
        pageMove.find("input[name='pageNum']").val(1);
        pageMove.submit();
    });


    $(".pageInfo a").on("click", function(e){
    e.preventDefault();
    pageMove.find("input[name='pageNum']").val($(this).attr("href"));
    pageMove.attr("action", "/pet/prescription/list");
    pageMove.submit();

    });

    $('.move').on('click', function (e) {
        e.preventDefault();

        pageMove.find('#newinput').remove();

        pageMove.append("<input type='hidden' id='newinput' name='pet_Id' value='" + $(this).attr("href") + "'>");
        pageMove.attr('action', '/pet/prescription/details');
        pageMove.submit();
    })
</script>

</html>
