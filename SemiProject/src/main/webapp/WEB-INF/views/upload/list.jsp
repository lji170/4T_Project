<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />


<%-- # 레이아웃처리 : name으로 title 파라미터를 전송 --%>
<jsp:include page="../layout/header.jsp">
	<jsp:param value="업로드게시판" name="title"/>
</jsp:include>
	
		
		<%-- # page : 웰컴페이지 + 목록 --%>
			
			<div class="menu">
				<span>총 ${totalUploadCnt} 개의 글이 작성되었습니다</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="${contextPath}/upload/write">게시글작성</a>
			</div>
		
			
			<hr>
			
			<div class="list"> 
			<table border="1">
				<thead>
					<tr>
						<td>번호</td>
						<td>아이디</td>
						<td>제목</td>
						<td>작성일</td>
						<td>조회수</td>
						<td>IP</td>
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
						<td>
							<%-- # page : 블록 --%>
							<%-- * 반환 : paging --%>
							${paging}
						</td>
					</tr>
				</tfoot>
				
			</table>
			</div>
		
</div>
</body>
</html>