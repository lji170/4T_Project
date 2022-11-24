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
		
		$('#btn_check_pw').click(function(){
			
			$.ajax({
				
				type: 'post',
				url: '${contextPath}/user/check/pw',
				data: 'pw=' + $('#pw').val(),
				
				dataType: 'json',
				success: function(resData){
					if(resData.isUser){
						location.href = '${contextPath}/user/mypage';
					} else {
						alert('비밀번호를 확인하세요.');
					}
				}
				
			});
			
		});
		
	});
	
</script>
</head>
<body>

	<div>
	
		<div>개인정보보호를 위해서 비밀번호를 다시 한 번 입력하세요</div>
		
		<div>
			<label for="pw">비밀번호</label>
			<input type="password" id="pw">
		</div>
		
		<div>
			<input type="button" value="취소" onclick="history.back()">
			<input type="button" value="확인" id="btn_check_pw">
		</div>
		
	</div>

</body>
</html>