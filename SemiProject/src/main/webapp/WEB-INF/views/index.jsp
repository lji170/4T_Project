<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 화면</title>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js" integrity="sha512-3j3VU6WC5rPQB4Ld1jnLV7Kd5xr+cq9avvhwqzbH/taCRNURoeEpoPBK9pDyeukwSxwRPJ8fDgvYXd6SkaZ2TA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

</head>
<body>

	<!-- 로그인이 안 된 상태 -->
	<c:if test="${loginUser == null}">
	<script>

	$(function(){
		
		fn_login();
		fn_displayRememberId();
		
	});
	
	function fn_login(){
		
		$('#frm_login').submit(function(event){
			
			// 아이디, 비밀번호 공백 검사
			if($('#id').val() == '' || $('#pw').val() == ''){
				alert('아이디와 비밀번호를 모두 입력하세요.');
				event.preventDefault();
				return;
			}
			
			// 아이디 기억을 체크하면 rememberId 쿠키에 입력된 아이디를 저장
			if($('#rememberId').is(':checked')){
				$.cookie('rememberId', $('#id').val());
			} else {
				$.cookie('rememberId', '');
			}
			
		});
		
	}
	
	function fn_displayRememberId(){
		
		// rememberId 쿠키에 저장된 아이디를 가져와서 표시
		
		let rememberId = $.cookie('rememberId');
		if(rememberId == ''){
			$('#id').val('');
			$('#rememberId').prop('checked', false);
		} else {
			$('#id').val(rememberId);
			$('#rememberId').prop('checked', true);
		}
		
	}
	
	</script>
	
		<h1>로그인</h1>
		
		<form id="frm_login" action="${contextPath}/user/login" method="post">
			
			<!-- 컨트롤러에서 넘겨준 값 : 로그인 후 이동할 주소가 있음 -->
			<input type="hidden" name="url" value="${url}">
			
			<div>
				<label for="id">아이디</label>
				<input type="text" name="id" id="id">
			</div>
			
			<div>
				<label for="pw">비밀번호</label>
				<input type="password" name="pw" id="pw">
			</div>
			
			<div>			
				<button>로그인</button>
			</div>
			
			<div>
				<label for="rememberId">
					<input type="checkbox" id="rememberId">
					아이디 기억
				</label>
				<label for="keepLogin">
					<input type="checkbox" name="keepLogin" id="keepLogin">
					로그인 유지
				</label>
			</div>
		
		</form>
			
		<div>
			<a href="${contextPath}/user/findId">아이디 찾기</a>
			<a href="${contextPath}/user/findPw">비밀번호 찾기</a>
		</div>
		
		<hr>
		
		<div>
			<a href="${apiURL}"><img height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>
		</div>
		
		<hr>
		
			<a href="${contextPath}/user/agree">회원가입하러가기</a>
		</c:if>
	

	<!-- 로그인이 된 상태 -->
	<c:if test="${loginUser != null}">
		<div>
			<a href="${contextPath}/user/check/form">${loginUser.name}</a> 님 반갑습니다.
		</div>
		<a href="${contextPath}/user/logout">로그아웃</a>
		<c:if test="${loginUser.id ne 'admin'}">
		<a href="javascript:fn_abc()">회원탈퇴</a>
		</c:if>
		<form id="lnk_retire" action="${contextPath}/user/retire" method="post"></form>
		<script>
			function fn_abc(){
				if(confirm('탈퇴하시겠습니까?')){
					$('#lnk_retire').submit();
				}
			}
		</script>
	</c:if>

	<hr/>
	<c:if test="${loginUser.id ne 'admin'}">
  	<a href="${contextPath}/bbs/list">자유게시판으로 가기</a>
	<a href="${contextPath}/upload/list">업로드게시판으로 가기</a>
   	<a href="${contextPath}/gallery/list">갤러리게시판으로 가기</a>
   	</c:if>
   	<c:if test="${loginUser.id eq 'admin'}">
   		<form action="${contextPath}/admin/main"  method="POST">
   			<button>관리자 메인으로 이동</button>
   		</form>
	</c:if>


</body>
</html>