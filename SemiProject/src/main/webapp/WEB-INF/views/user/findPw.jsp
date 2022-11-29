<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script>
	$(function(){
		fn_findID();
		fn_emailCheck();
		fn_join();
		fn_idCheck();
		$('#find_id_By_email').hide();
	})
	
	function fn_findID(){
		$('#findID').click(function (){
			location.href='${contextPath}/user/findId';
		});
	}
	
	// 전역변수 (각종 검사를 통과하였는지 점검하는 플래그 변수)
	var authCodePass = false;
	var idPass = false;
	
	function fn_emailCheck(){
		
		$('#btn_getAuthCode').click(function(){
			
			// 인증코드를 입력할 수 있는 상태로 변경함
			$('#authCode').prop('readonly', false);
			
			// resolve : 성공하면 수행할 function
			// reject  : 실패하면 수행할 function
			new Promise(function(resolve, reject) {
		
				// 정규식 
				let regEmail = /^[a-zA-Z0-9-_]+@[a-zA-Z0-9]+(\.[a-zA-Z]{2,}){1,2}$/;
				
				// 입력한 이메일
				let emailValue = $('#email').val();
				
				// 정규식 검사
				if(regEmail.test(emailValue) == false){
					reject(1);  // catch의 function으로 넘기는 인수 : 1(이메일 형식이 잘못된 경우)
					authCodePass = false;
					return;     // 아래 ajax 코드 진행을 막음
				}
				
				// 이메일 중복 체크
				$.ajax({
					/* 요청 */
					type: 'get',
					url: '${contextPath}/user/checkReduceEmail',
					data: 'email=' + $('#email').val(),
					/* 응답 */
					dataType: 'json',
					success: function(resData){
						// 기존 회원 정보에 등록된 이메일이라면 성공 처리
						if(resData.isUser){
							resolve();   // Promise 객체의 then 메소드에 바인딩되는 함수
						} else {
							reject(2);   // catch의 function으로 넘기는 인수 : 2(다른 회원이 사용중인 이메일이라서 등록이 불가능한 경우)
						}
					}
				});  // ajax
				
			}).then(function(){
				
				// 인증번호 보내는 ajax
				$.ajax({
					/* 요청 */
					type: 'get',
					url: '${contextPath}/user/sendAuthCode',
					data: 'email=' + $('#email').val(),
					/* 응답 */
					dataType: 'json',
					success: function(resData){
						alert('인증코드를 발송했습니다. 이메일을 확인하세요.');
						// 발송한 인증코드와 사용자가 입력한 인증코드 비교
						$('#btn_verifyAuthCode').click(function(){
							if(resData.authCode == $('#authCode').val()){
								
								alert('인증되었습니다.');
								authCodePass = true;
							} else {
								alert('인증에 실패했습니다.');
								authCodePass = false;
							}
						});
					},
					error: function(jqXHR){
						alert('인증번호 발송이 실패했습니다.');
						authCodePass = false;
					}
				});  // ajax
				
			}).catch(function(code){  // 인수 1 또는 2를 전달받기 위한 파라미터 code 선언

				switch(code){
				case 1:
					$('#msg_email').text('이메일 형식이 올바르지 않습니다.');
					break;
				case 2:
					$('#msg_email').text('가입되지 않은 이메일입니다.');
					break;
				}
			
				authCodePass = false;
			
				// 입력된 이메일에 문제가 있는 경우 인증코드 입력을 막음
				$('#authCode').prop('readonly', true);
				
			});  // new Promise
			
		});  // click
		
	}  // fn_emailCheck
	
	
	// 서브밋 전 아이디, 이메일 검사
	function fn_join(){
		
		$('#findPw').click(function(event){
			
			if(authCodePass == false){
				alert('이메일 인증을 받으세요.');
				event.preventDefault();
				return;
			}
		}) // $('#frm_join')
		
		
	}
	
	
	// 1. 아이디 중복체크 & 정규식
	function fn_idCheck(){
		
		$('#fn_idCheck').click(function(){
			
			
			if($('#id').val == ''){
				alert('아이디를 입력하세요.');
				return;
			}
			
			
			// 회원아이디가 맞는지 체크
			$.ajax({
				/* 요청 */
				type: 'get',
				url: '${contextPath}/user/checkReduceId',
				data: 'id=' + $('#id').val(),
				/* 응답 */
				dataType: 'json',
				success: function(resData){  // resData = {"isUser": true, "isRetireUser": false}
					if(resData.isUser || resData.isRetireUser){
						$('#find_id_By_email').show();
						$('#msg_id').text($('#id').val());
					} else {
						alert('가입되지않은 아이디입니다. 아이디를 확인해주세요');
						$('#find_id_By_email').hide();
						$('#email').val('');
						$('#authCode').val('');
					}
				}
			});  // ajax
			
		});  // keyup
		
	}  // fn_idCheck
	
	
	
	

</script>
</head>
<body>

<div>
	<div>
		<h2>비밀번호 찾기</h2>
		<h6>비밀번호를 찾고자 하는 아이디를 입력하세요</h6>
		
		<form>
			<label for="id">아이디 입력</label>
			<input type="text" id="id" name="id">
			<input type="button" id="fn_idCheck" value="다음">
			<h6 id="findID">아이디가 기억나지 않는다면? 아이디찾기</h6>
		</form>
	</div>
	
	
	<div id="find_id_By_email">
	<hr>
		<h3>추가 인증을 진행합니다. 이메일을 입력해주세요(도메인포함)</h3>
		<!-- 위에서 입력한 아이디 고정시키기 -->
		<input type="hidden" id="msg_id">
		
		<div>
			<label for="email">이메일*</label>
			<input type="text" name="email" id="email">
			<input type="button" value="인증번호받기" id="btn_getAuthCode">
			<span id="msg_email"></span><br>
			<input type="text" id="authCode" placeholder="인증코드 입력">
			<input type="button" value="인증하기" id="btn_verifyAuthCode">
		</div>
		<div>
			<span id="msg_showPw"></span>
		</div>
	</div>
	
	
</div>





</body>
</html>