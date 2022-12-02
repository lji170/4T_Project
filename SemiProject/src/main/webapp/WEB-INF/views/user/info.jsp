<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원 정보 변경</title>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script>

	$(function(){
		fn_useremail();
		usergender();
		fn_join();
		fn_mobileCheck();
		
	});
	
	
	
	function fn_useremail(){
		
		$('#email').keyup(function(){
			
			// 정규식 
			let regEmail = /^[a-zA-Z0-9-_]+@[a-zA-Z0-9]+(\.[a-zA-Z]{2,}){1,2}$/;
			
			// 입력한 이메일
			let emailValue = $('#email').val();
			
			// 정규식 검사
			if(regEmail.test(emailValue) == false){
				$('#msg_email').text('이메일 형식이 올바르지 않습니다.'); 
				return;     // 아래 ajax 코드 진행을 막음
			}
			
			$.ajax({
				/* 요청 */
				type: 'get',
				url: '${contextPath}/user/checkReduceEmail',
				data: 'email=' + $('#email').val(),
				/* 응답 */
				dataType: 'json',
				success: function(resData){
					// 기존 회원 정보에 등록된 이메일이라면 실패 처리
					if(resData.isUser){
						$('#msg_email').text('이미가입된 이메일입니다. ');
					} else {
						$('#msg_email').text('사용 가능한 이메일입니다. ');
					}
				}  // resData
			});  // ajax
		})  //$('#email').keyup
	}
	
	

	
	function usergender(){
		
     switch("${loginUser.gender}"){
        case "NO" : $('#none').prop('checked', true); break;
        case "M" : $('#male').prop('checked', true); break;
        case "F" : $('#female').prop('checked', true); break;
        default : $('#none').prop('checked', true); 
  	  }  
     
     
     // attr -- prop('checked', "checked")
     // prop -- prop('checked', ture)
     // switch(${loginUser.gender})  이렇게 꺼내면 프로퍼티 타입이라 문자열 비교가 불가능함
      
	}
	
	
	// 휴대전화
	function fn_mobileCheck(){
		
		$('#mobile').keyup(function(){
			
			// 입력한 휴대전화
			let mobileValue = $('#mobile').val();
			
			// 휴대전화 정규식(010으로 시작, 하이픈 없이 전체 10~11자)
			let regMobile = /^010[0-9]{7,8}$/;
			
			// 정규식 검사
			if(regMobile.test(mobileValue) == false){
				$('#msg_mobile').text('휴대전화를 확인하세요.');
			} else {
				$('#msg_mobile').text('');
			}
			
		});  // keyup
		
	}  // fn_mobileCheck
	
	
	//주소
	
	
	
	// 서브밋 (회원가입)
	function fn_join(){
		
		$('#frm_join').submit(function(event){
			
			var email = $('#email').val();
			var gender = $('#gender').val();
			var mobile = $('#mobile').val();
			var postcode = $('#postcode').val();
			var roadAddress = $('#roadAddress').val();
			var jibunAddress = $('#jibunAddress').val();
			var detailAddress = $('#detailAddress').val();
			var extraAddress = $('#extraAddress').val();
			
		
			
		});  // submit
		
	}  // fn_join
	
	
	
	


</script>
</head>
<body>

	<div>
	
		<h2>${loginUser.name}님의 마이페이지_회원정보수정</h2>
		
		<hr>
		
		<form action="${contextPath}/user/info/change" method="post" id="frm_join">
			<div>
			회원정보 : 
				 <ul>
				 	<li>이메일 : <input type="text" id="email" name="email" placeholder="${loginUser.email}"><span id="msg_email"></span></li>
				 	<li>성별 : 
							<input type="radio" name="gender" id="none" value="NO">
							<label for="none">선택 안함</label>
							<input type="radio" name="gender" id="male" value="M">
							<label for="male">남자</label>
							<input type="radio" name="gender" id="female" value="F">
							<label for="female">여자</label>
					</li>
				 	<%-- <li>생년월일 : <input type="text" name="" placeholder="${loginUser.birthyear}.${loginUser.birthday}"></li> --%>
				 	<li>핸드폰번호 : <input type="text" name="mobile" id="mobile" placeholder="${loginUser.mobile}"><span id="msg_mobile"></span></li>
				 	<li>주소 : 
				 	<div>
						<input type="text" onclick="fn_execDaumPostcode()" name="postcode" id="postcode" placeholder="우편번호:${loginUser.postcode}" readonly="readonly">
						<input type="button" onclick="fn_execDaumPostcode()" value="우편번호 찾기"><br>
						<input type="text" name="roadAddress" id="roadAddress" placeholder="도로명주소:${loginUser.roadAddress}"  readonly="readonly">
						<input type="text" name="jibunAddress" id="jibunAddress" placeholder="지번주소:${loginUser.detailAddress}"  readonly="readonly"><br>
						<span id="guide" style="color:#999;display:none"></span>
						<input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소:${loginUser.detailAddress}">
						<input type="text" name="extraAddress" id="extraAddress" placeholder="참고항목:${loginUser.extraAddress}" readonly="readonly">
						<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
						<script>
						    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
						    function fn_execDaumPostcode() {
						        new daum.Postcode({
						            oncomplete: function(data) {
						                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
						
						                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
						                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						                var roadAddr = data.roadAddress; // 도로명 주소 변수
						                var extraRoadAddr = ''; // 참고 항목 변수
						
						                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
						                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
						                    extraRoadAddr += data.bname;
						                }
						                // 건물명이 있고, 공동주택일 경우 추가한다.
						                if(data.buildingName !== '' && data.apartment === 'Y'){
						                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
						                }
						                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						                if(extraRoadAddr !== ''){
						                    extraRoadAddr = ' (' + extraRoadAddr + ')';
						                }
						
						                // 우편번호와 주소 정보를 해당 필드에 넣는다.
						                document.getElementById('postcode').value = data.zonecode;
						                document.getElementById("roadAddress").value = roadAddr;
						                document.getElementById("jibunAddress").value = data.jibunAddress;
						                
						                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
						                if(roadAddr !== ''){
						                    document.getElementById("extraAddress").value = extraRoadAddr;
						                } else {
						                    document.getElementById("extraAddress").value = '';
						                }
						
						                var guideTextBox = document.getElementById("guide");
						                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
						                if(data.autoRoadAddress) {
						                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
						                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
						                    guideTextBox.style.display = 'block';
						
						                } else if(data.autoJibunAddress) {
						                    var expJibunAddr = data.autoJibunAddress;
						                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
						                    guideTextBox.style.display = 'block';
						                } else {
						                    guideTextBox.innerHTML = '';
						                    guideTextBox.style.display = 'none';
						                }
						            }
						        }).open();
						    }
						</script>
				</div>
				</li>
				 	
				 	
				 </ul>
			 </div>
			 
			 <button>수정하기</button>
			 
		 </form>
		 
		 
		<hr>
		
	</div>
	
	
	
	
	
	
				
	
	
	
	

</body>
</html>