<%@page import="java.util.Optional"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- * jsp에서 자바를 사용해 임폴트하면 생기는 표시 --%>
<%

	// # title에 사용될 변수처리
	Optional<String> opt = Optional.ofNullable(request.getParameter("title"));
	String title = opt.orElse("Welcome");
	pageContext.setAttribute("title", title);
	
	// # 컨텍스트 패스
	pageContext.setAttribute("contextPath", request.getContextPath());

%>




<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${title}</title>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script src="${contextPath}/resources/js/upload.js"></script>
<link rel="stylesheet" href="${contextPath}/resources/css/upload.css">
<style>

.btn_add_logout {
	
	padding : 0 auto;
	display : inline-block;
	height : 30px;
	line-height : 30px;
	background-color: #dddddd;
	border : 1px solid #888888;
	border-radius: 3px;
	margin: 10px 0;
	
	}



</style>
</head>
<body>
	<div class="container">
		<div class="header">
			<div class="title">
				<h1>업로드 게시판</h1>
				<div class="log_area">
					<a id="header_login" class="btn_add_login" href="${contextPath}/index/form">로그인</a>
					<a id="header_logout" class="dis_blind" href="${contextPath}/upload/logout">로그아웃</a>
				</div>
			</div>	
		</div>


