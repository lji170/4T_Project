<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 		<%-- # 코어라이브러리 : 날짜 --%>

<%-- # 레이아웃처리 : name으로 title 파라미터를 전송 --%>
<jsp:include page="../layout/header.jsp">
	<jsp:param value="상세페이지" name="title"/>
</jsp:include>

<script>
	
	$(function() {
		
		
		block_btn_login();
		block_btn_logout();
		fn_remove();
		fn_edit();
		fn_list();
		fn_behindButton();
		fn_downloadHidden();
	
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
	
	
	
	
		// # move : 편집창 이동
		function fn_edit() {
			$('#btn_upload_edit').click(function(event){
				$('#frm_upload').attr('action', '${contextPath}/upload/edit');
				$('#frm_upload').submit();		
				
			});
		}
		
		// # service : 게시글 삭제
		function fn_remove() {
			$('#btn_upload_remove').click(function(event){
				if(confirm('첨부된 모든 파일이 함께 삭제됩니다. 삭제할까요?')){			// & 여기서 첨부파일도 삭제하는 쿼리문
					$('#frm_upload').attr('action', '${contextPath}/upload/remove');
					$('#frm_upload').submit();
				}
			});
		}
		
		// # move : 목록이동
		function fn_list() {
			$('#btn_upload_list').click(function(event){
				location.href = '${contextPath}/upload/list';
			});
		}
		
		// # css : 작성자만 편집, 삭제버튼 볼수 있음
		// 기본 : 로그인 안한경우, 삭제, 수정버튼을 볼 수 없음
		// 변화 : 로그인한 유저 = 작성자의 id이면 볼 수 있음
		
		// - 조건 작성법
		// (1) session에 저장된 id 가져오기 : session에 저장되있으니 그냥 el변수로 불러오면된다
		// (2) session의 id와 작성자의 id를 문자열비교 : ''감싸기
			
			// 평소에는 닫아주기
		function fn_behindButton() {			// * js의 문자열비교 : ''로 감싸기
		
			if('${loginUser.id}' == '${upload.id}') {
				$('#writer_area').attr('class', 'none');	
			}
			
			
			
		}
			
			function fn_downloadHidden() {
				if('${loginUser}' == '') {
					$('download_div').attr('class', 'none');
				}
			}

	


</script>




	<%-- # page : 상세화면 --%>
	<%-- * 반환값 : upload, attach, attachCnt --%>
	
	<div>
		<h1>상세보기</h1>
		<div>
			<span>제목 : ${upload.uploadTitle}</span>
		</div>
		<div>
			<span>작성자 : ${upload.id}</span>
			<span>글번호 : ${upload.uploadNo}</span>
		</div>
		<div>
		
			<span>조회수 :&nbsp;<fmt:formatNumber value="${upload.uploadHit}" pattern="#,##0" /></span>
			&nbsp;&nbsp;
			<span>작성일 :&nbsp;<fmt:formatDate value="${upload.uploadCreateDate}" pattern="yyyy.M.d.HH:mm"/></span>
			&nbsp;
			<span>수정일 :&nbsp;<fmt:formatDate value="${upload.uploadLastModifyDate}" pattern="yyyy.M.d.HH:mm"/></span>
			&nbsp;
		</div>
		
		<hr>
		
		
		<div>
			<span>내용 : ${upload.uploadContent}</span>
		</div>
		
		<br>
	
	</div>
	
	<%-- # service : 수정/삭제 --%>
	<div>
	
			<form id="frm_upload" method="post">
				<input type="hidden" name="uploadNo" value="${upload.uploadNo}">	<%-- * input hidden : 수정 또는 삭제에 필요한 uploadNo --%>
					<div id="writer_area" class="dis_blind">
						<input type="button" value="게시글편집" id="btn_upload_edit" > 			
						<input type="button" value="게시글삭제" id="btn_upload_remove">
					</div>
					<input type="button" value="게시글목록" id="btn_upload_list"> 			
			</form>
			<input type="hidden" name="id" value="${upload.id}">
		</div>
	
	<hr>
	
	<%-- # page : 첨부파일 목록 --%>
	<h1>첨부목록</h1>  						
	<%-- * 반환 : ${attachList} 속성에 저장 --%>
	<div class="download_area" id="download_div">
		<c:forEach items="${attachList}" var="attach">
				<div>
					<%-- # service : 개별 다운로드--%>
					<a id="download" href="${contextPath}/upload/download?attachNo=${attach.attachNo}">${attach.origin}</a>		
					<span>다운로드수 : ${attach.downloadCnt}</span>							
				</div>
		</c:forEach>
			<br>
			
			<%-- # service : 전체 다운로드 --%>
		<div>
			<a id="downloadAll" href="${contextPath}/upload/downloadAll?uploadNo=${upload.uploadNo}">모두 다운로드</a>
		</div>
	</div>
	
	
	
	
	
</div>
</body>
</html>