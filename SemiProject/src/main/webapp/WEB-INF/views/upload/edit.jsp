<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />


<%-- # 레이아웃처리 : name으로 title 파라미터를 전송 --%>
<jsp:include page="../layout/header.jsp">
	<jsp:param value="게시글편집" name="title"/>
</jsp:include>



<script>

	$(function(){
		
		block_btn_login();
		block_btn_logout();
		fn_fileCheck();
		//fn_removeAttach();
		fn_removeAttach();
		fn_editRequest();
		
	});
	
	
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

	
	
	// # js : 첨부파일에 제한 걸기
	function fn_fileCheck(){
		
	
	$('#files').change(function() {
		
		// 1) 첨부파일 한계
		let maxSize = 1024 * 1024 * 10;  // 10MB
		
		// 2) 첨부된 파일 목록
		let files = this.files;		
		
		// 3) 순회
		for(let i = 0; i < files.length; i++){
			
			// 크기 체크 : 10mb보다 크면 첨부 최신화
			if(files[i].size > maxSize){
				alert('10MB 이하의 파일만 첨부할 수 있습니다.');
				$(this).val('');  // 첨부된 파일을 모두 없애줌
				return;
			}
			
		}
		
	});
	
	}
	
	// # ajax service : 첨부파일 삭제
	function fn_editRequest() {
		
		/* $.ajax({
			type : 'post',
			url : '${contextPath}/upload/edit',
			data : 'uploadNo=' + $('#uploadNo'),
			dataType : 'json',
			success : function(resData) {				// resData = upload 한개 데이터, attachList
				$('#title').val(resData.upload.uploadTitle)
				$('#content').val(resData.upload.uploadContent)
				$('#title').val(resData.upload.uploadTitle)
				$('#uploadNo').val(resData.uploadTitle)
				$('#title').val(resData.uploadTitle)
				
			}
		}); */
		
	}
	
	

</script>



	<%-- # page : 게시글 편집화면 --%>

	
	<h1>게시글 작성</h1>
		
		<form action="${contextPath}/upload/modify" method="post" enctype="multipart/form-data">
		
			<%-- * 수정을 위해 uploadNo를 파라미터 전달 --%>
			<input type="hidden" name="uploadNo" value="${upload.uploadNo}">
		
			<div>
				<label for="title">제목</label>
				<input type="text" id="title" name="title" required="required" value="${upload.uploadTitle}">
			</div>
			<br>
			<div>
				<label for="content">내용</label>
				<textarea id="content" name="content" placeholder="내용을 입력하세요" cols="40" rows="3">${upload.uploadContent}</textarea>
																							<%-- * textarea는 값을 value가 아닌 괄호 밖에 값을 넣어준다 --%>
			</div>
			<br>
			<div>
				<label for="files">첨부</label>
				<input type="file" id="files" name="files" multiple="multiple">
			</div>
			<hr>
			<div>
				<button>수정완료</button>
				<input type="button" value="목록" onclick="location.href='${contextPath}/upload/list'">
			</div>
			
		</form>
			<%-- # service : 첨부파일 삭제 --%>
			<div>
				<h1>첨부삭제</h1>	
					<form id="frm_attachRemove" method="post">
					<input type="button" id="btn_attachDeleteAll" value="전부삭제">
					<c:forEach items="${attachList}" var="attach">
						<input type="hidden" name="uploadNo" value="${upload.uploadNo}">
						<div>
							${attach.origin}&nbsp;
							<input type="button" value="삭제" id="btn_attachRemove${attach.attachNo}">
							<input type="hidden" name="attachNo" value="${attach.attachNo}">
							<script>
									// service : 첨부파일삭제
									// 1) 개별파일 삭제
									// service : 첨부파일 삭제
									// & 문제발생 : 버튼클릭이벤트 실행이 안됨
									// - 해결 : 스크립트에서 attach.attachNo 데이터를 못받아서 생긴문제
									// 			스크립트도 반복문안에 넣어줘야한다
									
	
									$('#btn_attachRemove${attach.attachNo}').click(function () {
										if(confirm('해당 스크립트를 삭제할까요?')) {
											$('#frm_attachRemove').attr('action', '${contextPath}/attach/remove');
											$(this).parent().parent().submit();		
											/* $.ajax({
												type : 'get',
												url : '${contextPath}/attach/removeAttach',
												data : 'attachNo=' + $('#attachNo'),
												dataType : 'json',
												success : function(resData) {
													
													
												}
											}); */
										}
									});
									
									
									
									
							</script>
						</div>
					</c:forEach>
					<script>
					// service : 첨부파일 전부삭제
					$('#btn_attachDeleteAll').click(function() {
						if(confirm('첨부파일을 전부 삭제할까요?')) {
							
							$('#frm_attachRemove').attr('action', '${contextPath}/attach/removeAll');
							$(this).parent().submit();	
						} 
					});
					
					</script>
					</form>
			
			
					<%-- * data-파라미터명 : 해당 속성값에 저장된 값을 스크립트에서 꺼내서 쓸 수 있음 --%>
					<%-- * 반복문에서 id는 class로 바꿔야한다 : 복수 존재하기 떄문 --%>
			</div>
	
		
</div>
</body>
</html>