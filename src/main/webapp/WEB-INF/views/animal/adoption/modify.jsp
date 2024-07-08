<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>
<style>
    .bold{
        font-weight: bold;
    }
</style>

<div class="container-stories">
    <div class="container" style="width: 1286px">
            <h1>동물 정보 수정</h1>
            <form role="form" action="/adoption/animal/information/modify" method="post" enctype="multipart/form-data">
                <input type="hidden" name="adoption_id" value="${modify.adoption_id}">
                <table class="table table-bordered">
                    <tbody>
                    <tr>
                        <th class="bold" >입양현황</th>
                        <th>
                            <label class="radio-inline"><input type="radio" name="adoptionStatus" value="Y"
                                                               <c:if test="${modify.adoptionStatus == 'Y'}">checked</c:if>> 가능</label>
                            <label class="radio-inline"><input type="radio" name="adoptionStatus" value="N"
                                                               <c:if test="${modify.adoptionStatus == 'N'}">checked</c:if>> 불가능</label>
                        </th>
                    </tr>
                    <tr>
                        <td class="bold" >동물 이름</td>
                        <td><input type="text" class="form-control" name="animal_name" value="<c:out value="${modify.animal_name}"/>"></td>
                        <td class="bold" >종</td>
                        <td><input type="text" class="form-control" name="species" value="<c:out value="${modify.species}"/>"></td>
                        <td class="bold" >중성화 여부</td>
                        <td>
                            <label class="radio-inline"><input type="radio" name="neutering" value="Y" <c:if test="${modify.neutering == 'Y'}">checked</c:if>> 예</label>
                            <label class="radio-inline"><input type="radio" name="neutering" value="N" <c:if test="${modify.neutering == 'N'}">checked</c:if>> 아니오</label>
                        </td>
                        <td class="bold" >좋아하는 것</td>
                        <td><input type="text" class="form-control" name="iLike" value="<c:out value="${modify.ILike}"/>"></td>
                    </tr>
                    <tr>
                        <td class="bold" >나이</td>
                        <td><input type="text" class="form-control" name="age" value=""<c:out value="${modify.age}"/>"></td>
                        <td class="bold" >성별</td>
                        <td>
                            <label class="radio-inline"><input type="radio" name="gender" value="M" <c:if test="${modify.gender == 'M'}">checked</c:if>> 수컷</label>
                            <label class="radio-inline"><input type="radio" name="gender" value="F" <c:if test="${modify.gender == 'F'}">checked</c:if>> 암컷</label>
                        </td>
                        <td class="bold" >접종 여부</td>
                        <td><input type="text" class="form-control" name="inoculation" value="<c:out value="${modify.inoculation}"/>"></td>
                        <td class="bold" >싫어하는 것</td>
                        <td><input type="text" class="form-control" name="disLike" value="<c:out value="${modify.disLike}"/>"></td>
                    </tr>
                    <tr>
                        <td class="bold" >상세 내용</td>
                        <td colspan="7"><textarea class="form-control" rows="5" name="content"><c:out value="${modify.content}"/></textarea></td>
                    </tr>
                    </tbody>
                </table>
                <div style="text-align: right;">
                    <button type="submit" class="btn btn-danger">수정 완료</button>
                    <button type="button" onclick="history.back()" class="btn btn-danger">취소</button>
                </div>
            </form>
    </div>
</div>
