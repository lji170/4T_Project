<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="${contextPath}/resources/css/gallery.css">

<div id="top_fixer">
	<h1 id="top_title">갤러리 게시판</h1>
	<div id="login_area">
		<c:if test="${loginUser eq null}">
				<a href="${contextPath}/"> 로그인</a>
		</c:if>
		<c:if test="${loginUser != null}">
			<a id="login_hover" href="${contextPath}/user/check/form">${loginUser.name}</a>님
			<a id="login_hover" href="${contextPath}/user/logout">로그아웃</a>
		</c:if>
	</div>
	<div>
		<form method="post" action="${contextPath}/gallery/write">
			<input type="hidden" id="userId" value="${loginUser.id}">
		</form>
	</div>
</div>
<br/>
<jsp:include page="layout/header.jsp">
	<jsp:param value="${gallery.galNo}번 갤러리" name="title"/>
</jsp:include>
<div>${gallery.galTitle}</div>
<style>
	#btn_like {
		width: 100px;
	}
	
</style>
<script>
	$(function(){
		fn_getLikeCount();
	});
	function fn_getLikeCount(){
		$.ajax({
			type:'get',
			url :'${contextPath}/gallery/likeCount',
			data:'galNo=${gallery.galNo}',
			dataType:'json',
			success : function(resData){
				$('#likeCountArea').text(resData.likeCount);
			}
		});
	}
