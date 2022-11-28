<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="../layout/header.jsp">
	<jsp:param value="ȸ������" name="title"/>
</jsp:include>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script>

$(document).ready(function(){
	
	fn_userList();
    
    
 });
 function fn_userList(){
	 
		
		
		 $.ajax({
			    type: 'get',
			    url: '${contextPath}/userList',
			    dataType: 'json',
			    success: function(resData){  
			    	/*  $('#list_head').empty(); */
			    	
			       
			       $('#list_head').empty();
			       $('#list_body').empty();
			       $('<tr>')
			    	  .append( $('<th>').text("������ȣ") )
			    	  .append( $('<th>').text("���̵�") )
			    	  .append( $('<th>').text("�̸�") )
			    	  .append( $('<th>').text("������") )
			    	  .append( $('<th>').text("��й�ȣ������") )
			    	  .append( $('<th>').text("ȸ������������") )
			    	  .append( $('<th>').text("����Ʈ") )
			    	  .append( $('<th>').text("Ż��") )
			    	  .appendTo('#list_head');
			       $.each(resData, function( index, user ) {
			    	   
			          $('<tr>')
			          .append( $('<td>').text(user.userNo) )
			          .append( $('<td>').append('<a href="${contextPath}/admin/userDetail=' + user.userNo + '">'+ user.id +'</a>') )
			          .append( $('<td>').text(user.name) )
			          .append( $('<td>').text(user.joinDate) )
			          .append( $('<td>').text(user.pwModifyDate) )
			          .append( $('<td>').text(user.infoModifyDate) )
			          .append( $('<td>').text(user.point) )
			          .append($('<td>').append($('<input type="checkbox" name="userCheck" value="'+ user.userNo +'">')))
			          ///admin/userRemove?userNo='+ user.userNo 
			          .appendTo('#list_body');
			       });
			    }   
			 }); 
 	}
 

</script>
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
				<thead id="list_head">
				</thead>
				<tbody id="list_body">
				</tbody>
			</table>
			<input type="button" id="btn_removeUser" value="Ż��">
		</form>
	 
	 </div>


</body>
</html>