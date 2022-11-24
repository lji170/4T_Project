<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div>
		<h1>작성</h1>
		<form method="post" action="${contextPath}/bbs/add">
			<div>
				<input type="text" name="writer" placeholder="작성자" required>
			</div>
			<div>
				<input type="text" name="title" placeholder="제목" required>
			</div>
			<div>
				<button>작성완료</button>
				<input type="reset" value="입력초기화">
				<input type="button" value="게시판으로가기" onclick="location.href='${contextPath}/bbs/list'">
			</div>
		</form>
	</div>

</body>
</html>