/**
 * 
 */

$(function(){
	fn_checkAll();
	fn_checkOne();
	fn_toggleCheck();
	fn_submit();
});

// 모두 동의 (모두 동의의 체크 상태 = 개별 선택들의 체크 상태)
function fn_checkAll(){
	$('#check_all').click(function(){
		// 체크 상태 변경
		$('.check_one').prop('checked', $(this).prop('checked'));
		// 체크 이미지 변경
		if($(this).is(':checked')){  // 모두 동의가 체크되었다면
			$('.lbl_one').addClass('lbl_checked');
		} else {
			$('.lbl_one').removeClass('lbl_checked');
		}
	});
}

// 개별 선택 (항상 개별 선택 4개롤 모두 순회하면서 어떤 상태인지 체크해야 함)
function fn_checkOne(){
	$('.check_one').click(function(){
		// 체크 상태 변경
		let checkCount = 0;
		for(let i = 0; i < $('.check_one').length; i++){
			checkCount += $($('.check_one')[i]).prop('checked');
		}
		// 체크박스개수 vs 체크된박스개수
		$('#check_all').prop('checked', $('.check_one').length == checkCount);
		// 체크 이미지 변경
		if($('#check_all').is(':checked')){
			$('.lbl_all').addClass('lbl_checked');
		} else {
			$('.lbl_all').removeClass('lbl_checked');
		}
	});
}

// 체크할때마다 lbl_checked 클래스를 줬다 뺐었다 하기
function fn_toggleCheck(){
	$('.lbl_all, .lbl_one').click(function(){
		$(this).toggleClass('lbl_checked');
	});
}

// 서브밋 (필수 체크 여부 확인)
function fn_submit(){
	$('#frm_agree').submit(function(event){
		if($('#service').is(':checked') == false || $('#privacy').is(':checked') == false){
			alert('필수 약관에 동의하세요.');
			event.preventDefault();
			return;
		}
	});
}