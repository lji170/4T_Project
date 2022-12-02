<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ȸ�� ���� ����</title>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script>

	$(function(){
		fn_useremail();
		usergender();
		fn_join();
		fn_mobileCheck();
	});
	
	// ����� �� ! ���������� ���ؼ� �˻�
	var useremail = false;
	var mobilePass = false;
	
	function fn_useremail(){
		
		$('#email').keyup(function(){
			
			// ���Խ� 
			let regEmail = /^[a-zA-Z0-9-_]+@[a-zA-Z0-9]+(\.[a-zA-Z]{2,}){1,2}$/;
			
			// �Է��� �̸���
			let emailValue = $('#email').val();
			
			// ���Խ� �˻�
			if(regEmail.test(emailValue) == false){
				$('#msg_email').text('�̸��� ������ �ùٸ��� �ʽ��ϴ�.'); 
				return;     // �Ʒ� ajax �ڵ� ������ ����
			}
			
			$.ajax({
				/* ��û */
				type: 'get',
				url: '${contextPath}/user/checkReduceEmail',
				data: 'email=' + $('#email').val(),
				/* ���� */
				dataType: 'json',
				success: function(resData){
					// ���� ȸ�� ������ ��ϵ� �̸����̶�� ���� ó��
					if(resData.isUser){
						$('#msg_email').text('�̹̰��Ե� �̸����Դϴ�. ');
						useremail = false;
					} else {
						$('#msg_email').text('��� ������ �̸����Դϴ�. ');
						
					}
				}  // resData
			});  // ajax
		})  //$('#email').keyup
		
	}
	
	
	// ����� (ȸ������)
	function fn_join(){
		
		$('#frm_join').submit(function(event){
			
			if(useremail == false){
				alert('�̸����� Ȯ���ϼ���.');
				event.preventDefault();
				return;
			}else if(mobilePass==false){
				alert('�޴�����ȣ�� Ȯ���ϼ���.');
			}
			
		});  // submit
		
	}  // fn_join
	
	
	function usergender(){
		
     switch("${loginUser.gender}"){
        case "NO" : $('#none').prop('checked', true); break;
        case "M" : $('#male').prop('checked', true); break;
        case "F" : $('#female').prop('checked', true); break;
        default : $('#none').prop('checked', true); 
  	  }  
     
     
     // attr -- prop('checked', "checked")
     // prop -- prop('checked', ture)
     // switch(${loginUser.gender})  �̷��� ������ ������Ƽ Ÿ���̶� ���ڿ� �񱳰� �Ұ�����
      
	}
	
	
	// �޴���ȭ
	function fn_mobileCheck(){
		
		$('#mobile').keyup(function(){
			
			// �Է��� �޴���ȭ
			let mobileValue = $(this).val();
			
			// �޴���ȭ ���Խ�(010���� ����, ������ ���� ��ü 10~11��)
			let regMobile = /^010[0-9]{7,8}$/;
			
			// ���Խ� �˻�
			if(regMobile.test(mobileValue) == false){
				$('#msg_mobile').text('�޴���ȭ�� Ȯ���ϼ���.');
				mobilePass = false;
			} else {
				$('#msg_mobile').text('');
				mobilePass = true;
			}
			
		});  // keyup
		
	}  // fn_mobileCheck
	
	
	


