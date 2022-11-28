<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="../layout/header.jsp">
	<jsp:param value="${user.id}ȸ�� ���� ����" name="title"/>
</jsp:include>
	<div>
		
	</div>
	<div>
	 	<form id="frm_search">
			
			<select id="column" name="column">
				<option value="TITLE">����</option>
				<option value="GENRE">�帣</option>
				<option value="DESCRIPTION">����</option>
			</select>
			<input type="text" id="searchText" name="searchText">
			<input type="button" id="btn_search" value="�˻�">
			<input type="button" id="btn_init" value="�ʱ�ȭ" onclick="fn_loadList()">
			
			
			<br><hr><br>
			
			<table>
				<thead>
					<tr>
						<th>������ȣ</th>
						<th>���̵�</th>
						<th>�̸�</th>
						<th>������</th>
						<th>��й�ȣ������</th>
						<th>ȸ������������</th>
						<th>����Ʈ</th>
						<th>Ż��</th>
						
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
					<td><input type="button" value="Ż��"></td>
				</tr>
			</tfoot>
			</table>
		</form>
	 
	 </div>


</body>
</html>