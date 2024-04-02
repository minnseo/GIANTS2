$(function(){
	let price = Number($('.food-price').attr('data-price'));
	
	
	//수량이 변경될 때 마다 총 금액 및 hidden 값을 모두 변경
	$(document).on('change','#food_quantity',function(){
		changePriceAndTotal($(this).val(),price);
	});
	
	//값을 변경하는 함수
	function changePriceAndTotal(count,foodPrice){
		let total = count*foodPrice;
		
		//겉으로 보이는 총 가격 출력
		$('#food_total').text(function(){
			return Number(total).toLocaleString() + '원';
		});
		
		//hidden값 변경
		$('.fd-quantity').val(count);
		$('.fd-total').val(total);
	}
	
	
	//장바구니 버튼,폼
	$('#food_cart_btn').click(function(){
		
		//ajax 통신을 이용해서 이미 담겨있는 장바구니가 있는지, 다른매장인지 확인
		let form_data = $('#frm_cart').serialize();
		$.ajax({
			url:'../food/foodCartCheck.do',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('해당 기능은 로그인이 필요합니다.');
				}else if(param.result == 'MismatchCompany'){
					//다른매장의 상품이 등록되어있음
					let check = confirm('다른매장의 상품이 담겨있습니다.\n장바구니를 비우고 추가하시겠습니까?');
					if(check){
						//장바구니에 상품 추가
						$.ajax({
							url:'../food/foodAddCart.do',
							type:'post',
							data:form_data,
							dataType:'json',
							beforeSend: function(){
								emptyCart();
							},
							success:function(param){
								if(param.result == 'logout'){
									alert('로그인이 필요한 기능입니다.');
								}else if(param.result == 'success'){
									console.log('상품 추가 완료');
									//페이지 이동용 함수
									moveLink();
								}else{
									alert('장바구니 추가 오류 발생');
								}
							},
							error:function(){
								alert('장바구니 추가 - 네트워크 오류 발생');
							}
						});
						
					}else{//취소를 눌렀을 경우
						alert('장바구니 상품 추가 취소');
					}
					
				}else if(param.result == 'Empty'){
					//상품 추가하기
						$.ajax({
							url:'../food/foodAddCart.do',
							type:'post',
							data:form_data,
							dataType:'json',
							success:function(param){
								if(param.result == 'logout'){
									alert('로그인이 필요한 기능입니다.');
								}else if(param.result == 'success'){
									console.log('상품 추가 완료');
									//페이지 이동용 함수
									moveLink();
								}else{
									alert('장바구니 추가 오류 발생');
								}
							},
							error:function(){
								alert('장바구니 추가 - 네트워크 오류 발생');
							}
						});
						//장바구니에 상품 추가 끝
						
				}else{
					alert('장바구니 체크 오류 발생');
				}
			},
			error:function(){
				alert('장바구니 체크 - 네트워크 오류 발생');
			}
		});//Ajax 끝
		
	});
	
	
	//장바구니 비우기 버튼
	$('.emptyCart').click(function(){
		emptyCart();
	});
	
	
	//장바구니 모두 비우기 함수
	function emptyCart(){
		$.ajax({
			url:'../food/foodEmptyCart.do',
			type:'post',
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인이 필요한 기능입니다.');
				}else if(param.result == 'success'){
					console.log('장바구니 비우기 완료');
				}else{
					alert('장바구니 비우기 오류 발생');
				}
			},
			error:function(){
				alert('장바구니 비우기 - 네트워크 오류 발생');
			}
		});
	}
	
	//장바구니용 페이지 이동 함수
	function moveLink(){
		let choose = confirm('상품을 장바구니에 담았습니다.\n장바구니로 이동할까요?\n(취소시 메뉴목록으로 이동)');
		if(choose){
			//장바구니 페이지로 이동
			location.href='/food/fcart/foodUserCartList.do';
		}else{
			//매장상세로 이동
			location.href='/food/foodCompDetailMenu.do?comp_num=' + $('#comp_number').val();
		}
	}
	
	
	//주문하기 버튼, 폼
	$('#food_order_btn').click(function(){
		
		let form_data = $('#frm_cart').serialize();
		
		$.ajax({
			url:'../food/foodCartCheck.do',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('해당 기능은 로그인이 필요합니다.');
				}else if(param.result == 'MismatchCompany' || param.order == 'NotEmpty'){
					//다른매장의 상품이 등록되어있음
					let check = confirm('장바구니를 비워야 주문이 가능합니다.\n장바구니를 비우고 주문하시겠습니까?');
					if(check){
						//장바구니에 상품 추가
						$.ajax({
							url:'../food/foodAddCart.do',
							type:'post',
							data:form_data,
							dataType:'json',
							beforeSend: function(){
								emptyCart();
							},
							success:function(param2){
								if(param2.result == 'logout'){
									alert('로그인이 필요한 기능입니다.');
								}else if(param2.result == 'success'){
									//폼을 생성하고, cartNumbers를 ajax 통신을 이용하여 뽑아내서 form.submit 수행
									$.ajax({
										url:'../food/selectCartNums.do',
										type:'post',
										dataType:'json',
										success:function(param3){
											if(param3.result == 'logout'){
												alert('로그인이 필요한 기능입니다.');
											}else if(param3.result == 'success'){
												//주문 폼 submit() 수행
												let output = '';
												let list = param3.list;
												for (let i = 0; i < list.length; i++) {
													output += '<input type="hidden" name="cart_numbers" value="'+list[i]+'" >';
												}
												$('#frm_order').append(output);
												$('#frm_order').submit();
											}else{
												alert('주문 폼 생성 오류 발생');
											}
										},
										error:function(){
											alert('주문 폼 생성 - 네트워크 오류 발생');
										}
									});
									
								}else{
									alert('장바구니 추가 오류 발생');
								}
							},
							error:function(){
								alert('장바구니 추가 - 네트워크 오류 발생');
							}
						});
					}else{//취소를 눌렀을 경우
						alert('주문 취소');
					}
				}else if(param.result == 'Empty'){
					//상품 추가하기
						$.ajax({
							url:'../food/foodAddCart.do',
							type:'post',
							data:form_data,
							dataType:'json',
							success:function(param2){
								if(param2.result == 'logout'){
									alert('로그인이 필요한 기능입니다.');
								}else if(param2.result == 'success'){
									//폼을 생성하고, cartNumbers를 ajax 통신을 이용하여 뽑아내서 form.submit 수행
									$.ajax({
										url:'../food/selectCartNums.do',
										type:'post',
										dataType:'json',
										success:function(param3){
											if(param3.result == 'logout'){
												alert('로그인이 필요한 기능입니다.');
											}else if(param3.result == 'success'){
												//주문 폼 submit() 수행
												let output = '';
												let list = param3.list;
												for (let i = 0; i < list.length; i++) {
													output += '<input type="hidden" name="cart_numbers" value="'+list[i]+'" >';
												}
												$('#frm_order').append(output);
												$('#frm_order').submit();
											}else{
												alert('주문 폼 생성 오류 발생');
											}
										},
										error:function(){
											alert('주문 폼 생성 - 네트워크 오류 발생');
										}
									});
								}else{
									alert('장바구니 추가 오류 발생');
								}
							},
							error:function(){
								alert('장바구니 추가 - 네트워크 오류 발생');
							}
						});
						//장바구니에 상품 추가 끝
				}else{
					alert('주문하기 장바구니 체크 오류 발생');
				}
			},
			error:function(){
				alert('주문하기 장바구니 체크 - 네트워크 오류 발생');
			}
		});//Ajax 끝
	});

	
	//초기 화면
	changePriceAndTotal(1,price);
});













