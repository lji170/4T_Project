<%@page import="java.util.Optional"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script src="${contextPath}/resources/js/moment-with-locales.js"></script>
<head>
<meta charset="UTF-8">
<title>어드민 페이지</title>
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

</script>
</head>
<body>
	<nav id="nav3">
	    <a href="${contextPath}/move/index">4Team_Admin</a>
	    <ul>
	      <li><a id="btn_userList" onclick="fn_userList()">회원관리</a></li>
	      <li><a >자유게시판관리</a></li>
	      <li><a id="btn_galleryList" onclick="fn_galleryList()">갤러리게시판관리</a></li>
	      <li><a href="${contextPath}/admin/upload/agent">업로드관리</a></li>
	      <li><a href="${contextPath}/admin/down/agent">다운로드관리</a></li>
	    </ul>
	
	    <select>
	      <option>=</option>
	      <option>=test=</option>
	      <option>=test=</option>
	    </select>
	 </nav>
	 
	 

<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script>

$(document).ready(function(){
	
	fn_changeFindPage();
	fn_retireUser();
	fn_sleepUser();
    
 });

function fn_userList(){
	 
		 $.ajax({
			    type: 'post',
			    url: '${contextPath}/admin/userList',
			    data: 'page=' + $('#page').val(),
			    dataType: 'json',
			    success: function(resData){  
			    	
			    	/*  $('#list_head').empty(); */
			    	$('#admin_content').empty();
			    	$('#div1').empty();
			       $('<div id="div1">')
			       	.append('<h1>회원간략정보 및 회원검색</h1>')
			       	.append('<select id="column" name="column"><option value="ID">아이디</option><option value="NAME">이름</option><option value="MOBILE">핸드폰</option></select>')
			       	.append('<input type="text" id="searchText" name="searchText">')
			       	.append('<input type="button" id="btn_search" value="검색" onclick="fn_findUser();">')
			       	.append('<input type="button" id="btn_init" value="초기화" onclick="fn_userList();">')
			       	.append('<input type="button" id="btn_retireUser" value="탈퇴">')
			       	.append('<input type="button" id="btn_sleepUser" value="휴면">')
			    	.prependTo('#frm_search')
		
						
			       $('#list_head').empty();
			       $('#list_body').empty();
			       $('#list_foot').empty();
			       $('<tr>')
			    	  .append( $('<th>').text("유저번호") )
			    	  .append( $('<th>').text("아이디") )
			    	  .append( $('<th>').text("이름") )
			    	  .append( $('<th>').text("가입일") )
			    	  .append( $('<th>').text("핸드폰번호") )
			    	  .append( $('<th>').text("비밀번호수정일") )
			    	  .append( $('<th>').text("회원정보수정일") )
			    	  .append( $('<th>').text("포인트") )
			    	  .append( $('<th>').text("선택") )
			    	  .appendTo('#list_head');
			       $.each(resData.userList, function( index, user ) {
			    	   
			          $('<tr>')
			          
			          .append( $('<td>').text(user.userNo) )
			          .append( $('<td>').append(user.id))
			          .append( $('<td>').text(user.name) )
			          .append( $('<td>' +  moment(user.joinDate).format('YYYY.MM.DD hh:mm') + '</td>'))
			          .append( $('<td>').text(user.mobile) )
			          .append( $('<td>' +  moment(user.pwModifyDate).format('YYYY.MM.DD hh:mm') + '</td>'))
			          .append( $('<td>' +  moment(user.infoModifyDate).format('YYYY.MM.DD hh:mm') + '</td>'))
			          .append( $('<td>').text(user.point) )
			          .append($('<td>').append($('<input type="checkbox" name="userCheck" value="'+ user.userNo +'">')))
			          ///admin/userRemove?userNo='+ user.userNo 
			          .appendTo('#list_body');
			       });
			       $('<tr>')
			       .append($('<td id="paging" colspan="9"></td>'))
			       .appendTo('#list_foot');
			       
			       
			       $('#paging').empty();
					var pageUtil = resData.pageUtil
					var paging = '';
					// 이전 블록
					if(pageUtil.beginPage != 1){
						paging += '<span class="enable_findLink" data-page="'+ (pageUtil.beginPage - 1) +'">◀</span>';
					}
					for(let p = pageUtil.beginPage; p <= pageUtil.endPage; p++){
						if(p == $('#page').val()){
							paging += '<strong>' + p + '</strong>';
						} else {
							paging += '<span class="enable_findLink" data-page="'+ p +'">' + p + '</span>';
						}
					}
					// 다음블록
					if(pageUtil.endPage != pageUtil.totalPage){
						paging += '<span class="enable_findLink" data-page="'+ (pageUtil.endPage + 1) +'">▶</span>';
					}
					
					$('#paging').append(paging);
			    }   
			 }); 
 	}
 function fn_galleryList(){
	 $('#admin_content').empty();
 	$('#div1').empty();
    $('<div id="div1">')
    	.append('<h1>회원간략정보 및 회원검색</h1>')
    	.append('<select id="column" name="column"><option value="ID">아이디</option><option value="NAME">이름</option><option value="MOBILE">핸드폰</option></select>')
    	.append('<input type="text" id="searchText" name="searchText">')
    	.append('<input type="button" id="btn_search" value="검색" onclick="fn_findUser();">')
    	.append('<input type="button" id="btn_init" value="초기화" onclick="fn_userList();">')
    	.append('<input type="button" id="btn_retireUser" value="탈퇴">')
    	.append('<input type="button" id="btn_sleepUser" value="휴면">')
 	.prependTo('#frm_search')

	 $.ajax({
		type: 'post',
		url: '${contextPath}/admin/galleryList',
		data: 'page=' + $('#page').val(),
		dataType: 'json',
		success: function(resData){
			$('#list_head').empty();
			$('#list_body').empty();
			$('#list_foot').empty();
			
			
			 $('<tr>')
	    	  .append( $('<th>').text("갤러리번호") )
	    	  .append( $('<th>').text("유저아이디") )
	    	  .append( $('<th>').text("제목") )
	    	  .append( $('<th>').text("작성일") )
	    	  .append( $('<th>').text("수정일") )
	    	  .append( $('<th>').text("조회수") )
	    	  .append( $('<th>').text("좋아요") )
	    	  .append( $('<th>').text("선택") )
	    	  .appendTo('#list_head');
			 $.each(resData.galleryList, function( index, gallery ) {
				 $('<tr>')
		          
		          .append( $('<td>').text(gallery.galNo) )
		          .append( $('<td>').append(gallery.id))
		          .append( $('<td>').append('<a href="${contextPath}/gallery/detail?galNo='+ gallery.galNo + '">' + gallery.galTitle + '</a>') )
		          .append( $('<td>' +  moment(gallery.galCreateDate).format('YYYY.MM.DD hh:mm') + '</td>'))
		          .append( $('<td>' +  moment(gallery.galLastModifyDate).format('YYYY.MM.DD hh:mm') + '</td>'))
		          .append( $('<td>').append(gallery.galHit))
		          .append( $('<td>').append(gallery.likeCount))
		          .append($('<td>').append($('<input type="checkbox" name="userCheck" value="'+ gallery.galNo +'">')))
		          .appendTo('#list_body');
				 
			  });
			 $('<tr>')
		       .append($('<td id="paging" colspan="9"></td>'))
		       .appendTo('#list_foot');
		       
		       
		       $('#paging').empty();
				var pageUtil = resData.pageUtil
				var paging = '';
				// 이전 블록
				if(pageUtil.beginPage != 1){
					paging += '<span class="enable_findLink" data-page="'+ (pageUtil.beginPage - 1) +'">◀</span>';
				}
				for(let p = pageUtil.beginPage; p <= pageUtil.endPage; p++){
					if(p == $('#page').val()){
						paging += '<strong>' + p + '</strong>';
					} else {
						paging += '<span class="enable_findLink" data-page="'+ p +'">' + p + '</span>';
					}
				}
				// 다음블록
				if(pageUtil.endPage != pageUtil.totalPage){
					paging += '<span class="enable_findLink" data-page="'+ (pageUtil.endPage + 1) +'">▶</span>';
				}
				
				$('#paging').append(paging);
		}
		
		
	 });
 }
 
 function fn_findUser(){
	 $('#admin_content').empty();
 	$('#div1').empty();
    $('<div id="div1">')
    	.append('<h1>회원간략정보 및 회원검색</h1>')
    	.append('<select id="column" name="column"><option value="ID">아이디</option><option value="NAME">이름</option><option value="MOBILE">핸드폰</option></select>')
    	.append('<input type="text" id="searchText" name="searchText">')
    	.append('<input type="button" id="btn_search" value="검색" onclick="fn_findUser();">')
    	.append('<input type="button" id="btn_init" value="초기화" onclick="fn_userList();">')
    	.append('<input type="button" id="btn_retireUser" value="탈퇴">')
    	.append('<input type="button" id="btn_sleepUser" value="휴면">')
 	.prependTo('#frm_search')

		 
		 $.ajax({
			 type: 'post',
			 url: '${contextPath}/admin/searchUser',
			 data: 'column=' + $('#column').val() + '&searchText=' + $('#searchText').val() + '&page=' + $('#page').val(),
			 dataType: 'json',
			 success: function(resData){
				 $('#list_head').empty();
			     $('#list_body').empty();
			     $('#list_foot').empty();
			     $('<tr>')
		    	  .append( $('<th>').text("유저번호") )
		    	  .append( $('<th>').text("아이디") )
		    	  .append( $('<th>').text("이름") )
		    	  .append( $('<th>').text("가입일") )
		    	  .append( $('<th>').text("핸드폰번호") )
		    	  .append( $('<th>').text("비밀번호수정일") )
		    	  .append( $('<th>').text("회원정보수정일") )
		    	  .append( $('<th>').text("포인트") )
		    	  .append( $('<th>').text("선택") )
		    	  .appendTo('#list_head');
			     
		       $.each(resData.findUserList, function( index, findUser ) {
		    	   
		          $('<tr>')
		          .append( $('<td>').text(findUser.userNo) )
		          .append( $('<td>').append(findUser.id))
		          .append( $('<td>').text(findUser.name) )
		          .append( $('<td>' +  moment(findUser.joinDate).format('YYYY.MM.DD hh:mm') + '</td>'))
		          .append( $('<td>').text(findUser.mobile) )
		          .append( $('<td>' +  moment(findUser.pwModifyDate).format('YYYY.MM.DD hh:mm') + '</td>'))
		          .append( $('<td>' +  moment(findUser.infoModifyDate).format('YYYY.MM.DD hh:mm') + '</td>'))
		          .append( $('<td>').text(findUser.point) )
		          .append($('<form>'))
		          .append($('<td>').append($('<input type="checkbox" name="userCheck" value="'+ findUser.userNo +'">')))
		          ///admin/userRemove?userNo='+ user.userNo 
		          .appendTo('#list_body');
		       });
		       $('<tr>')
		       .append($('<td id="paging" colspan="9"></td>'))
		       .appendTo('#list_foot');
		       $('#paging').empty();
				var pageUtil = resData.pageUtil
				var paging = '';
				// 이전 블록
				if(pageUtil.beginPage != 1){
					paging += '<span class="enable_findLink" data-page="'+ (pageUtil.beginPage - 1) +'">◀</span>';
				}
				for(let p = pageUtil.beginPage; p <= pageUtil.endPage; p++){
					if(p == $('#page').val()){
						paging += '<strong>' + p + '</strong>';
					} else {
						paging += '<span class="enable_findLink" data-page="'+ p +'">' + p + '</span>';
					}
				}
				// 다음블록
				if(pageUtil.endPage != pageUtil.totalPage){
					paging += '<span class="enable_findLink" data-page="'+ (pageUtil.endPage + 1) +'">▶</span>';
				}
				
				$('#paging').append(paging);
			     
			 }
		 });
	
 }
 function fn_changeFindPage(){
		$(document).on('click', '.enable_findLink', function(){
			$('#page').val($(this).data('page'));
			fn_findUser();
		});
}
 function fn_changeListPage(){
	 $(document).on('click', '.enable_listLink', function(){
			$('#page').val($(this).data('page'));
			fn_userList();
		});
 }
