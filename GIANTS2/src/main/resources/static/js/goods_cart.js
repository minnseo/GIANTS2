$(function(){
	//============================
	//바로 구매 폼 아이디 - 장바구니에 등록하되, 리스트를 불러오지 않고 바로 결제폼으로 이동시킴
	$('#goods_direct').submit(function(event){
		event.preventDefault(); // 기본 클릭 동작을 막음
		 
		if (optNumValue === "") {
	        alert("옵션을 선택하세요.");
	        return false;
	    }
		if($('#order_quantity').val() == ''){
			alert('수량을 입력하세요');
			$('#order_quantity').focus();
			return false;
		}
		
	    var selectedOption = $('#optionSelect option:selected');
	    var optNumValue = selectedOption.val();
		let form_data = {
			//gcartVO
		    goods_num: $('#goods_num').val(),
		    goods_dprice: $('#goods_dprice').val(),
		    order_quantity: $('#order_quantity').val(),
		    opt_num: optNumValue,
		    goods_name : $('#goods_name').val()
		   // goods_status : $('#goods_status').val()
		};
		$.ajax({
			url:'../order/write.do', //장바구니에 등록해주는 작업
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 사용하세요!');
				}else if(param.result == 'success'){
					alert('바로 결제 성공! 주문 폼으로 이동합니다.');
					location.href='../gorder/orderFormDirect.do'; //바로 결제폼으로 이동
				} 
				else if(param.result=='clearCart'){
					alert('장바구니를 비우고 구매해주세요!');
					location.href='../gorder/goods_cart.do';
				}
				else if(param.result=='overquantity'){
					alert('재고수 부족');
					location.href='../goods/goodsList.do';
				}
				else{
					alert('바로구매 오류');
				}
			},
			error:function(){
				alert('네트워크 오류 발생 - 바로구매');
			}
		});
		event.preventDefault();
	});
	//==========================================
	
	
	//============================
	//장바구니 등록
	$('#goods_cart').submit(function(event){
		
		if($('#order_quantity').val() == ''){
			alert('수량을 입력하세요');
			$('#order_quantity').focus();
			return false;
		}
		
		 // 선택된 옵션 정보 가져오기
		var selectedOption = $('#optionSelect option:selected');
		var optNumValue = selectedOption.val();
		console.log("Selected opt_num:", optNumValue);		
		    // 옵션 선택 여부 확인
		    if (optNumValue === "") {
		        alert("옵션을 선택하세요.");
		        return false;
		    }
		
		let form_data = {
		    goods_num: $('#goods_num').val(),
		    goods_dprice: $('#goods_price').val(),
		    order_quantity: $('#order_quantity').val(),
		    opt_num: optNumValue // 이 부분 추가
		};
		
		//장바구니
  		//서버와 통신
		$.ajax({
			url:'../cart/write.do',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 사용하세요!');
				}else if(param.result == 'success'){
					alert('장바구니에 담았습니다.');
					location.href='../gorder/goods_cart.do';
				}else if(param.result == 'overquantity'){
					alert('기존에 주문한 상품입니다. 개수를 추가하면 재고가 부족합니다.');
				}else{
					alert('장바구니 담기 오류');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
		event.preventDefault();
	});		
	  
	//장바구니에 담겨있는 상품의 총구매금액
	let cart_sum = $('.all-total').attr('data-alltotal');
	
	/*============================
	 * 장바구니 체크박스 제어
     *============================*/
	//전체 선택/해제
	$('#chk_all').on('click',function(){
		if($('#chk_all').is(':checked')){
			//------------ 전체 선택 시작 ------------
			$('.choice-btn').prop('checked',true);
			$('#order_btn').prop('disabled',false);//구매 가능
			
			//개별 상품 정보를 모두 표시
			$('.goods-setting').remove();
			//$('.order_quantity').show();
			$('.goods_dprice').text(function(){
				return Number($(this).attr('data-dprice')).toLocaleString()+'원';
			});
			$('.order_point').show();
			$('.sub-total').show();
			//모두 선택하면 총구매 금액을 원래 총구매 금액으로 환원
			$('.all-total').attr('data-alltotal',cart_sum);
			
		}else{
			//------------ 전체 해제 시작 ------------
			$('.choice-btn').prop('checked',false);
			$('#order_btn').prop('disabled',true);//구매 불가
			
			//개별 상품 정보를 모두 0표시
			//$('.order_quantity').before('<span class="goods-setting">0</span>');
			//$('.order_quantity').hide();
			$('.goods_dprice').text('0원');
			$('.order_point').before('<span class="goods-setting">0p</span>');
			$('.order_point').hide();
			$('.sub-total').before('<span class="goods-setting">0원</span>');
			$('.sub-total').hide();
			$('.all-total').text('0원');
			$('.all-total').attr('data-alltotal',0);
		}
		
		//총구매 금액 표시
		$('.all-total').text(
			Number($('.all-total').attr('data-alltotal')).toLocaleString()+'원');
		
	});
	
	//개별 체크박스 선택/해제
	//체크박스를 전부 선택하면 #chk_all 선택, 하나라도 해제하면 #chk_all 해제
	$('.choice-btn').on('click',function(){
		if($('input[class=choice-btn]:checked').length==$('.choice-btn').length){
			//전체 체크박스 선택
			$('#chk_all').prop('checked',true);
		}else{
			//부분 체크박스 선택
			$('#chk_all').prop('checked',false);
		}
		
		if($(this).is(':checked')){
			//체크하면 수량,가격,배송비,개별 상품 합계가 정확하게 표시
			$(this).parents('tr').find('.goods-setting').remove();
			//$(this).parents('tr').find('.goods_dprice').text(Number($(this).parents('tr').find('.goods_price').attr('data-dprice')).toLocaleString()+'원'); //NAN왜?!
			$(this).parents('tr').find('.goods_dprice').show();
			//$(this).parents('tr').find('.order_quantity').show();
			$(this).parents('tr').find('.order_point').show();
			$(this).parents('tr').find('.sub-total').show();
		}else{
			//체크를 해제하면 수량,가격,배송비,개별 상품 합계가 모두 0으로 표시
			//$(this).parents('tr').find('.order_quantity').before('<span class="goods-setting">0</span>');
			//$(this).parents('tr').find('.order_quantity').hide();
			
			
			$(this).parents('tr').find('.goods_dprice').before('<span class="goods-setting">0원</span>');
			$(this).parents('tr').find('.goods_dprice').hide();
			//$(this).parents('tr').find('.goods_dprice').text('0원');
			
			$(this).parents('tr').find('.order_point').before('<span class="goods-setting">0p</span>');
			$(this).parents('tr').find('.order_point').hide();
			
			
			$(this).parents('tr').find('.sub-total').before('<span class="goods-setting">0원</span>');
			$(this).parents('tr').find('.sub-total').hide();
		}
		
		//총구매금액 정보 처리
		//모두 선택된 것이 없으면 false 반환, 하나라도 선택된 것이 있으면 true 반환 
		if($('.choice-btn').is(':checked')){
			$('#order_btn').prop('disabled',false);//구매 가능
			//총구매 금액을 선택과 미선택에 따라 다시 산출
			if($(this).is(':checked')){//선택
				$('.all-total').attr('data-alltotal',
				     Number($('.all-total').attr('data-alltotal'))+Number($(this).parents('tr').find('.sub-total').attr('data-total')));
			}else{//선택 해제
				$('.all-total').attr('data-alltotal',
				     $('.all-total').attr('data-alltotal')- $(this).parents('tr').find('.sub-total').attr('data-total'));
			}
		}else{
			$('#order_btn').prop('disabled',true);//구매 불가
			$('.all-total').attr('data-alltotal',
			$('.all-total').attr('data-alltotal')-$(this).parents('tr').find('.sub-total').attr('data-total'));
		}
		
		//총구매 금액 표시
		$('.all-total').text(
			Number($('.all-total').attr('data-alltotal')).toLocaleString()+'원');
		
	});
	
	/*============================
	 * 장바구니 상품 주문 수량 변경
     *============================*/
	$('.cart-modify').on('click',function(){
		
		let mem_num = $('#mem_num').val();
		console.log("회원번호 : " , mem_num);
		let order_quantity = $('#order_quantity').val();
		console.log("읽어온 상품 수량 : ", order_quantity);
		
		if(order_quantity==''){
			alert('수량을 입력하세요');
			return;
		}
		
		if(isNaN(order_quantity)){
			 //태그에 명시한 value값을 읽어옴
			order_quantity.order_quantity.attr('value');
			return;
		}
		
		if(order_quantity < 1){
			alert('상품의 최소 수량은 1입니다.');
			order_quantity.attr('value');
			return;
		}
		
		//서버와 통신
		$.ajax({
			url:'../cart/modifyCart.do',
			type:'post',
			data:{cart_num:$(this).attr('data-cartnum'),
					goods_num:$(this).attr('data-goodsnum'),
					order_quantity:order_quantity,
					mem_num : mem_num
					},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 사용하세요');
				}else if(param.result == 'noSale'){
					alert('판매 중지되었습니다.');
					location.href='goods_cart.do'; //화면 갱신
				}else if(param.result == 'noQuantity'){
					alert('상품의 수량이 부족합니다.');
					location.href='goods_cart.do';
				}else if(param.result == 'success'){
					alert('상품 개수가 수정되었습니다.');
					location.href='goods_cart.do';
				}else{
					alert('장바구니 상품 수량 변경 오류');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});


	/*=================
	 * 장바구니 상품 삭제
     *=================*/
	$('.cart-del').on('click',function(){
		//서버와 통신
		$.ajax({
			url:'../cart/deleteCart.do',
			type:'post',
			data:{cart_num:$(this).attr('data-cartnum')},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 사용하세요!');
				}else if(param.result == 'success'){
					alert('선택한 상품을 삭제했습니다.');
					location.href='goods_cart.do';
				}else{
					alert('장바구니 상품 삭제 오류');
				}
			},
			error:function(){
				alert('네트워크 오류 발생!');
			}
		});
	});
	
	//장바구니 전체 비우기
	$('.deleteCartAll').on('click', function(){
		let mem_num = $('#mem_num').val();
		//서버와 통신
		$.ajax({
			url:'../cart/deleteCartAll.do',
			type:'post',
			data: {mem_num : mem_num},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 사용하세요!');
					location.href='../member/login.do';
				}else if(param.result == 'success'){
					alert('장바구니 비우기 완료');
					location.href='goods_cart.do';
				}else{
					alert('장바구니 상품 삭제 오류');
				}
			},
			error:function(){
				alert('네트워크 오류 발생!');
			}
		});
	});
	
	
});