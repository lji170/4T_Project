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
		$('#galContent').summernote({
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
				onImageUpload: function(files){
					for(let i = 0; i < files.length; i++) {
						var formData = new FormData();
						formData.append('file', files[i]);  // 파라미터 file, summernote 편집기에 추가된 이미지가 files[i]임						
						// 이미지를 HDD에 저장하고 경로를 받아오는 ajax
						$.ajax({
							type: 'post',
							url: getContextPath() + '/gallery/uploadImage',
							data: formData,
							contentType: false,  // ajax 이미지 첨부용
							processData: false,  // ajax 이미지 첨부용
							dataType: 'json',    // HDD에 저장된 이미지의 경로를 json으로 받아옴
							success: function(resData){
								$('#galContent').summernote('insertImage', resData.src);
								$('#summernote_image_list').append($('<input type="hidden" name="summernoteImageNames" value="' + resData.filesystem + '">'))
								
							}
						});  // ajax
					}  // for
				}  // onImageUpload
			}  // callbacks
		});
		
		// 목록
		$('#btn_list').click(function(){
			location.href = getContextPath() + '/gallery/list';
		});
		
		// 서브밋
		$('#frm_write').submit(function(event){
			if($('#galTitle').val() == ''){
				alert('제목은 필수입니다.');
				event.preventDefault();  // 서브밋 취소
				return;  // 더 이상 코드 실행할 필요 없음
			}
		});
		
	});
	
</script>


<div>

	<h1>작성 화면</h1>
	<c:if test="${loginUser != null}">
		<div>
			<a href="${contextPath}/user/check/form">${loginUser.name}</a> 님
		</div>
		<a href="${contextPath}/user/logout">로그아웃</a>
		<form id="lnk_retire" action="${contextPath}/user/retire" method="post"></form>
	</c:if>
	<form id="frm_write" action="${contextPath}/gallery/add" method="post">
		<input type="hidden" name="id" value="${loginUser.id}">
		<div>
			<label for="galTitle">제목</label>
			<input type="text" name="galTitle" id="galTitle">
		</div>
		
		<div>
			<label for="galContent">내용</label>
			<textarea name="galContent" id="galContent"></textarea>				
		</div>
		<!-- 써머노트에서 사용한 이미지 목록(등록 후 삭제한 이미지도 우선은 모두 올라감: 서비스단에서 지움) -->
		<div id="summernote_image_list"></div>
		<div>
			<button>작성완료</button>
			<input type="reset" value="입력초기화">
			<input type="button" value="목록" id="btn_list">
		</div>
		
	</form>
	
</div>

</body>
</html>