</script>
</head>
<body>

	<div>
	
		<h2>${loginUser.name}���� ����������_ȸ����������</h2>
		
		<hr>
		
		<form action="${context}/user/info/change" method="post" id="frm_join">
			<div>
			ȸ������ : 
				 <ul>
				 <c:if test="${loginUser.snsType eq 'naver'}">
				 	<li>���̹� ������ ȸ��</li>
				 	<li>���� : <input type="text" name="name" placeholder="${loginUser.name}" ></li>
				 </c:if>
				 	<li>�̸��� : <input type="text" id="email" name="email" placeholder="${loginUser.email}"><span id="msg_email"></span></li>
				 	<li>���� : 
				 	
							<input type="radio" name="gender" id="none" value="NO">
							<label for="none">���� ����</label>
							<input type="radio" name="gender" id="male" value="M">
							<label for="male">����</label>
							<input type="radio" name="gender" id="female" value="F">
							<label for="female">����</label>
					</li>
				 	<%-- <li>������� : <input type="text" name="" placeholder="${loginUser.birthyear}.${loginUser.birthday}"></li> --%>
				 	<li>�ڵ�����ȣ : <input type="text" name="phone" placeholder="${loginUser.mobile}"></li>
				 	<li>�ּ� : 
				 	<div>
						<input type="text" onclick="fn_execDaumPostcode()" name="postcode" id="postcode" placeholder="�����ȣ:${loginUser.postcode}" readonly="readonly">
						<input type="button" onclick="fn_execDaumPostcode()" value="�����ȣ ã��"><br>
						<input type="text" name="roadAddress" id="roadAddress" placeholder="���θ��ּ�:${loginUser.roadAddress}"  readonly="readonly">
						<input type="text" name="jibunAddress" id="jibunAddress" placeholder="�����ּ�:${loginUser.detailAddress}"  readonly="readonly"><br>
						<span id="guide" style="color:#999;display:none"></span>
						<input type="text" name="detailAddress" id="detailAddress" placeholder="���ּ�:${loginUser.detailAddress}">
						<input type="text" name="extraAddress" id="extraAddress" placeholder="�����׸�:${loginUser.extraAddress}" readonly="readonly">
						<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
						<script>
						    //�� ���������� ���θ� �ּ� ǥ�� ��Ŀ� ���� ���ɿ� ����, �������� �����͸� �����Ͽ� �ùٸ� �ּҸ� �����ϴ� ����� �����մϴ�.
						    function fn_execDaumPostcode() {
						        new daum.Postcode({
						            oncomplete: function(data) {
						                // �˾����� �˻���� �׸��� Ŭ�������� ������ �ڵ带 �ۼ��ϴ� �κ�.
						
						                // ���θ� �ּ��� ���� ��Ģ�� ���� �ּҸ� ǥ���Ѵ�.
						                // �������� ������ ���� ���� ��쿣 ����('')���� �����Ƿ�, �̸� �����Ͽ� �б� �Ѵ�.
						                var roadAddr = data.roadAddress; // ���θ� �ּ� ����
						                var extraRoadAddr = ''; // ���� �׸� ����
						
						                // ���������� ���� ��� �߰��Ѵ�. (�������� ����)
						                // �������� ��� ������ ���ڰ� "��/��/��"�� ������.
						                if(data.bname !== '' && /[��|��|��]$/g.test(data.bname)){
						                    extraRoadAddr += data.bname;
						                }
						                // �ǹ����� �ְ�, ���������� ��� �߰��Ѵ�.
						                if(data.buildingName !== '' && data.apartment === 'Y'){
						                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
						                }
						                // ǥ���� �����׸��� ���� ���, ��ȣ���� �߰��� ���� ���ڿ��� �����.
						                if(extraRoadAddr !== ''){
						                    extraRoadAddr = ' (' + extraRoadAddr + ')';
						                }
						
						                // �����ȣ�� �ּ� ������ �ش� �ʵ忡 �ִ´�.
						                document.getElementById('postcode').value = data.zonecode;
						                document.getElementById("roadAddress").value = roadAddr;
						                document.getElementById("jibunAddress").value = data.jibunAddress;
						                
						                // �����׸� ���ڿ��� ���� ��� �ش� �ʵ忡 �ִ´�.
						                if(roadAddr !== ''){
						                    document.getElementById("extraAddress").value = extraRoadAddr;
						                } else {
						                    document.getElementById("extraAddress").value = '';
						                }
						
						                var guideTextBox = document.getElementById("guide");
						                // ����ڰ� '���� ����'�� Ŭ���� ���, ���� �ּҶ�� ǥ�ø� ���ش�.
						                if(data.autoRoadAddress) {
						                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
						                    guideTextBox.innerHTML = '(���� ���θ� �ּ� : ' + expRoadAddr + ')';
						                    guideTextBox.style.display = 'block';
						
						                } else if(data.autoJibunAddress) {
						                    var expJibunAddr = data.autoJibunAddress;
						                    guideTextBox.innerHTML = '(���� ���� �ּ� : ' + expJibunAddr + ')';
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
			 
			 <button>�����ϱ�</button>
			 
		 </form>
		 
		 
		<hr>
		
	</div>
	
	
	
	
	
	
				
	
	
	
	

</body>
</html>