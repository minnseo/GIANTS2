$(function(){
	//장바구니 비우기 버튼
	$('.emptyCart').click(function(){
		emptyCart();
		location.href="/food/fcart/foodUserCartList.do";
	});
	
	
	//장바구니 모두 비우기 함수
	function emptyCart(){
		$.ajax({
			url:'../../food/foodEmptyCart.do',
			type:'post',
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인이 필요한 기능입니다.');
				}else if(param.result == 'success'){
					alert('장바구니를 모두 비웠습니다.');
					location.reload();
				}else{
					alert('장바구니 비우기 오류 발생');
				}
			},
			error:function(){
				alert('장바구니 비우기 - 네트워크 오류 발생');
			}
		});
	}
	
	//삭제 버튼을 클릭할 경우에 장바구니에서 아이템 삭제
	$(document).on('click','.del-choice',function(){
		let check = confirm("상품을 장바구니에서 삭제하시겠습니까?");
		//해당 아이템의 장바구니번호 값을 가져옴
		let cnum = $(this).closest('td').find('.del-choice').val();
		if(check){
			$.ajax({
				url:'deleteOneCart.do',
				type:'post',
				data:{cart_num:cnum},
				dataType:'json',
				success:function(param){
					if(param.result == 'logout'){
						alert('로그인이 필요한 기능입니다.');
					}else if(param.result == 'success'){
						alert('삭제완료.\n목록을 다시 불러옵니다.');
						location.href="/food/fcart/foodUserCartList.do";
					}else{
						alert('식품 삭제 오류 발생');
					}
				},
				error:function(){
					alert('식품 삭제 - 네트워크 오류 발생');
				}
			});
		}else{
			alert("삭제 취소")
		}
	});
	
	//변경 버튼 submit
	$(document).on('click','.change-count',function(){
		let cnum = $(this).closest('td').find('input[type="number"]').val();
		let fnum = $(this).closest('td').find('input[type="hidden"]').val();
		let cartNum = $(this).val();
		$.ajax({
			url:'changeCartQuantity.do',
			type:'post',
			data:{cart_num:cartNum, f_cart_quantity:cnum, food_num:fnum},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인이 필요한 기능입니다.');
				}else if(param.result == 'stopSell'){
					alert('현재 판매중지 상품입니다.');
					alert('상품을 장바구니에서 제거합니다.');
					$.ajax({
						url:'deleteOneCart.do',
						type:'post',
						data:{cart_num:cnum},
						dataType:'json',
						success:function(param){
							if(param.result == 'logout'){
								alert('로그인이 필요한 기능입니다.');
							}else if(param.result == 'success'){
								alert('삭제완료.\n목록을 다시 불러옵니다.');
								location.href="/food/fcart/foodUserCartList.do";
							}else{
								alert('식품 삭제 오류 발생');
							}
						},
						error:function(){
							alert('식품 삭제 - 네트워크 오류 발생');
						}
					});
				}else if(param.result == 'noQuantity'){
					alert('선택하신 수량이 재고수량보다 많습니다.');
					location.href="/food/fcart/foodUserCartList.do";
				}else if(param.result == 'success'){
					location.href="/food/fcart/foodUserCartList.do";
				}else{
					alert('수량 변경 오류 발생');
				}
			},
			error:function(){
				alert('수량 변경 - 네트워크 오류 발생');
			}
		});
	});
	
	//체크박스
	//all_chk, food-chk, total_price
	$(document).on('click','#all_chk',function(){
		let check = $(this).is(':checked');
		if(check){
			//체크 되어 있을 경우에 - true
			$('.food-chk').prop('checked',true);
		}else{
			//체크 상태가 아니라면 - false
			$('.food-chk').prop('checked',false);
		}
		changeTotalPrice();
		changeFormData();
	});
	
	//개별 체크박스에 반응하여 총 금액을 출력 + all_chk 박스
	$(document).on('change','.food-chk',function(){
		let size = $('.food-chk').get().length;
		let result = 0;
		for (const foodItem of $('.food-chk')) {
			if (foodItem.checked) {
				result++;
			}
		}
		if(size===result){
			$('#all_chk').prop('checked',true);
		}else{
			$('#all_chk').prop('checked',false);
		}
		changeTotalPrice();
		changeFormData();
	});
	
	//쇼핑계속하기 버튼
	$(document).on('click','#go_foodList',function(){
		location.href='/food/foodList.do';
	});
	
	//전체상품주문 버튼
	$(document).on('click','#all_order',function(){
		let form = $('#all_frm');
		//비어있는지 확인
		if(form.html()===''){
			alert('주문할 상품이 없습니다.');
			return;
		}
		form.submit();
	});
	
	//선택상품주문 버튼
	$(document).on('click','#sel_order',function(){
		let form = $('#sel_frm');
		if(form.html()==='' || $(form).children('input[name="total_price"]').val()==0){
			alert('주문할 상품이 없습니다.');
			return;
		}
		form.submit();
	});
	
	//체크박스에 따른 Form 히든 값 반영 함수
	function changeFormData(){
		let sum = 0;
		let output='';
		for (const foodItem of $('.food-chk')) {
			if (foodItem.checked) {
				sum += Number(foodItem.dataset.hiddenPrice);
				const cartNumber = $(foodItem).closest('td').find('input[type="hidden"]').val();
      			output += '<input type="hidden" name="cart_numbers" value="'+cartNumber+'">';
			}
		}
		output += '<input type="hidden" name="total_price" value="' + sum + '">';
		$('#sel_frm').empty();
		$('#sel_frm').append(output);
	}
	
	//총 금액 반영 함수
	function changeTotalPrice(){
		let sum = 0;
		for (const foodItem of $('.food-chk')) {
			if (foodItem.checked) {
				sum += Number(foodItem.dataset.hiddenPrice);
			}
		}
		$('#total_price').empty();
		$('#total_price').text(Number(sum).toLocaleString());
	}
	
	//모든 상품의 가격 히든 태그
	function hiddenTotal_Price(){
		let sum = 0;
		for (const foodItem of $('.food-chk')) {
			sum += Number(foodItem.dataset.hiddenPrice);
		}
		let output = '<input type="hidden" name="total_price" value="' + sum + '">';
		$('#all_frm').append(output);
	}
	
	
	//초기 출력
	changeTotalPrice();
	changeFormData();
	hiddenTotal_Price();
});













