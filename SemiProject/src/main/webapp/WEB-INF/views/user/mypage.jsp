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
<script>



</script>
</head>
<body>

	<div>
	
		<h2>${loginUser.name}님의 마이페이지</h2>
		
		<hr>
		
		<div>
		이력
			<ul>
			    <li>가입일 : ${loginUser.joinDate}</li>
			    <li>최근 비밀번호 수정일 : ${loginUser.pwModifyDate}</li>
			    <li>최근 정보 수정일 : ${loginUser.infoModifyDate}</li>
			</ul>
		</div>
				
		<hr>
		
		<div>
			<a href="${contextPath}/user/check/move">보안설정</a>
		</div>
	
	
	</div>
	
</body>
</html>