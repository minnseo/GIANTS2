$(function(){
	//상품 카테고리 선택시 상품 옵션 보이게
	$('#goods_category').click(function(){
		getCategory();
	}); //end of goods_category click
	
	$('#goods_price').on('keyup mouseup', function(){
		$('#goods_dprice').val($('#goods_price').val());
		$('#goods_disc').val(0);
	}); //end of goods_price
	
	$('#goods_disc').on('keyup mouseup', function(){
		let dprice = $('#goods_price').val() * (1 - $('#goods_disc').val()/100);
		$('#goods_dprice').val(dprice);
	}); //end of goods_price
	
	function getCategory(){
		if($('#goods_category').val() == 1){
			$('.hasSize').show();
			$('.hasNoSize').remove();
		} else if($('#goods_category').val() > 1){
			$('.hasSize').remove();
			$('.hasNoSize').show();
		} else if($('#goods_category').val() < 1){
			$('.hasSize').hide();
			$('.hasNoSize').hide();
		}
	}
	
	$('#goods_stock1').on('keyup mouseup', function(){
		if($('#goods_stock1').val() == ''){
			$('#stock_msg1').text('수량 필수 입력. 0 ~ 9999999 사이의 숫자만 입력.');
			return;
		} else if($('#goods_stock1').val() < 0 || $('#goods_stock1').val() > 9999999){
			$('#stock_msg1').text('수량 필수 입력. 0 ~ 9999999 사이의 숫자만 입력.');
			$('#goods_stock1').val('');
			return;
		} else{
			$('#stock_msg1').text('');
		}
	});
	
	$('#goods_stock2').on('keyup mouseup', function(){
		if($('#goods_stock2').val() == ''){
			$('#stock_msg2').text('수량 필수 입력. 0 ~ 9999999 사이의 숫자만 입력.');
			return;
		} else if($('#goods_stock2').val() < 0 || $('#goods_stock2').val() > 9999999){
			$('#stock_msg2').text('수량 필수 입력. 0 ~ 9999999 사이의 숫자만 입력.');
			$('#goods_stock2').val('');
			return;
		}else{
			$('#stock_msg2').text('');
		}
	});
	
	$('#goods_stock3').on('keyup mouseup', function(){
		if($('#goods_stock3').val() == ''){
			$('#stock_msg3').text('수량 필수 입력. 0 ~ 9999999 사이의 숫자만 입력.');
			return;
		} else if($('#goods_stock3').val() < 0 || $('#goods_stock3').val() > 9999999){
			$('#stock_msg3').text('수량 필수 입력. 0 ~ 9999999 사이의 숫자만 입력.');
			$('#goods_stock3').val('');
			return;
		} else{
			$('#stock_msg3').text('');
		}
	});
	
	$('#goods_stock4').on('keyup mouseup', function(){
		if($('#goods_stock4').val() == ''){
			$('#stock_msg4').text('수량 필수 입력. 0 ~ 9999999 사이의 숫자만 입력.');
			return;
		} else if($('#goods_stock4').val() < 0 || $('#goods_stock4').val() > 9999999){
			$('#stock_msg4').text('수량 필수 입력. 0 ~ 9999999 사이의 숫자만 입력.');
			$('#goods_stock4').val('');
			return;
		} else{
			$('#stock_msg4').text('');
		}
	});
	
	$('#goods_stock5').on('keyup mouseup', function(){
		if($('#goods_stock5').val() == ''){
			$('#stock_msg5').text('수량 필수 입력. 0 ~ 9999999 사이의 숫자만 입력.');
			return;
		} else if($('#goods_stock5').val() < 0 || $('#goods_stock5').val() > 9999999){
			$('#stock_msg5').text('수량 필수 입력. 0 ~ 9999999 사이의 숫자만 입력.');
			$('#goods_stock5').val('');
			return;
		} else{
			$('#stock_msg3').text('');
		}
	});
	
	$('#goods_stock6').on('keydown mouseup', function(){
		if($('#goods_stock6').val() == ''){
			$('#stock_msg6').text('수량 필수 입력. 0 ~ 9999999 사이의 숫자만 입력.');
			return;
		} else if($('#goods_stock6').val() < 0 || $('#goods_stock6').val() > 9999999){
			$('#stock_msg6').text('수량 필수 입력. 0 ~ 9999999 사이의 숫자만 입력.');
			$('#goods_stock6').val('');
			return;
		} else{
			$('#stock_msg6').text('');
		}
	});
	
	$('#goods_stock7').on('keyup mouseup', function(){
		if($('#goods_stock7').val() == ''){
			$('#stock_msg7').text('수량 필수 입력. 0 ~ 9999999 사이의 숫자만 입력.');
			return;
		} else if($('#goods_stock7').val() < 0 || $('#goods_stock7').val() > 9999999){
			$('#stock_msg7').text('수량 필수 입력. 0 ~ 9999999 사이의 숫자만 입력.');
			$('#goods_stock7').val('');
			return;
		} else{
			$('#stock_msg7').text('');
		}
	});

	
	getCategory();
	
});