<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
</head>
<body>

	<div>
		<h1>게시판 정보</h1>
		<ul>
			<li>제목 : ${bbs.bbsTitle}</li>
			<li>내용 : ${bbs.content}</li>
			<li>작성일 : ${bbs.createDate}</li>
		</ul>
	</div>
	
</body>
</html>