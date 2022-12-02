<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새글작성</title>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script>
	
	$(document).ready(function(){
		
		// 목록
		$('#btn_list').click(function(){
			location.href = '${contextPath}/bbs/list';
		});
	
		$('#btn_d').on('click', function(){
			alert($('#id').val());
		});
		
	});
	
</script>
</head>
<body>

	<div>
		<h1>작성 화면</h1>
		<form id="frm_bbs" action="${contextPath}/bbs/add" method="post">
			<div>
				<label for="bbsTitle">제목</label>
				<input type="text" name="bbsTitle" id="bbsTitle">
			</div>
			<div>
				<label for="id">작성자</label>
				<input type="text" name="id" id="id" value="${loginUser.id}" readonly>
			</div>
		
			<div>
				<button>작성완료</button>
				<input type="reset" value="입력초기화">
				<input type="button" value="목록"  onclick="location.href='${contextPath}/bbs/list'">
			</div>
		</form>
	</div>

</body>
</html>