function fn_retireUser(){
	
	$('#btn_retireUser').click(function(ev){
		if($('input[name="userCheck"]:checked').val() == 1){
			alert('관리자는 탈퇴할 수 없습니다.');
			ev.preventDefault();
			return;
		}
		var userArray = [];
	    $('input[name="userCheck"]:checked').each(function (index) {
	    	userArray.push($(this).val());
	    });
	    
	    $.ajax({
	    	type: 'post',
	    	url: '${contextPath}/admin/retireUser',
	    	data : {
	    		"userNo" : userArray
		    },
	    	dataType: 'json',
	    	success: function(resData){
	    		if(resData.isRemove >= 1){
	    			alert(resData.isRemove +"명을 강제탈퇴 했습니다.");
	    		} else {
	    			alert("탈퇴처리 실패");
	    		}
	    		fn_userList();
	    	}
	    });
	});
    
}
function fn_sleepUser(){
	$('#btn_sleepUser').click(function(){
		if($('input[name="userCheck"]:checked').val() == 1){
			alert('관리자는 휴면유저로 전환할 수 없습니다.');
			ev.preventDefault();
			return;
		}
		var userArray = [];
	    $('input[name="userCheck"]:checked').each(function (index) {
	    	userArray.push($(this).val());
	    });
	    
	    $.ajax({
	    	type: 'post',
	    	url: '${contextPath}/admin/sleepUser',
	    	data : {
	    		"userNo" : userArray
		    },
	    	dataType: 'json',
	    	success: function(resData){
	    		if(resData.isSleepUser >= 1){
	    			alert(resData.isSleepUser +"명을 휴면처리 했습니다.");
	    		} else {
	    			alert("휴면처리 실패");
	    		}
	    		fn_userList();
	    	}
	    });
	});
}
</script>
<div>
	 	<form id="frm_search">
			
			<div id='admin_content'>상단 메뉴에서 원하시는 기능을 선택해주세요</div>
			
			<br><hr><br>
			
			<table>
				<thead id="list_head">
				</thead>
				<tbody id="list_body">
				</tbody>
				<tfoot id="list_foot">
				</tfoot>
			</table>
			
		</form>
	 	<input type="hidden" id="page" value="1">
	 </div>


</body>
</html>