<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />


<%-- # 레이아웃처리 : name으로 title 파라미터를 전송 --%>
<jsp:include page="../layout/header.jsp">
	<jsp:param value="업로드게시판" name="title"/>
</jsp:include>
	

<script>

	$(function() {
		
		block_btn_write();
		block_btn_login();
		block_btn_logout();
		
	});
		// # css : 작성버튼 가리기			전제 : 로그인 안한 상태
		// 기본 : 로그인 안하면 안보여줌
		// 변화 : 로그인 하면 보여짐
		function block_btn_write() {
			if('${loginUser}' != '') {
				$('#btn_writer').attr('class', 'none');
				$('#btn_writer').attr('class', 'btn_add_writer');
			}
		}
		
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
		
		
</script>
	
	
		
		<%-- # page : 웰컴페이지 + 목록 --%>
			<div class="section">
			
				<div class="menu">
					<span class="menu_word">총 <span class="cnt">${totalUploadCnt}</span>&nbsp;개의 글이 작성되었습니다&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> 
					<a id="btn_writer" class="dis_blind" href="${contextPath}/upload/write">게시글작성</a>
				</div>
				<div>
					<form action="${contextPath}/upload/search">
						<select id="uploadSearch" name="column" class="search_area">
							<option value="" selected disabled>선택</option>	
							<option value="TITLE">제목</option>	
							<option value="ID">아이디</option>	
						</select>				
						<input type="text" name="query" placeholder="입력하시오">
						<button class="btn_add_search">검색</button>
					</form>
					
				</div>
			
				
				<hr>
				
				<div class="list"> 
					<table>
						<thead>
							<tr>
								<th>번호</th>
								<th>아이디</th>
								<th>제목</th>
								<th>작성일</th>
								<th>조회수</th>
								<th>IP</th>
							</tr>
						</thead>
						<tbody>
							<%-- # page : 게시글 --%>
							<%-- * 반환 : beginNo, uploadList --%>
							<c:forEach items="${uploadList}" var="upload" varStatus="vs">
								<tr>
									<td>${beginNo - vs.index}</td>	<%-- * 인덱스를 이용해 --되는 게시판번호 생성가능--%>
									<td>${upload.id}</td>
									<td><a href="${contextPath}/upload/detail?uploadNo=${upload.uploadNo}">${upload.uploadTitle}</a></td>
									<td>${upload.uploadCreateDate}</td>
									<td>${upload.uploadHit}</td>
									<td>${upload.ip}</td>
									
									<%-- * ip가 안나오는 이유 : ip --%>
								</tr>
							</c:forEach>
						</tbody>
						<tfoot>
							<tr>
								<td class="paging" colspan="6">
									<%-- # page : 블록 --%>
									<%-- * 반환 : paging --%>
									${paging}
								</td>
							</tr>
						</tfoot>
						
					</table>
				</div>
			</div>
		
</div>
</body>
</html>