<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="../layout/header.jsp">
	<jsp:param value="${user.id}회원 정보 수정" name="title"/>
</jsp:include>
	<div>
		
	</div>
	<div>
	 	<form id="frm_search">
			
			<select id="column" name="column">
				<option value="TITLE">제목</option>
				<option value="GENRE">장르</option>
				<option value="DESCRIPTION">내용</option>
			</select>
			<input type="text" id="searchText" name="searchText">
			<input type="button" id="btn_search" value="검색">
			<input type="button" id="btn_init" value="초기화" onclick="fn_loadList()">
			
			
			<br><hr><br>
			
			<table>
				<thead>
					<tr>
						<th>유저번호</th>
						<th>아이디</th>
						<th>이름</th>
						<th>가입일</th>
						<th>비밀번호수정일</th>
						<th>회원정보수정일</th>
						<th>포인트</th>
						<th>탈퇴</th>
						
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${userList}" var="user" varStatus="vs">
						<tr>
							<td onclick="location.href='${contextPath}/admin/userDetail?userNo=${user.userNo}'" style="cursor:pointer">${user.userNo}</td>
							<td onclick="location.href='${contextPath}/admin/userDetail?userNo=${user.userNo}'" style="cursor:pointer">${user.id}</td>
							<td onclick="location.href='${contextPath}/admin/userDetail?userNo=${user.userNo}'" style="cursor:pointer">${user.name}</td>
							<td onclick="location.href='${contextPath}/admin/userDetail?userNo=${user.userNo}'" style="cursor:pointer">${user.joinDate}</td>
							<td onclick="location.href='${contextPath}/admin/userDetail?userNo=${user.userNo}'" style="cursor:pointer">${user.pwModifyDate}</td>
							<td onclick="location.href='${contextPath}/admin/userDetail?userNo=${user.userNo}'" style="cursor:pointer">${user.infoModifyDate}</td>
							<td onclick="location.href='${contextPath}/admin/userDetail?userNo=${user.userNo}'" style="cursor:pointer">${user.point}</td>
							<td><input type="checkbox" name="checkUser" value="${user.userNo}"></td>
							
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
				<tr>
					<td colspan="8" style="text-align:center">
						${paging}
					</td>
					<td><input type="button" value="탈퇴"></td>
				</tr>
			</tfoot>
			</table>
		</form>
	 
	 </div>


</body>
</html>