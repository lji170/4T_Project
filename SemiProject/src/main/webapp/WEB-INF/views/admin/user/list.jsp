<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="../layout/header.jsp">
	<jsp:param value="회원관리" name="title"/>
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
			    	  .append( $('<th>').text("유저번호") )
			    	  .append( $('<th>').text("아이디") )
			    	  .append( $('<th>').text("이름") )
			    	  .append( $('<th>').text("가입일") )
			    	  .append( $('<th>').text("비밀번호수정일") )
			    	  .append( $('<th>').text("회원정보수정일") )
			    	  .append( $('<th>').text("포인트") )
			    	  .append( $('<th>').text("탈퇴") )
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
				<option value="TITLE">제목</option>
				<option value="GENRE">장르</option>
				<option value="DESCRIPTION">내용</option>
			</select>
			<input type="text" id="searchText" name="searchText">
			<input type="button" id="btn_search" value="검색">
			<input type="button" id="btn_init" value="초기화" onclick="fn_loadList()">
			
			
			<br><hr><br>
			
			<table>
				<thead id="list_head">
				</thead>
				<tbody id="list_body">
				</tbody>
			</table>
			<input type="button" id="btn_removeUser" value="탈퇴">
		</form>
	 
	 </div>


</body>
</html>