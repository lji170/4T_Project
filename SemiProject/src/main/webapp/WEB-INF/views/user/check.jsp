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
		
		 fn_click_check_pw();
		

		
	});
	
	// 유저테이블에 들어간 비밀번호와, 입력된 비밀번호의 값이 일치하는지 확인하는 ajax
	function fn_click_check_pw(){
		
		$('#btn_check_pw').click(function(){
			
			$.ajax({
				
				type: 'post',
				url: '${contextPath}/user/check/pw',
				data: 'pw=' + $('#pw').val(),
				
				dataType: 'json',
				success: function(resData){
					if(resData.isUser){
						alert('비밀번호 변경이 완료되었습니다.');
					} else {
						alert('비밀번호를 확인하세요.');
					}
				}
				
			});
			
		});
		
	}
	
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

	<div>
		<div>변경할 비밀번호를 입력하세요.</div>
			<div>
				<label for="pw">비밀번호</label>
				<input type="password" name="pw" id="pw">
				<span id="msg_pw"></span>
			</div>
			<div>
				<label for="re_pw">비밀번호 확인</label>
				<input type="password" id="re_pw">
				<span id="msg_re_pw"></span>
			</div>
			<div>
				<button>비밀번호 변경하기</button>
				<input type="button" value="취소하기" id="btn_edit_pw_cancel">
			</div>
	</div>
</body>
</html>