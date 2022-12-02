<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />


<%-- # 레이아웃처리 : name으로 title 파라미터를 전송 --%>
<jsp:include page="../layout/header.jsp">
	<jsp:param value="게시글추가" name="title"/>
</jsp:include>

	<%-- # page : 게시글 추가화면 --%>


<script>


	$(function(){
		
		block_btn_login();
		block_btn_logout();
		
		// # css : 로그인버튼			전제 : 로그인 안한 상태
		// 기본 : 로그인 안하면 보여줌
		// 변화 : 로그인 하면 안보여줌
		
		function block_btn_login() {
			if('${loginUser}' != '') {
				//${'#header_login'}.attr('class', 'none');
				$('#header_login').attr('class', 'dis_blind');
				
			}
		}		
		
		// # css : 로그아웃 버튼
		// 기본 로그인 안하면 안보여줌
		// 변화 : 로그인 하면 보여줌
		function block_btn_logout() {
			if('${loginUser}' != '') {
				$('#header_logout').attr('class', 'none');
				$('#header_logout').attr('class', 'btn_add_logout');
			}
		}
	
	
		
	});


</script>
	<%-- # page : 게시글 추가화면 --%>
	
	<h1>게시글 작성</h1>
		
		<form action="${contextPath}/upload/add" method="post" enctype="multipart/form-data">
		
			<div>
				<label for="title">제목</label>
				<input type="text" id="title" name="title" required="required" placeholder="제목을 입력하세요" >
			</div>
			<br>
			<div>
				<label for="content">내용</label>
				<textarea id="content" name="content" placeholder="내용을 입력하세요" cols="40" rows="3"></textarea>
			</div>
			<br>
			<div>
				<label for="files">첨부</label>
				<input type="file" id="files" name="files" multiple="multiple">
			</div>
			<hr>
			<div>
				<button>작성완료</button>
				<input type="button" value="목록" onclick="location.href='${contextPath}/upload/list'">
			</div>
		
		</form>
	
		
</div>
</body>
</html>