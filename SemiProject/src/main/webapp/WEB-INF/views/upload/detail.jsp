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
		
		// # move : 편집창 이동
		$('#btn_upload_edit').click(function(event){
			$('#frm_upload').attr('action', '${contextPath}/upload/edit');
			$('#frm_upload').submit();		
			
		});
		
		// # service : 게시글 삭제
		$('#btn_upload_remove').click(function(event){
			if(confirm('첨부된 모든 파일이 함께 삭제됩니다. 삭제할까요?')){			// & 여기서 첨부파일도 삭제하는 쿼리문
				$('#frm_upload').attr('action', '${contextPath}/upload/remove');
				$('#frm_upload').submit();
			}
		});
		
		// # move : 목록이동
		$('#btn_upload_list').click(function(event){
			location.href = '${contextPath}/upload/list';
		});
		
	});


</script>


	
	<%-- # page : 상세화면 --%>
	<%-- * 반환값 : upload, attach, attachCnt --%>
	
	<div>
		<h1>상세보기</h1>
		<div>
			<span>제목 : ${upload.uploadTitle}</span>
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
				<input type="button" value="게시글편집" id="btn_upload_edit"> 			
				<input type="button" value="게시글삭제" id="btn_upload_remove"> 			
				<input type="button" value="게시글목록" id="btn_upload_list"> 			
			</form>
		</div>
	
	<hr>
	
	<%-- # page : 첨부파일 목록 --%>
	<h1>첨부목록</h1>  						
	<%-- * 반환 : ${attachList} 속성에 저장 --%>
	<c:forEach items="${attachList}" var="attach">
			<div>
				<%-- # service : 개별 다운로드--%>
				<a href="${contextPath}/upload/download?attachNo=${attach.attachNo}">${attach.origin}</a>		
				<span>다운로드수 : ${attach.downloadCnt}</span>							
			</div>
		</c:forEach>
		<br>
		
		<%-- # service : 전체 다운로드 --%>
		<div>
			<a href="${contextPath}/upload/downloadAll?uploadNo=${upload.uploadNo}">모두 다운로드</a>
		</div>
	
	
	
	
</div>
</body>
</html>