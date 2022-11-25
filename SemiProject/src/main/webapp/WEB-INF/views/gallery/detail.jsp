<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="layout/header.jsp">
	<jsp:param value="${gallery.galNo}번 블로그" name="title"/>
</jsp:include>

<div>

	<h1>${gallery.galTitle}</h1>
	
	<div>
		<span>▷ 작성일 <fmt:formatDate value="${gallery.galCreateDate}" pattern="yyyy. M. d HH:mm" /></span>
		&nbsp;&nbsp;&nbsp;
		<span>▷ 수정일 <fmt:formatDate value="${gallery.galLastModifyDate}" pattern="yyyy. M. d HH:mm" /></span>
	</div>
	
	<div>
		<span>조회수 <fmt:formatNumber value="${gallery.galHit}" pattern="#,##0" /></span>
	</div>
	
	<hr>
	
	<div>
		${gallery.galContent}
	</div>
	
	<div>
		<form id="frm_btn" method="post">
			<input type="hidden" name="galleryNo" value="${gallery.galNo}">
			<input type="button" value="수정" id="btn_edit_gallery">
			<input type="button" value="삭제" id="btn_remove_gallery">
			<input type="button" value="목록" onclick="location.href='${contextPath}/gallery/list'">
		</form>
		<script>
			$('#btn_edit_gallery').click(function(){
				$('#frm_btn').attr('action', '${contextPath}/gallery/edit');
				$('#frm_btn').submit();
			});
			$('#btn_remove_gallery').click(function(){
				if(confirm('블로그를 삭제하면 블로그에 달린 댓글을 더 이상 확인할 수 없습니다. 삭제하시겠습니까?')){
					$('#frm_btn').attr('action', '${contextPath}/gallery/remove');
					$('#frm_btn').submit();
				}
			});
		</script> 
	</div>

</div>

</body>
</html>