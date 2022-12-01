<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"> -->
<script type="text/javascript">
	$(function(){
		
		if('${recordPerPage}' != ''){
			$('#recordPerPage').val(${recordPerPage});			
		} else {
			$('#recordPerPage').val(10);
		}
		
		$('#recordPerPage').change(function(){
			location.href = '${contextPath}/bbs/list?recordPerPage=' + $(this).val();
		});
		
	});
</script>
<style type="text/css">
.row {
   margin: 0px auto;
   width:900px;
}

h1 {
    text-align: center;
}
</style>
</head>
<body>
       		<h1>자유 게시판</h1>
       			<table class="table">
         		  <tr>
           		   <td>
				<a href="${contextPath}/bbs/write" class="btn btn-sm btn-primary">새글 작성</a>
           		  </td>
         		 </tr>
      			</table> 

	<div>
		 <table class="table table-striped">
       		<thead>
		        <tr class="danger">
					<td>번호</td>
					<td>아이디</td>
					<td>제목</td>
					<td>작성일</td>
					<td>삭제</td>
					
					<!--  -->
				</tr>
		     </thead>
			<tbody>
				<c:forEach var="bbs" items="${bbsList}" varStatus="vs">	
					<c:if test="${bbs.state == 1}">
						<tr>	
							<td>${beginNo - vs.index}</td>
							<td>${bbs.id}</td>
							
							<td>
								<!-- DEPTH에 따른 들여쓰기 -->
								<c:forEach begin="1" end="${bbs.depth}" step="1">
									&nbsp;&nbsp;
								</c:forEach>
								<!-- 답글은 [RE] 표시 -->
								<c:if test="${bbs.depth > 0}">
									[RE]
								</c:if>
								<!-- 제목 -->
								${bbs.bbsTitle}
								
								<!-- 답글달기 버튼 -->
								<%--
									1단 답글로 운용하는 경우 아래와 같이 처리한다.
									<c:if test="${bbs.depth == 0}">
										<input type="button" value="답글" class="btn_reply_write">
									</c:if>
								--%>
								<input type="button" value="답글" class="btn_reply_id">
								<script>
									$('.btn_reply_id').click(function(){
										$('.reply_id_tr').addClass('blind');
										$(this).parent().parent().next().removeClass('blind');
									});
								</script>
							</td>
							
							<td><fmt:formatDate value="${bbs.createDate}" pattern="yy/MM/dd HH:mm:ss" /></td>
							<td>
								<form method="post" action="${contextPath}/bbs/remove">
									<input type="hidden" name="bbsNo" value="${bbs.bbsNo}">
									<a class="lnk_remove" id="lnk_remove${bbs.bbsNo}">게시글 삭제</a>
								</form>
								<script>
									$('#lnk_remove${bbs.bbsNo}').click(function(){
										if(confirm('삭제할까요?')){
											$(this).parent().submit();
										}
									});
								</script>
							</td>
						</tr>
						<tr class="reply_id_tr blind">
							<td colspan="6">
								<form method="post" action="${contextPath}/bbs/reply/add">
									<div><input type="text" name="id" placeholder="작성자" required></div>
									<div><input type="text" name="content" placeholder="내용" required></div>
									<div><button>답글달기</button></div>
									<input type="hidden" name="depth" value="${bbs.depth}">
									<input type="hidden" name="groupNo" value="${bbs.groupNo}">
									<input type="hidden" name="groupOrder" value="${bbs.groupOrder}">
								</form>
							</td>
						<tr>
					</c:if>
					<c:if test="${bbs.state == 0}">
						<tr>
							<td>${beginNo - vs.index}</td>
							<td colspan="5">삭제된 게시글입니다</td>
						</tr>
					</c:if>
				</c:forEach>
			</tbody>
			<tfoot>
			
				<tr>
					<td colspan="10">${paging}</td>
				</tr>
			</tfoot>
		</table>
	</div>

</body>
</html>