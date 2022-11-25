<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
	*{padding:0;margin:0}
	ul,ol{list-style:none}
	a{text-decoration:none;color:#fff;font-size:15px}
	nav{width:80%;overflow:hidden;height:80px;background-color:#1b2035;margin:50px auto}
	#nav3 {
	  width: 100%;
	  position: relative;
	  text-align: center;
	}
	#nav3>a {
	  line-height: 80px;
	  display: block;
	  font-size: 30px;
	  font-weight: 900;
	  position: absolute;
	  left: 30px;
	}
	#nav3>select {
	  padding: 0 20px;
	  height: 30px;
	  background-color: #1b2035;
	  color: #fff;
	  position: absolute;
	  right: 30px;
	  top: 50%;
	  transform: translateY(-15px);
	  border: 2px solid #fff;
	  border-radius: 30px;
	}
	#nav3>ul {
	  display: inline-block;
	}
	#nav3>ul li {
	  float: left;
	  line-height: 80px;
	  padding: 0 30px;
	}
	
	
	
	
	
	
	@import url(https://fonts.googleapis.com/css?family=Roboto:400,500,700,300,100);

	body {
	  background-color: rgb(217, 218, 223);
	  font-family: "Roboto", helvetica, arial, sans-serif;
	  font-size: 16px;
	  font-weight: 400;
	  text-rendering: optimizeLegibility;
	}
	
	div.table-title {
	   display: block;
	  margin: auto;
	  max-width: 600px;
	  padding:5px;
	  width: 100%;
	}
	
	.table-title h3 {
	   color: #fafafa;
	   font-size: 30px;
	   font-weight: 400;
	   font-style:normal;
	   font-family: "Roboto", helvetica, arial, sans-serif;
	   text-shadow: -1px -1px 1px rgba(0, 0, 0, 0.1);
	   text-transform:uppercase;
	}
	
	
	/*** Table Styles **/
	
	.table-fill {
	  background: white;
	  border-radius:3px;
	  border-collapse: collapse;
	  height: 320px;
	  margin: auto;
	  max-width: 600px;
	  padding:5px;
	  width: 100%;
	  box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
	  animation: float 5s infinite;
	}
	 
	th {
	  color:#D5DDE5;;
	  background:#1b1e24;
	  border-bottom:4px solid #9ea7af;
	  border-right: 1px solid #343a45;
	  font-size:12px;
	  font-weight: 100;
	  padding:10px;
	  text-align: center;
	  text-shadow: 0 1px 1px rgba(0, 0, 0, 0.1);
	  vertical-align:middle;
	}
	
	th:first-child {
	  border-top-left-radius:3px;
	}
	 
	th:last-child {
	  border-top-right-radius:3px;
	  border-right:none;
	}
	  
	tr {
	  border-top: 1px solid #C1C3D1;
	  border-bottom-: 1px solid #C1C3D1;
	  color:#666B85;
	  font-size:16px;
	  font-weight:normal;
	  text-shadow: 0 1px 1px rgba(256, 256, 256, 0.1);
	}
	 
	tr:hover td {
	  background:#4E5066;
	  color:#FFFFFF;
	  border-top: 1px solid #22262e;
	}
	 
	tr:first-child {
	  border-top:none;
	}
	
	tr:last-child {
	  border-bottom:none;
	}
	 
	tr:nth-child(odd) td {
	  background:#EBEBEB;
	}
	 
	tr:nth-child(odd):hover td {
	  background:#4E5066;
	}
	
	tr:last-child td:first-child {
	  border-bottom-left-radius:3px;
	}
	 
	tr:last-child td:last-child {
	  border-bottom-right-radius:3px;
	}
	 
	td {
	  background:#FFFFFF;
	  padding:5px;
	  vertical-align:middle;
	  font-weight:300;
	  font-size:14px;
	  text-shadow: -1px -1px 1px rgba(0, 0, 0, 0.1);
	  border-right: 1px solid #C1C3D1;
	  text-align: center;
	}
	
	td:last-child {
	  border-right: 0px;
	}

	a:hover{
		cursor:pointer
	}
	
	
</style>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script>

$(document).ready(function(){
	
	fn_userList()
	   
    
    
 });
 function fn_userList(){
	 
	$('#btn_user_agent').click(function(){
		
		 $.ajax({
			    type: 'post',
			    url: '${contextPath}/userList',
			    dataType: 'json',
			    success: function(resData){  
			    	/*  $('#list_head').empty(); */
			    	console.log(resData);
			       
			       $('#list_head').empty();
			       $('#list_body').empty();
			       $.each(resData, function( index, user ) {
			    	   
			    	   $('<tr>')
			    	  .append( $('<th>').text("유저번호") )
			    	  .append( $('<th>').text("아이디") )
			    	  .append( $('<th>').text("비밀번호") )
			    	  .append( $('<th>').text("이름") )
			    	  .append( $('<th>').text("성별") )
			    	  .append( $('<th>').text("이메일") )
			    	  .append( $('<th>').text("모바일") )
			    	  .append( $('<th>').text("출생년도") )
			    	  .append( $('<th>').text("출생일") )
			    	  .append( $('<th>').text("우편번호") )
			    	  .append( $('<th>').text("도로명") )
			    	  .append( $('<th>').text("지번주소") )
			    	  .append( $('<th>').text("상세주소") )
			    	  .append( $('<th>').text("참고항목") )
			    	  .append( $('<th>').text("동의항목") )
			    	  .append( $('<th>').text("간편가입종류") )
			    	  .append( $('<th>').text("가입일") )
			    	  .append( $('<th>').text("비밀번호수정일") )
			    	  .append( $('<th>').text("회원정보수정일") )
			    	  .append( $('<th>').text("세션아이디") )
			    	  .append( $('<th>').text("세션만료일") )
			    	  .append( $('<th>').text("포인트") )
			    	  .append( $('<th>').text("삭제") )
			    	  .appendTo('#list_head');
			    	   
			          $('<tr>')
			          .append( $('<td>').text(user.userNo) )
			          .append( $('<td>').text(user.id) )
			          .append( $('<td>').text(user.pw) )
			          .append( $('<td>').text(user.name) )
			          .append( $('<td>').text(user.gender) )
			          .append( $('<td>').text(user.email) )
			          .append( $('<td>').text(user.mobile) )
			          .append( $('<td>').text(user.birthyear) )
			          .append( $('<td>').text(user.birthday))
			          .append( $('<td>').text(user.postcode) )
			          .append( $('<td>').text(user.roadAdress) )
			          .append( $('<td>').text(user.jibunAdress) )
			          .append( $('<td>').text(user.detailAdress) )
			          .append( $('<td>').text(user.extraAdress) )
			          .append( $('<td>').text(user.agreeCode) )
			          .append( $('<td>').text(user.snsType) )
			          .append( $('<td>').text(user.joinDate) )
			          .append( $('<td>').text(user.pwModifyDate) )
			          .append( $('<td>').text(user.infoModifyDate) )
			          .append( $('<td>').text(user.sessionId) )
			          .append( $('<td>').text(user.sessionLimitDate) )
			          .append( $('<td>').text(user.point) )
			          .append($('<td>').append($('<a>').attr('onclick','if(confirm("정말 삭제하시겠습니까?")){location.href="${contextPath}/admin/userRemove?userNo='+ user.userNo +'"}').text('탈퇴')))
			          .appendTo('#list_body');
			       });
			    }   
			 }); 
	});
	 
 }


</script>
</head>
<body>
	<nav id="nav3">
	    <a href="#">4Team_Admin</a>
	    <ul>
	      <li><a id="btn_user_agent">회원관리</a></li>
	      <li><a href="${contextPath}/admin/bbs/agent">자유게시판관리</a></li>
	      <li><a href="${contextPath}/admin/gallery/agent">갤러리게시판관리</a></li>
	      <li><a href="${contextPath}/admin/upload/agent">업로드관리</a></li>
	      <li><a href="${contextPath}/admin/down/agent">다운로드관리</a></li>
	    </ul>
	
	    <select>
	      <option>=test=</option>
	      <option>=test=</option>
	      <option>=test=</option>
	    </select>
	 </nav>
	 
	 <div>
	 	<form id="frm_search">
			
			<select id="column" name="column">
				<option value="TITLE">제목</option>
				<option value="GENRE">장르</option>
				<option value="DESCRIPTION">내용</option>
			</select>
			<input type="text" id="searchText" name="searchText">
			<input type="button" id="btn_search" value="검색">
			<input type="button" id="btn_init" value="초기화" onclick="fn_loadList()")>
			
			<br><hr><br>
			
			<table>
				<thead id="list_head">
				</thead>
				<tbody id="list_body">
				</tbody>
			</table>
			
		</form>
	 
	 </div>
	
	
	
</body>
</html>