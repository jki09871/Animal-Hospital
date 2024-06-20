<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/resources/jquery-3.7.1.js"></script>
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>

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
            margin-top: 120px;
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
        .search_area select{
            height: 35px;
        }
    </style>
</head>
<body>
<h2>Medical Records</h2>
<div class="btn-container">
    <a href="/" class="btn">홈으로</a>
    <a href="/pet/prescription/record" class="btn">처방전 작성</a>
</div>
<table>
    <tr>
        <th>마이크로칩 번호</th>
        <th>동물 이름</th>
        <th>동물 나이</th>
        <th>견종</th>
        <th>특이사항</th>
    </tr>
    <c:forEach var="list" items="${recordList}">
        <tr class="pet_info">
            <td>${list.pet_Id}</td>
            <td><a class="move" href="${list.pet_Id}">${list.pet_name}</a></td>
            <td>${list.age}살</td>
            <td>${list.species}</td>
            <td>${list.significant}</td>
        </tr>
    </c:forEach>
</table>
<div class="container">
    <div class="search_wrap">
        <div class="search_area">
            <select name="type">
                    <option value="" <c:out value="${pageMaker.pagingCriteria.type == null?'selected':'' }"/>>--</option>
                    <option value="N" <c:out value="${pageMaker.pagingCriteria.type eq 'N'?'selected':'' }"/>>동물 이름</option>
                    <option value="I" <c:out value="${pageMaker.pagingCriteria.type eq 'I'?'selected':'' }"/>>마이크로칩 번호</option>
                    <option value="IN" <c:out value="${pageMaker.pagingCriteria.type eq 'IN'?'selected':'' }"/>>이름 + 마이크로칩</option>
            </select>
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
                        <li class="pageInfo_btn ${pageMaker.pagingCriteria.pageNum == num ? "active":""}"><a href="${num}">${num}</a></li>
                    </c:forEach>

                    <c:if test="${pageMaker.next}">
                        <li class="pageInfo_btn next"><a href="${pageMaker.endPage + 1}">next</a></li>
                    </c:if>
                </ul>
            </div>
        </div>
</div>
    <form id="pageMove" method="get" action="/pet/prescription/list">
        <input type="hidden" name="pageNum" value="${pageMaker.pagingCriteria.pageNum}">
        <input type="hidden" name="amount" value="${pageMaker.pagingCriteria.amount}">
        <input type="hidden" name="keyword" value="${pageMaker.pagingCriteria.keyword }">
        <input type="hidden" name="type" value="${pageMaker.pagingCriteria.type }">
    </form>
</body>

<script>
    let pageMove = $('#pageMove');

    $(document).ready(function (){
        $(".search_area button").on("click", function(e){
            e.preventDefault();

            let type = $(".search_area select").val();
            let keyword = $(".search_area input[name='keyword']").val();

            if(!type && keyword){
                alert("검색 종류를 선택하세요.");
                return false;
            }

            if(!keyword && type){
                alert("키워드를 입력하세요.");
                return false;
            }

            if(!type || !keyword){
                pageMove.submit();
            }

            pageMove.find("input[name='type']").val(type);
            pageMove.find("input[name='keyword']").val(keyword);
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
});
</script>

</html>
<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>
