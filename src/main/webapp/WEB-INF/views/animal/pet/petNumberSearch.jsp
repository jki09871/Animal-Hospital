<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/resources/jquery-3.7.1.js"></script>

<html>
<head>
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
        button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            text-align: center;
        }
        button:hover {
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
    </style>
</head>
<body>
    <div class="container-stories">
        <div class="container">
            <h1 class="text-primary text-center" style="margin-top: 90px;">REVIEW  DETAIL</h1>
            <div class="search_wrap">
                <div class="search_area">
                    <select name="type">
                        <option value="" <c:out value="${pageMaker.pagingCriteria.type == null?'selected':'' }"/>>--</option>
                        <option value="N" <c:out value="${pageMaker.pagingCriteria.type eq 'N'?'selected':'' }"/>>동물 이름</option>
                        <option value="I" <c:out value="${pageMaker.pagingCriteria.type eq 'I'?'selected':'' }"/>>마이크로칩 번호</option>
                        <option value="IN" <c:out value="${pageMaker.pagingCriteria.type eq 'IN'?'selected':'' }"/>>이름 + 마이크로칩</option>
                    </select>
                    <input type="text" name="keyword" value="${pageMaker.pagingCriteria.keyword }">
                    <button id="Search">Search</button>
                </div>
            </div>
            <table>
                <thead>
                <tr>
                    <th>마이크로칩 번호</th>
                    <th>주인(ID)</th>
                    <th>동물 이름</th>
                    <th>동물 나이</th>
                    <th>동물 종</th>
                    <th></th>
                </tr>
                </thead>
                <c:forEach var="list" items="${petList}">
                    </td>
                        <td><a class="pet_Id" data-pet-id="<c:out value="${list.pet_Id}"/>"><c:out value="${list.pet_Id}"/></a></td>
                        <td><c:out value="${list.owner_Id}"/></td>
                        <td><c:out value="${list.pet_name}"/></td>
                        <td><c:out value="${list.age}"/>(살)</td>
                        <td><c:out value="${list.species}"/></td>
                        <td><button class="choice">선택</button></td>
                    </tr>
                </c:forEach>
            </table>
            <form id="pageMove" method="get" action="/registered/petNumberSearch">
                <input type="hidden" name="keyword" value="<c:out value="${pageMaker.pagingCriteria.keyword}"/>">
                <input type="hidden" name="type" value="<c:out value="${pageMaker.pagingCriteria.type}"/>">
            </form>
        </div>
    </div>
</body>
</html>
<script>

    let pageMove = $('#pageMove');

    // function pet_number(num){
    //     let pet = num.textContent;
    //     opener.document.getElementById("pet_Id").value = pet;
    // }
    // document 준비 상태에서 코드 실행
    $(document).ready(function() {
        // '.container-stories' 내부에서 발생한 '.choice' 클릭 이벤트를 처리
        $('.container-stories').on('click', '.choice', function() {
            // 클릭된 버튼이 속한 행에서 '.pet_Id' 클래스를 가진 요소의 텍스트를 가져옴
            let petNum = $(this).closest('tr').find('.pet_Id').text(); // 또는 .data('pet-id') 사용 가능
            opener.document.getElementById("pet_Id").value = petNum;
            window.close();
        });
    });

    $(document).ready(function (){
        $("#Search").on("click", function(e){
            e.preventDefault();

            let type = $(".search_area select").val();
            let keyword = $(".search_area input[name='keyword']").val();



            pageMove.find("input[name='type']").val(type);
            pageMove.find("input[name='keyword']").val(keyword);
            pageMove.submit();
        });
    });
</script>
