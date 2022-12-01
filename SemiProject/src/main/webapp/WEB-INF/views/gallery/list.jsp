<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="${contextPath}/resources/css/gallery.css">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script>
	$(function(){
	
		// 세션에 recordPerPage가 없는 경우 recordPerPage 10으로 초기화
		var recordPerPage = ('${recordPerPage}'=='') ? '10' : '${recordPerPage}';
		$('#recordPerPage').val(recordPerPage);
		
		// recordPerPage 변경
		$('#recordPerPage').change(function(){
			location.href = '${contextPath}/gallery/change/list?recordPerPage=' + $(this).val();
		});
		
	});
</script>
</head>
<body>
	<div id="top_fixer">
		<h1 id="top_title">갤러리 게시판</h1>
		<div id="login_area">
			<c:if test="${loginUser eq null}">
				<a href="${contextPath}/"> 로그인</a>
			</c:if>
			<c:if test="${loginUser != null}">
				<a href="${contextPath}/user/check/form">${loginUser.name}</a> 님
				<a href="${contextPath}/user/logout">로그아웃</a>
			</c:if>
		</div>
		<div>
			<form method="post" action="${contextPath}/gallery/write">
				<input type="hidden" id="userId" value="${loginUser.id}">
			</form>
		</div>
	</div>
	<div id="article">
			<div>
			<form method="post" action="${contextPath}/gallery/write">
				<input type="hidden" id="userId" value="${loginUser.id}">
				<input type="submit" id="btn_write" value="갤러리 작성하기">
				<script>
					$('#btn_write').click(function(event){
						if (${loginUser.id eq null}) {
							alert('로그인해야 게시글을 작성할 수 있습니다.');
							event.preventDefault();
							return;
						}
					});
				</script>
			</form>
		</div>
		<div>
			<select name="recordPerPage" id="recordPerPage">
				<option value="10">10</option>
				<option value="15">15</option>
				<option value="20">20</option>
			</select>
		</div>
		<div>
			<table border="1">
				<thead>
					<tr>
						<td>순번</td>
						<td>제목</td>
						<td>조회수</td>
						<td>작성자</td>
						<td>작성일</td>
					</tr>
				</thead>
				<tbody id="galleryList">
					<c:forEach items="${galleryList}" var="gallery" varStatus="vs">
						<tr>
							<td>${beginNo - vs.index}</td>
							<td><a href="${contextPath}/gallery/increse/hit?galNo=${gallery.galNo}&id=${loginUser.id}">${gallery.galTitle}</a></td>
							<td>${gallery.galHit}</td>
							<td>${gallery.id}</td>
							<td>${gallery.galCreateDate}</td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="5">
							${paging}
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
</body>
</html>