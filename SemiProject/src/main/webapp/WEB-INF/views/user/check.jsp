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
		$('#modify_pw_area').hide();
		check_pw_user();
		fn_init();
		fn_pwCheck();
		fn_pwCheckAgain();
		fn_pwSubmit();
	});
	
	// 서브밋전 비번 입력을 확인하기 위한 지역변수
	var pwPass = false;
	var rePwPass = false;
	
	// 로그인한 유저의 비밀번호가 맞는지 확인	
	function check_pw_user(){
		$('#btn_check_pw').click(function(){
			$.ajax({
				type: 'post',
				url: '${contextPath}/user/check/pw',
				data: 'pw=' + $('#user_pw').val(),
				dataType: 'json',
				success: function(resData){
					if(resData.isUser){
						$('#modify_pw_area').show();
					} else {
						alert('비밀번호가 일치하지 않습니다.');
					}
				}
			});
		});
	}
	
	function fn_init(){
		$('#pw').val('');
		$('#re_pw').val('');
		$('#msg_pw').text('');
		$('#msg_re_pw').text('');
	}
	
	function fn_pwCheck(){
		
		$('#pw').keyup(function(){
			
			let pwValue = $(this).val();
			
			let regPw = /^[0-9a-zA-Z!@#$%^&*]{8,20}$/;
			
			let validatePw = /[0-9]/.test(pwValue)        // 숫자가 있으면 true, 없으면 false
			               + /[a-z]/.test(pwValue)        // 소문자가 있으면 true, 없으면 false
			               + /[A-Z]/.test(pwValue)        // 대문자가 있으면 true, 없으면 false
			               + /[!@#$%^&*]/.test(pwValue);  // 특수문자8종이 있으면 true, 없으면 false
			
			if(regPw.test(pwValue) == false || validatePw < 3){
				$('#msg_pw').text('8~20자의 소문자, 대문자, 숫자, 특수문자(!@#$%^&*)를 3개 이상 조합해야 합니다.');
				pwPass = false;
			} else {
				$('#msg_pw').text('사용 가능한 비밀번호입니다.');
				pwPass = true;
			}
		});
	}
	
	function fn_pwCheckAgain(){
		$('#re_pw').keyup(function(){
			let rePwValue = $(this).val();
			if(rePwValue != '' && rePwValue != $('#pw').val()){
				$('#msg_re_pw').text('비밀번호를 확인하세요.');
				rePwPass = false;
			} else {
				$('#msg_re_pw').text('');
				rePwPass = true;
			}
		});
	}
	
	function fn_pwSubmit(){
		
		$('#frm_edit_pw').submit(function(event){
			
			if(pwPass == false || rePwPass == false){
				alert('비밀번호 입력을 확인하세요.');
				event.preventDefault();
				return;
			}
		});
	}
	
	
	
</script>
</head>
<body>

	<div>
	
		<div>개인정보보호를 위해서 비밀번호를 다시 한 번 입력하세요</div>
		
		<div>
			<label for="user_pw">비밀번호</label>
			<input type="password" id="user_pw">
		</div>
		
		<div>
			<input type="button" value="취소" onclick="history.back()">
			<input type="button" value="확인" id="btn_check_pw">
		</div>
		
	</div>
	
	<hr>

	<div id="modify_pw_area">
		<div>변경할 비밀번호를 입력하세요.</div>
			<form id="frm_edit_pw" action="${contextPath}/user/modify/pw" method="post">
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
			</form>
	</div>
</body>
</html>