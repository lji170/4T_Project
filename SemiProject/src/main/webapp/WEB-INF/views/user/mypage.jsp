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



$(function(){
	ifNaverUser();
});


function ifNaverUser(){
	$('#ifNaverUser').click(){
		alert('네이버 간편가입회원은 이용하실 수 없습니다.');
	};
}




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
			 <c:if test="${loginUser.snsType eq 'naver'}">
			 	<li>네이버 간편가입 회원</li>
			 </c:if>
			 	<li>성함 : ${loginUser.name}</li>
			 	<li>이메일 : ${loginUser.email}</li>
			<c:choose>
				<c:when test="${loginUser.gender eq 'NO'}">
					<li>성별 : 선택안함</li>
				</c:when>
				<c:otherwise>
					<li>성별 : ${loginUser.gender}</li>
				</c:otherwise>
			</c:choose>
			 	<li>생년월일 : ${loginUser.birthyear}.${loginUser.birthday}</li>
			 	<li>핸드폰번호 : ${loginUser.mobile}</li>
			 	<li>주소 : [${loginUser.postcode}]${loginUser.roadAddress}&nbsp;${loginUser.detailAddress}&nbsp;${loginUser.extraAddress}</li>
			 	<li>보유 포인트 : ${loginUser.point}</li>
			 </ul>
			 <a href="${contextPath}/user/info/change/jsp">정보수정하기</a>
		</div>
		
		<hr>
		
		
		<div>
			<c:if test="${loginUser.snsType eq 'naver'}">
				<a id="ifNaverUser">보안설정</a>
			</c:if>
			<c:if test="${loginUser.snsType eq null}">
				<a href="${contextPath}/user/check/move">보안설정</a>
			</c:if>

		</div>
	
		<hr>
		
		<a href="${contextPath}/move/index">홈으로가기</a>
	
	</div>
	
</body>
</html>