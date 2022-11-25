<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="layout/header.jsp">
	<jsp:param value="블로그작성" name="title"/>
</jsp:include>

<script>
	
	// contextPath를 반환하는 자바스크립트 함수
	function getContextPath() {
		var begin = location.href.indexOf(location.origin) + location.origin.length;
		var end = location.href.indexOf("/", begin + 1);
		return location.href.substring(begin, end);
	}
	
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
			    ['height', ['height']],
			    ['insert', ['link', 'picture', 'video']]
			],
			callbacks: {
				// summernote 편집기에 이미지를 로드할 때 이미지는 function의 매개변수 files로 전달됨 
				onImageUpload: function(files){
					// 이미지를 ajax를 이용해서 서버로 보낼 때 가상 form 데이터 사용 
					var formData = new FormData();
					formData.append('file', files[0]);  // 파라미터 file, summernote 편집기에 추가된 이미지가 files[0]임
					// 이미지를 HDD에 저장하고 경로를 받아오는 ajax
					$.ajax({
						type: 'post',
						url: getContextPath() + '/gallery/uploadImage',
						data: formData,
						contentType: false,  // ajax 이미지 첨부용
						processData: false,  // ajax 이미지 첨부용
						dataType: 'json',    // HDD에 저장된 이미지의 경로를 json으로 받아옴
						success: function(resData){
							
							$('#content').summernote('insertImage', resData.src);
							
							/*
								src=${contextPath}/load/image/aaa.jpg 값이 넘어온 경우
								summernote는
								<img src="${contextPath}/load/image/aaa.jpg"> 태그를 만든다.
								
								mapping=${contextPath}/load/image/aaa.jpg인 파일의 실제 위치는
								location=C:\\upload\\aaa.jpg이다.
								
								스프링에서 정적 자원 표시하는 방법은 servlet-context.xml에 있다.
								이미지(정적 자원)의 mapping과 location을 servlet-context.xml에 작성해야 한다.
							*/
						}
					});  // ajax
				}  // onImageUpload
			}  // callbacks
		});
		
		// 목록
		$('#btn_list').click(function(){
			location.href = getContextPath() + '/gallery/list';
		});
		
		// 서브밋
		$('#frm_write').submit(function(event){
			if($('#title').val() == ''){
				alert('제목은 필수입니다.');
				event.preventDefault();  // 서브밋 취소
				return;  // 더 이상 코드 실행할 필요 없음
			}
		});
		
	});
	
</script>


<div>

	<h1>작성 화면</h1>
	
	<form id="frm_write" action="${contextPath}/gallery/add" method="post">
	
		<div>
			<label for="galTitle">제목</label>
			<input type="text" name="galTitle" id="galTitle">
		</div>
		
		<div>
			<label for="galContent">내용</label>
			<textarea name="galContent" id="galContent"></textarea>				
		</div>
		
		<div>
			<button>작성완료</button>
			<input type="reset" value="입력초기화">
			<input type="button" value="목록" id="btn_list">
		</div>
		
	</form>
	
</div>

</body>
</html>