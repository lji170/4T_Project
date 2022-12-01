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
		회원정보 : 
			 <ul>
			 <c:if test="${loginUser.snsType}">
			 	<li>네이버 간편가입 회원</li>
			 </c:if>
			 	<li>성함 : ${name}</li>
			 	<li>성별 : ${GENDER}</li>
			 	<li>생년월일 : ${birthyear}.${birthday}</li>
			 	<li>핸드폰번호 : ${mobile}</li>
			 	<li>우편번호 : [${postcode}]</li>
			 	<li>보유 포인트 : </li>
			 </ul>
		</div>
		
		<hr>
		
		
		<div>
			<a href="${contextPath}/user/check/move">보안설정</a>
		</div>
	
	
	</div>
	
</body>
</html>