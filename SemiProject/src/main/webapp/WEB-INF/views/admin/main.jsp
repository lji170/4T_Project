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
</style>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
</head>
<body>
	<nav id="nav3">
	    <a href="#">4Team_Admin</a>
	    <ul>
	      <li><a href="${contextPath}/admin/user/agent">회원관리</a></li>
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

	
</body>
</html>