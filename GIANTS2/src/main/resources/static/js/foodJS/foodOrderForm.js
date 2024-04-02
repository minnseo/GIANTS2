$(function(){
	
	//===============정합성 검증용===================
	//
	// 구매자명 검증
	$("input[name='buyer_name']").on('blur', function() {
		// 입력 란이 비어 있는지 확인합니다.
		if ($(this).val().trim() === '') {
			// 입력 란이 비어 있으면 오류 메시지를 표시합니다.
			if ($(this).next(".error-color").length === 0) {
			    $(this).after("<span class='error-color'>구매자명을 입력하세요.</span>");
			}else{
				$(this).next(".error-color").text("구매자명을 입력하세요.");
			}
		 }else{
		    // 입력 란이 비어 있지 않으면 오류 메시지를 제거합니다.
		    $(this).next(".error-color").remove();
		}
	});
	
	// 전화번호 검증
	$("input[name='buyer_phone']").on('blur', function() {
		// 입력 란이 비어 있는지 확인합니다.
		if ($(this).val().trim() === '') {
			// 입력 란이 비어 있으면 오류 메시지를 표시합니다.
			if ($(this).next(".error-color").length === 0) {
			    $(this).after("<span class='error-color'>전화번호를 입력하세요.</span>");
				return;
			}else{
				$(this).next(".error-color").text("전화번호를 입력하세요.");
				return;
			}
		 }
		let phoneRegex = /^[0-9]{3}-[0-9]{4}-[0-9]{4}$/;
		if (!phoneRegex.test($(this).val())) {
			// 전화번호 형식이 아니면 오류 메시지를 표시합니다.
			if ($(this).next(".error-color").length === 0) {
				$(this).after("<span class='error-message'>전화번호 형식이 올바르지 않습니다.</span>");
				return;
			}else{
				$(this).next(".error-color").text("전화번호 형식이 올바르지 않습니다.");
				return;
			}
		}
	    // 입력 란이 비어 있지 않으면 오류 메시지를 제거합니다.
	    $(this).next(".error-color").remove();
	});
	
	// 이메일 검증
	$("input[name='buyer_email']").on('blur', function() {
		// 입력 란이 비어 있는지 확인합니다.
		if ($(this).val().trim() === '') {
			// 입력 란이 비어 있으면 오류 메시지를 표시합니다.
			if($(this).next(".error-color").length === 0){
				$(this).after("<span class='error-color'>이메일을 입력하세요.</span>");
				return;
			}else{
				$(this).next(".error-color").text("이메일을 입력하세요.");
				return;
			}
		}
		// 이메일 형식인지 확인합니다.
		let emailRegex = /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
		if (!emailRegex.test($(this).val())) {
			// 이메일 형식이 아니면 오류 메시지를 표시합니다.
			if($(this).next(".error-color").length === 0){
				$(this).after("<span class='error-color'>이메일 형식이 올바르지 않습니다.</span>");
				return;
			}else{
				$(this).next(".error-color").text("이메일 형식이 올바르지 않습니다.");
				return;
			}
		}
		// 입력 란이 비어 있지 않고, 이메일 형식이 맞으면 오류 메시지를 제거합니다.
		$(this).next(".error-color").remove();
	});
	
	//정합성 검증 함수
	function validate() {
		// 구매자명 입력 란이 비어 있는지 확인합니다.
		if ($("input[name='buyer_name']").val() === '') {
			// 구매자명 입력 란이 비어 있으면 오류 메시지를 표시합니다.
			if ($("input[name='buyer_name']").next(".error-color").length === 0) {
				$("input[name='buyer_name']").after("<span class='error-color'>구매자명을 입력하세요.</span>");
				return false;
			}else{
				$("input[name='buyer_name']").text("구매자명을 입력하세요.");
				return false;
			}
		}
		// 전화번호 입력 란이 비어 있는지 확인합니다.
		if ($("input[name='buyer_phone']").val() === '') {
			// 전화번호 입력 란이 비어 있으면 오류 메시지를 표시합니다.
			if ($("input[name='buyer_phone']").next(".error-color").length === 0) {
				$("input[name='buyer_phone']").after("<span class='error-color'>전화번호를 입력하세요.</span>");
				return false;
			}else{
				$("input[name='buyer_phone']").text("전화번호를 입력하세요.");
				return false;
			}
		}
		// 전화번호 형식인지 확인합니다.
		let phoneRegex = /^[0-9]{3}-[0-9]{4}-[0-9]{4}$/;
		if (!phoneRegex.test($("input[name='buyer_phone']").val())) {
			// 전화번호 형식이 아니면 오류 메시지를 표시합니다.
			if ($("input[name='buyer_phone']").next(".error-color").length === 0) {
				$("input[name='buyer_phone']").after("<span class='error-color'>전화번호 형식이 올바르지 않습니다.</span>");
				return false;
			}else{
				$("input[name='buyer_phone']").text("전화번호 형식이 올바르지 않습니다.");
				return false;
			}
		}
		// 이메일 입력 란이 비어 있는지 확인합니다.
		if ($("input[name='buyer_email']").val() === '') {
			// 이메일 입력 란이 비어 있으면 오류 메시지를 표시합니다.
			if ($("input[name='buyer_email']").next(".error-color").length === 0) {
				$("input[name='buyer_email']").after("<span class='error-color'>이메일을 입력하세요.</span>");
				return false;
			}else{
				$("input[name='buyer_email']").text("이메일을 입력하세요.");
				return false;
			}
		}
		// 이메일 형식인지 확인합니다.
		let emailRegex = /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
		if (!emailRegex.test($("input[name='buyer_email']").val())) {
			// 이메일 형식이 아니면 오류 메시지를 표시합니다.
			if ($("input[name='buyer_email']").next(".error-color").length === 0) {
				$("input[name='buyer_email']").after("<span class='error-color'>이메일 형식이 올바르지 않습니다.</span>");
				return false;
			}else{
				$("input[name='buyer_email']").text("이메일 형식이 올바르지 않습니다.");
				return false;
			}
		}
		// 모든 검증사항이 통과하면 true를 반환합니다.
		return true;
	}
	//
	//===============정합성 검증용 끝===================
	
	
	//주문하기 버튼 클릭시
	$(document).on('click','.order-btn',function(e){
		if(!validate()){
			alert('구매자 정보를 확인하세요');
			return false;
		}
		
		let form = $('#order_form').serialize();
		
		//결제전 확인
		$.ajax({
			url:'checkBeforePayment.do',
			type:'post',
			data:form,
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인이 필요한 기능입니다.');
					return;
				}else if(param.result == 'success'){
					//alert('데이터 검증완료.\n결제를 진행합니다.');
					
					
					//	-------------------------------
					//			포트원 결제 API
					//	-------------------------------
					var IMP = window.IMP;
					IMP.init('imp45386413');  // 가맹점 식별코드
					
					//상품명들
					let f_order_name = "[" + $('#comp_name').val() + "] " + $('.food-name').val();
					let trCount = $("#order_tb tr").length-2;
					if(trCount !== 1){
						f_order_name += " 외 " + trCount + "개의 상품"
					}
					
					//let total_price = $('#total_price').val();
					let total_price = 100;
					let f_order_num = 'F' + new Date().getTime();
					let buyer_email = $('#buyer_email').val();
					let buyer_name = $('#buyer_name').val();
					let buyer_phone = $('#buyer_phone').val();
					const cartNumTags = document.querySelectorAll('input[name="cart_numbers"]');
					const cart_numbers = [];
					for (const cartNum of cartNumTags) {
					  cart_numbers.push(cartNum.value);
					}
					// IMP.request_pay(param, callback) 결제창 호출
					// 카카오페이로 진행중
					IMP.request_pay({
						pg:'kakaopay',
						pay_method:'card',
						merchant_uid:f_order_num,   // 주문번호
						name:f_order_name,
						amount:total_price,	// 숫자 타입
						buyer_email:buyer_email,
						buyer_name:buyer_name,
						buyer_tel:buyer_phone
					}, function(rsp) {
						if(rsp.success) {
							let result = {
								//DB에 넣어야될 값을 객체로 생성
								'f_order_num':f_order_num,
								'comp_num':$('#comp_num').val(),
								'cart_numbers':cart_numbers,
								'f_order_name':f_order_name,
								'total_price':total_price,
								'buyer_email':buyer_email,
								'buyer_name':buyer_name,
								'buyer_phone':buyer_phone,
								'pay_method':'card',
								'pg':'kakaopay'
							}
							console.log(result);
							
							$.ajax({
								url:'insertF_orderPay.do',
								type:'post',
								contentType:'application/json',
								data:JSON.stringify(result),
								success: function (res) {
									alert('주문이 정상적으로 처리되었습니다.');
									//주문이 처리된 후, form을 생성하여 post전송 수행
									location.href= res + "?f_order_num=" + f_order_num;
								},
								error: function (err) { console.log(err); 
									alert('err : ' + err);
									return;
								}
							}); 
						} else {
							let msg = '결제 실패\n';
							msg += 'ERROR : ' + rsp.error_msg;
							alert(msg);
							return;
						}
					});
					
				}else if(param.result == 'UnknownCartNums'){
					alert('정상적인 주문이 아닙니다.');
					return;
				}else if(param.result == 'NotMatchTotalPrice'){
					alert('정상적인 주문이 아니거나 상품의 수량이 부족합니다.');
					return;
				}else{
					alert('결제 전 데이터 검증 오류 발생');
					return;
				}
			},
			error:function(){
				alert('결제 전 데이터 검증 - 네트워크 오류 발생');
			}
		});
		e.preventDefault();
	});// 결제 함수 수행 완료


});













