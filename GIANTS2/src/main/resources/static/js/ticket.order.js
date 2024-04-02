$(function() {
	let team = $('#team_title').val();
	let totalPrice = $('#totalPrice').val();
	let ticket_num = 'T' + new Date().getTime();
	
	let game_date = $('#game_date').val();
	let game_time = $('#game_time').val();
	let name = $('#mem_name').val();
	let email = $('#mem_email').val();
	let phone = $('#mem_phone').val();
	
	/*$(document).on('click', '#seatInfo_check', function() {
		let seat_info = $('.seatBRCstatus').val();
		let length = $('.seatBRCstatus').length;
		
		alert(length);
		alert(seat_info);
		
		$.ajax({
			url:'searchSeatStatus.do',
			type:'post',
			data:{game_num:$('#game_num').val(), seat_info:$('.seatBRCstatus').val()},
			dataType:'json',
			success:function(param) {
				if(param.result == 'logout') {
					alert('Login 후 이용가능');
					location.href='../member/login.do';
				} else if(param.result == 'success') {
					return;
				}
			},
			error:function() { alert('Network 오류 발생'); }
		});
	});*/
	
	$(document).on('click', '#ticket_kakao', function() {
		// 결제 전 예매여부 확인용 통신
		
		
		/* Portone 결제 API */
		let IMP = window.IMP;
	    IMP.init('imp67587482');  // 가맹점 식별코드
		
		if($('input[name=check_info]:checked').length != 2) {
			alert('예매자 확인은 필수사항');
			return false;
		}
		
		// IMP.request_pay(param, callback) 결제창 호출
	 	IMP.request_pay({
	 		pg:'kakaopay.TC0ONETIME',
	 		pay_method:'card',
	 		merchant_uid:ticket_num,   // 주문번호
	 		name:game_date + ' 롯데 VS ' + team + ' ' + game_time,
	 		amount:totalPrice,	// 숫자 타입
	 		buyer_email:email,
	 		buyer_name:name,
	 		buyer_tel:phone
	 	}, function(rsp) {
	 		if(rsp.success) {
	 			let msg = '결제가 완료되었습니다.';
	 			let result = {
	 				'ticket_num':ticket_num,
	 				'game_num':$('#game_num').val(),
	 				'grade_num':$('#grade_num').val(),
	 				'check_num':$('#check_num').val(),
	 				'order_name':name,
	 				'order_phone':phone,
	 				'order_email':email,
	 				'game_title':team,
	 				'game_date':game_date,
	 				'game_time':game_time,
	 				'ticket_quantity':$('#ticket_quantity').val(),
	 				'total_price':totalPrice,
	 				'pg':'kakaopay',
	 				'pay_method':'card'
	 			}
	 			console.log(result);
	 			
	 			$.ajax({
	 				url:'insertMPay.do',
	 				type:'post',
	 				contentType:'application/json',
	 				data:JSON.stringify(result),
	 				success: function (res) { location.href=res; },
					error: function (err) { console.log(err); }
	 			}); 
	 		} else {
	 			let msg = '결제 실패\n';
	 			msg += 'ERROE : ' + rsp.error_msg;
	 		}
	 	});
	});
});