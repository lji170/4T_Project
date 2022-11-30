<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="layout/header.jsp">
	<jsp:param value="${gallery.galNo}번 갤러리" name="title"/>
</jsp:include>

<style>
	.blind {
		display : none;
	}
	#btn_like {
		width: 100px;
	}
</style>

<div>

	<h1>${gallery.galTitle}</h1>
	
	<div>
		<span>▷ 작성일 <fmt:formatDate value="${gallery.galCreateDate}" pattern="yyyy. M. d HH:mm" /></span>
		&nbsp;&nbsp;&nbsp;
		<span>▷ 수정일 <fmt:formatDate value="${gallery.galLastModifyDate}" pattern="yyyy. M. d HH:mm" /></span>
	</div>
	
	<div>
		<span>조회수 <fmt:formatNumber value="${gallery.galHit}" pattern="#,##0" /></span>
		좋아요 <span id="likeCountArea"></span>개
		<script>
			
		</script>
	</div>
	
	<hr>
	
	<div>
		${gallery.galContent}
	</div>
	
	<div>
		<form id="frm_btn" method="post">
			<input type="hidden" name="galNo" value="${gallery.galNo}">
			<script>
			
			</script>
			<img class="likeArea">
			<input type="button" value="수정" id="btn_edit_gallery">
			<input type="button" value="삭제" id="btn_remove_gallery">
			<input type="button" value="목록" onclick="location.href='${contextPath}/gallery/list'">
		</form>
		<script>
			$(function(){
		   		fn_getLikeCount(); 
				fn_getLikeUser();
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
		
			/* 좋아요 눌렀는지 확인하기 */
			function fn_getLikeUser(){
				$.ajax({
					type:'get',
					url :'${contextPath}/gallery/likeUser',
					data:'galNo=${gallery.galNo}&id=' + $('#id').val(),
					dataType:'json',
					success : function(resData){
						if (resData > 0) {
							alert('좋아요를 누른 회원입니다.')
							$('.likeArea')
								.attr('src','${contextPath}/resources/image/like.png')
						} else {
							alert('아직 좋아요를 누르지 않았네요!');
							$('.likeArea')
								.attr('src','${contextPath}/resources/image/dislike.png')
						}						
					}
				});
			}
		
			function fn_touchLike(){
				$('.likeArea').click(function(){
					$.ajax({
						type:'get',
						url :'${contextPath}/gallery/touchLike',
						data:'galNo=${gallery.galNo}&id=' + $('#id').val(),
						dataType:'int',
						success : function(resData) {
							alert('touch Like or Dislike!');
							if (resData == 0) {
								alert('좋아요를 누르셨습니다.');
							} else {
								alert('좋아요가 취소되었습니다.');
							}
						}
					});
				});
			}
			
			
			$('#btn_edit_gallery').click(function(){
				$('#frm_btn').attr('action', '${contextPath}/gallery/edit');
				$('#frm_btn').submit();
			});
			$('#btn_remove_gallery').click(function(){
				if(confirm('블로그를 삭제하면 블로그에 달린 댓글을 더 이상 확인할 수 없습니다. 삭제하시겠습니까?')){
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
	<input type="hidden" id="id" value="userpp">
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
					/* 
						resData = {
							"commentList" : [
								{댓글하나},
								{댓글하나},
								...
							],
							"pageUtil" : {
								page : x,
								...
							}
					}
					*/
					// 화면에 댓글 목록 뿌리기
					$('#comment_list').empty();
					$.each (resData.commentList, function(i, comment){
						// 댓글내용
						var div = '';
						div += '<div>' + comment.commentTitle;
						// 작성자만 삭제할 수 있도록 if 처리 필요
						div += '<input type="button" value="삭제" class="btn_comment_remove" data-comment_no="' + comment.commentNo + '">'; 
						// 댓글만 답글을 달 수 있도록 if 처리 필요
						div += '<input type="button" value="답글" class="btn_reply_area">';
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
				if(confirm('삭제된 댓글은 복수할 수 없습니다. 댓글을 삭제할까요?')){
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