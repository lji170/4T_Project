<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디찾기</title>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script>

   $(function(){
      fn_emailCheck();
      
   });
   
   // 전역변수 (각종 검사를 통과하였는지 점검하는 플래그 변수)
   var authCodePass = false;
   
   function fn_emailCheck(){
      
      $('#btn_getAuthCode').click(function(){
         
         // 인증코드를 입력할 수 있는 상태로 변경함
         $('#authCode').prop('readonly', false);
         
         // resolve : 성공하면 수행할 function
         // reject  : 실패하면 수행할 function
         new Promise(function(resolve, reject) {
      
            // 정규식 
            let regEmail = /^[a-zA-Z0-9-_]+@[a-zA-Z0-9]+(\.[a-zA-Z]{2,}){1,2}$/;
            
            // 입력한 이메일
            let emailValue = $('#email').val();
            
            //정규식 검사
            if(regEmail.test(emailValue) == false){
               reject(1);  // catch의 function으로 넘기는 인수 : 1(이메일 형식이 잘못된 경우)
               authCodePass = false;
               return;     // 아래 ajax 코드 진행을 막음
            }
            
            // 이메일 중복 체크
            $.ajax({
               /* 요청 */
               type: 'get',
               url: '${contextPath}/user/checkReduceEmail',
               data: 'email=' + $('#email').val(),
               /* 응답 */
               dataType: 'json',
               success: function(resData){
                  // 기존 회원 정보에 등록된 이메일이라면 성공 처리
                  if(resData.isUser){
                     resolve();   // Promise 객체의 then 메소드에 바인딩되는 함수
                  } else {
                     reject(2);   // catch의 function으로 넘기는 인수 : 2(다른 회원이 사용중인 이메일이라서 등록이 불가능한 경우)
                  }
               }
            });  // ajax
            
         }).then(function(){
            
            // 인증번호 보내는 ajax
            $.ajax({
               /* 요청 */
               type: 'get',
               url: '${contextPath}/user/sendAuthCode',
               data: 'email=' + $('#email').val(),
               /* 응답 */
               dataType: 'json',
               success: function(resData){
                  alert('인증코드를 발송했습니다. 이메일을 확인하세요.');
                  // 발송한 인증코드와 사용자가 입력한 인증코드 비교
                  $('#btn_verifyAuthCode').click(function(){
                     if(resData.authCode == $('#authCode').val()){
                        alert('인증되었습니다.');
                        authCodePass = true;
                        fn_join();
                     } else {
                        alert('인증에 실패했습니다.');
                        authCodePass = false;
                     }
                  });
               },
               error: function(jqXHR){
                  alert('인증번호 발송이 실패했습니다.');
                  authCodePass = false;
               }
            });  // ajax
            
         }).catch(function(code){  // 인수 1 또는 2를 전달받기 위한 파라미터 code 선언

            switch(code){
            case 1:
               $('#msg_email').text('이메일 형식이 올바르지 않습니다.');
               break;
            case 2:
               $('#msg_email').text('가입되지 않은 이메일입니다.');
               break;
            }
         
            authCodePass = false;
         
            // 입력된 이메일에 문제가 있는 경우 인증코드 입력을 막음
            $('#authCode').prop('readonly', true);
            
         });  // new Promise
         
      });  // click
      
   }  // fn_emailCheck
   
   
   function fn_join(){
         
         if(authCodePass == false){
            alert('이메일 인증을 받으세요.');
            event.preventDefault();
            return;
            
         }else { 
            $.ajax({
               /* 요청 */
               type : 'post',
               url: '${contextPath}/user/findId/Form',
               data: 'email=' + $('#email').val(),
               /* 응답 */
               dataType: 'json',
               success: function(resData){
                  if(resData.findIdInUser != null){
                     $('#msg_showid').text('해당 이메일로 가입한 ID : ' + resData.findIdInUser.id);
                  }
                  if(resData.findIdInSleepUser !=null){
                     
                     $('#msg_showid').text('해당 이메일로 가입한 ID : ' + resData.findIdInSleepUser.id);
                  }
               },
               error: function(jqXHR){
                  alert('관리자에게 문의하세요.');
               }
            });
         }
   }
   
   




</script>
</head>
<body>

<h3>아이디 찾기</h3>

<h6>해당 아이디로 가입한 이메일 주소를 입력해주세요. (도메인 포함)</h6>


   <form>
      <div>
         <label for="email">이메일*</label>
         <input type="text" name="email" id="email">
         <input type="button" value="인증번호받기" id="btn_getAuthCode">
         <span id="msg_email"></span><br>
         <input type="text" id="authCode" placeholder="인증코드 입력">
         <input type="button" value="인증하기" id="btn_verifyAuthCode">
      </div>
      <hr>
      <div>
         <span id="msg_showid"></span>
      </div>
   </form>
   
   <a href="${contextPath}/move/index">로그인하러가기</a>

   

</body>
</html>