$(function(){
	
	/*==========================
	 * 회원 주소 읽기(배송지 지정)
     *==========================*/
	$('#member_address').click(function(){
		//서버와 통신
		$.ajax({
			url:'../gorder/getMemberAddress.do',
			type:'get',
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 회원 주소를 읽어올 수 있습니다.');
				}else if(param.result == 'success'){
					$('#zipcode').val(param.zipcode);
					$('#address1').val(param.address1);
					$('#address2').val(param.address2);
					$('#mem_phone').val(param.phone);
				}else{
					alert('회원 주소 읽기 오류');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
		
	});
	//포인트 전액 사용 클릭 시 - 결제 금액보다 크면 안됨
	$('#point-btn').click(function(){
		$.ajax({
			url : '../gorder/getMemberPoint.do', 
			type : 'get', 
			dataType : 'json', 
			success : function(param){
				if(param.result=='logout'){
					alert('로그인 후 회원 포인트를 읽어올 수 있습니다');
				} else if(param.result=='success'){
					$('#used_point').val(param.mem_point);
				} else{
					alert('회원 보유 포인트 읽기 오류');
				}
			}, error : function(){
				alert('네트워크 오류 발생');
			}
			
			
		}); //end ajax
	})
	//포인트 사용 - 적용버튼 클릭 시 
	$('#usingPoint').click(function(){
		var resultAllTotal = parseInt($('#all_total_result').text().replace(/,/g, '')); //<em>태그의 값은 text로 가져올 수 있음, 계산작업을 위해 int형으로 반환하고 포맷넘버로 , 이후로 값을 못읽어오므로 처리
		var usedPointValue = parseInt($("#used_point").val());
		var newResultTotal = resultAllTotal - usedPointValue;
		console.log("usedPointValue:", usedPointValue);
		console.log("resultAllTotal:", resultAllTotal);
		$.ajax({
			url : '../gorder/usingMemberPoint.do', 
			type : 'get', 
			dataType : 'json', 
			data : {'allTotal' : resultAllTotal, 'usedPoint' : usedPointValue},
			success : function(param){
				if(param.result=='littlePoint'){
					alert('포인트 사용은 1p부터 가능합니다');
					$("#used_point").val('');
				} 
				else if(param.result=='overPoint'){
					alert('포인트 사용은 결제 금액보다 클 수 없습니다');
					$("#used_point").val('');
				}
				else if(param.result=='underPoint'){
					alert('포인트는 1p 이상부터 사용가능합니다');
					$("#used_point").val('');
				}
				else if(param.result=='lackPoint'){
					alert('포인트가 부족합니다');
					$("#used_point").val('');
				}
				
				else if(param.result=='success'){
					$('#used-point-result').html(usedPointValue +"p"); //사용한 포인트를 적용	
					//보유 포인트를 0으로 변경	
					$('#all_total_result').html(newResultTotal.toLocaleString() + "원");		
					$("#used_point").attr("disabled", true); // 입력 필드 비활성화
               		$("#usingPoint").attr("disabled", true).css({
				    backgroundColor: "gray",
				    color: "white",
				    cursor: "not-allowed"
					}); // 적용 버튼 비활성화			
				} else{
					alert('회원 보유 포인트 읽기 오류');
				}
			}, error : function(){
				alert('네트워크 오류 발생');
			}
			
		}); //end ajax
		
	})
		
	//포인트 사용 취소
	$('#cancelPoint').click(function(){
		var resultAllTotal = parseInt($('#all_total_result').text().replace(/,/g, '')); //<em>태그의 값은 text로 가져올 수 있음, 계산작업을 위해 int형으로 반환하고 포맷넘버로 , 이후로 값을 못읽어오므로 처리
		var usedPointValue = parseInt($("#used_point").val());
		var newResultTotal = resultAllTotal + usedPointValue; //빼준 포인트를 다시 더해서 원래 값으로 적용
		$.ajax({
			url : '../gorder/cancelMemberPoint.do', 
			type : 'get', 
			data : {usedPoint: usedPointValue}, //controller로 전송
			dataType : 'json', 
			success : function(param){
				if(param.result=='littlePoint'){
					alert('적용된 포인트가 없습니다');
				} else if(param.result='success'){
					$('#used-point-result').html('0p'); //사용 포인트를 다시 0으로 돌려줌
					$('#all_total_result').html(newResultTotal.toLocaleString() + '원');	
					$('#used_point').val('0');
					$("#used_point").attr("disabled", false); //활성화
               		$("#usingPoint").attr("disabled", false).css({
				    backgroundColor: "#052345",
				    color: "white",
				    cursor: "allowed"
					}); 
				} else{
					alert('포인트 적용 취소 오류');
				}
			}, error : function(){
				alert('네트워크 오류 발생');
			}
			
		}); //end ajax
		
	})
		
		
	
	
	
	
	
	
	
	
	
	
	
	
	
});