</script>
<div id="article">
	<div>
		<span>▷ 작성일 <fmt:formatDate value="${gallery.galCreateDate}" pattern="yyyy. M. d HH:mm" /></span>
		&nbsp;&nbsp;&nbsp;
		<span>▷ 수정일 <fmt:formatDate value="${gallery.galLastModifyDate}" pattern="yyyy. M. d HH:mm" /></span>
	</div>
	
	<div>
		<span>조회수 <fmt:formatNumber value="${gallery.galHit}" pattern="#,##0" /></span>
		좋아요 <span id="likeCountArea"></span>개
		
	</div>
	
	<hr>
	
	<div>
		${gallery.galContent}
	</div>
	
	<div>
		<form id="frm_btn" method="post">
			<input type="hidden" name="galNo" value="${gallery.galNo}">
			<input type="hidden" name="id" value="${loginUser.id}">
			<script>
			
			</script>
			<c:if test="${loginUser eq null}">
				<img id="unNamedLikeArea" src="${contextPath}/resources/images/dislike.png">
			</c:if>
			<script>
				$('#unNamedLikeArea').click(function(){
					alert('로그인한 유저만 좋아요를 누를 수 있습니다.');
				})
			</script>
			<c:if test="${loginUser ne null}">
				<img class="likeArea">
			</c:if>
			<!-- 게시글 작성자만 수정/삭제 가능 -->
			<c:if test="${loginUser.id eq gallery.id || loginUser.id eq 'admin'}">
				<input type="button" value="수정" id="btn_edit_gallery">
				<input type="button" value="삭제" id="btn_remove_gallery">
			</c:if>
				<input type="button" value="목록" onclick="location.href='${contextPath}/gallery/list'">
		</form>
		<script>
			$(function(){
				fn_getLikeUser();
			});
			
			
			// 로그인 유저만 좋아요 누르기
			function fn_checkLogin(){
				if (${loginUser eq null}){
					$('.likeArea').click(function(event){
						alert('로그인한 유저만 좋아요를 누를 수 있습니다.');
						event.preventDefault();
						return;
					})
				}
			}
			/* 좋아요 눌렀는지 확인하기 */
			function fn_getLikeUser(){
				$.ajax({
					type:'get',
					url :'${contextPath}/gallery/likeUser',
					data:'galNo=${gallery.galNo}&id=${loginUser.id}',
					dataType:'json',
					success : function(resData){
						if (resData > 0) {
							$('.likeArea')
								.attr('src','${contextPath}/resources/images/like.png');
						} else {
							$('.likeArea')
								.attr('src','${contextPath}/resources/images/dislike.png')
						}						
						fn_touchLike();
					}
				});
			}
			
		
			function fn_touchLike(){
				$('.likeArea').click(function(){
					$.ajax({
						type:'get',
						url :'${contextPath}/gallery/touchLike',
						data:'galNo=${gallery.galNo}&id=${loginUser.id}',
						dataType:'text',
						success : function(resData) {
							console.log('resData:' + resData);
							if (resData == 0) {
								alert('좋아요를 누르셨습니다.');
								$('.likeArea').empty();
								$('.likeArea')
									.attr('src','${contextPath}/resources/images/like.png');
							} else {
								alert('좋아요가 취소되었습니다.');
								$('.likeArea').empty();
								$('.likeArea')
								.attr('src','${contextPath}/resources/images/dislike.png');
							}
							fn_getLikeCount();
						},
						error : function(jqXHR){
							console.log(jqXHR);
							alert('오류!');
						}
					});
				});
			}
		 
			
			$('#btn_edit_gallery').click(function(){
				$('#frm_btn').attr('action', '${contextPath}/gallery/edit');
				$('#frm_btn').submit();
			});
			$('#btn_remove_gallery').click(function(){
				if(confirm('갤러리를 삭제하면 블로그에 달린 댓글을 더 이상 확인할 수 없습니다. 삭제하시겠습니까?')){
					$('#frm_btn').attr('action', '${contextPath}/gallery/remove');
					$('#frm_btn').submit();
				}
			});
			
		</script> 
	</div>
	
	<hr/>
	
	<span id="btn_comment_list">댓글
		<span id="comment_count"></span>개
	</span>
	<div id="comment_area" class="blind">
		<div>
			<form id="frm_add_comment">
				<div class="add_comment">
					<div class="add_comment_input add_comment_btn">
						<input type="hidden" name="id" value="${loginUser.id}">
						<input type="text" name="commentTitle" id="commentTitle" placeholder="댓글을 작성하려면 로그인 해 주세요.">
						<input type="button" value="작성완료" id="btn_add_comment">
					</div>
				</div>	
				<input type="hidden" name="galNo" value="${gallery.galNo}">	
			</form>
		</div>
		<div id="comment_list"></div>
		<div id="paging"></div>
	</div>
	<!-- 현재 페이지 번호를 저장하고 있는 hidden -->
	<input type="hidden" id="page" value="1">
	<script>
		
		// 전역 변수 page 	(모든 함수에서 사용 가능)
		var page = 1;

		// 함수 호출
		fn_commentCount();
		fn_switchCommentList();
		fn_addComment();
		fn_commentList();
		fn_changePage();
		fn_removeComment();
	
		// 함수 정의
		function fn_commentCount(){
			$.ajax({
				type: 'get',
				url : '${contextPath}/comment/getCount',
				data: 'galNo=${gallery.galNo}',
				dataType: 'json',
				success : function(resData){	// resData = {"commentCount": 개수}
					$('#comment_count').text(resData.commentCount);
				}
			});
		}
		
		function fn_addComment(){
			$('#btn_add_comment').click(function(){
				// 비회원 댓글 작성 방지
				// 알럿창 + 내용 비우기
				if(${loginUser eq null}) {
					alert('로그인한 유저만 댓글을 달 수 있습니다.');
					$('#commentTitle').val('');
					return;
				}
				if($('#commentTitle').val() == ''){
					alert('댓글 내용을 입력하세요');
					return;
				}
				$.ajax({
					type: 'post',
					url : '${contextPath}/comment/add',
					data: $('#frm_add_comment').serialize(),
					dataType: 'json',
					success : function(resData){	// resData = {"isAdded",true}
						if(resData.isAdd){
							alert('댓글이 등록되었습니다.');
							$('#commentTitle').val('');	// 컨텐츠 내용 지워주기
							fn_commentList();	// 댓글 목록 가져와서 뿌리는 함수
							fn_commentCount();	// 댓글 목록 개수 갱신하는 함수
						}
					}
				});
			});
		}
		
		function fn_commentList(){
			$.ajax({
				type:'get',
				url :'${contextPath}/comment/list',
				data:'galNo=${gallery.galNo}&page=' + $('#page').val(),	// 페이징 처리를 위해, 현재 page도 파라미터로 전달!
				dataType: 'json',
				success : function(resData){
					// 화면에 댓글 목록 뿌리기
					$('#comment_list').empty();
					$.each (resData.commentList, function(i, comment){
						// 댓글내용
						var div = '';
						div += '<div>' + comment.commentTitle;
						div += '<span class="writer">작성자</span>' + comment.id;
						// 작성자만 삭제할 수 있도록 if 처리 필요
						if (${loginUser.id ne null}) {
							
							var loginUser = '${loginUser.id}';
							if(loginUser == comment.id || ${loginUser.id eq 'admin'})
							div += '<input type="button" value="삭제" class="btn_comment_remove" data-comment_no="' + comment.commentNo + '">'; 
						}
						div += '</div>';
						// 댓글내용 밑에 시간표기
						// 2022.11.28 11:00
						div += '<div>';
						moment.locale('ko-KR');
						div += '<span style="font-size: 12px; color:silver;">'+ moment(comment.commentCreateDate).format('YYYY.MM.DD hh:mm') + '</span>';
						div += '</div>';
						div += '</div>';
						$('#comment_list').append(div);
						$('#comment_list').append('<div style="border-bottm: 1px dotted gray;"></div>')
					});
					// 페이징
					$('#paging').empty();
					var pageUtil = resData.pageUtil;
					var paging ='';
					// 이전 블록
					if (pageUtil.beginPage != 1){
						paging += '<span class="enable_link" data-page="' + (pageUtil.beginPage - 1) + '">◀</span>';
					}
					// 페이지번호
					for (let p = pageUtil.beginPage; p <= pageUtil.endPage; p++){
						if(p ==  $('#page').val()) {
							paging += '<strong>' +p+ '</strong>';
						} else {
							paging += '<span class="enable_link" data-page="'+p+'">' + p + '</span>';
						}
					}
					// 다음 블록
					if(pageUtil.endPage != pageUtil.totalPage){
						paging += '<span class="enable_link" data-page="' + (pageUtil.endPage + 1) + '">▶</span>';
					}
					// 화면에 뿌리기
					$('#paging').append(paging);
				}
			});
		}
		
		function fn_changePage(){
			$(document).on('click', '.enable_link', function(){
				$('#page').val( $(this).data('page') );
				fn_commentList();
			})
		}
		
		function fn_switchCommentList(){
			$('#btn_comment_list').click(function(){
				$('#comment_area').toggleClass('blind');
			});
		}
		
		function fn_removeComment(){
			$(document).on('click', '.btn_comment_remove', function(){
				if(confirm('삭제된 댓글은 복구할 수 없습니다. 댓글을 삭제할까요?')){
					$.ajax({
						type: 'post',
						url : '${contextPath}/comment/remove',
						data: 'commentNo=' + $(this).data('comment_no'),
						dataType: 'json',
						success : function(resData){	// resData = {"isRemove" : true}
							if(resData.isRemove) {
								alert('댓글이 삭제되었습니다.');
								fn_commentList();  // 목록 갱신
								fn_commentCount(); //
							}
						}
					});
				}
			});
			
		};
		
	</script>
</div>
</body>
</html>