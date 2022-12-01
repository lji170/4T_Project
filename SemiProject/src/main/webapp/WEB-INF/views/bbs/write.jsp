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
<link rel="stylesheet" href="${contextPath}/resources/summernote-0.8.18-dist/summernote-lite.min.css">
<script src="${contextPath}/resources/summernote-0.8.18-dist/summernote-lite.min.js"></script>
<script src="${contextPath}/resources/summernote-0.8.18-dist/lang/summernote-ko-KR.min.js"></script>
<script>
	
	$(document).ready(function(){
		
		// summernote
		$('#content').summernote({
			width: 800,
			height: 400,
			lang: 'ko-KR',
			toolbar: [
			    // [groupName, [list of button]]
			    ['style', ['bold', 'italic', 'underline', 'clear']],
			    ['font', ['strikethrough', 'superscript', 'subscript']],
			    ['fontsize', ['fontsize']],
			    ['color', ['color']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['height', ['height']]
			]
		});
		
		// 목록
		$('#btn_list').click(function(){
			location.href = '${contextPath}/bbs/list';
		});
		
		// 서브밋
		$('#frm_bbs').submit(function(event){
			if($('#title').val() == '' || $('#id').val() == ''){
				alert('제목과 아이디는 필수입니다.');
				event.preventDefault();  // 서브밋 취소
				return;  // 더 이상 코드 실행할 필요 없음
			}
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
				<label for="id">아이디</label>
				<input type="text" name="id" id="id">
			</div>
			<div>
				<label for="content">내용</label>
				<textarea name="content" id="content"></textarea>				
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