<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

메세지(EL) : ${msg }
<br>
메세지(JSTL) : <c:out value="${msg}" />