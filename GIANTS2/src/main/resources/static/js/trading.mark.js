$(function(){
	//북마크 읽기
	//북마크 선택 여부와 선택한 총 개수 표시
	function selectMark(trade_num){
		$.ajax({
			url:'getMark.do',
			type:'post',
			data:{trade_num:trade_num},
			dataType:'json', //JSON 타입으로 해야 객체 형태로 처리 가능
			success:function(param){
				displayMark(param);
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	} //end of selectMark
	
	//북마크 등록/삭제
	$('#output_mark').click(function(){
		$.ajax({
			url:'writeMark.do',
			type:'post',
			data:{trade_num:$('#output_mark').attr('data-num')},
			dataType:'json', 
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 관심목록을 추가해주세요!');
				} else if(param.result == 'success'){
					displayMark(param);
				} else{
					alert('등록 시 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	}); //end of click
	
	//북마크 표시 공통 함수
	function displayMark(param){
		let output;
		if(param.status == 'yesMark'){
			output = '../images/bookmark2.png';
		} else if(param.status == 'noMark'){
			output = '../images/bookmark1.png';
		} else{
			alert('북마크 표시 오류 발생');
		}
		//문서 객체에 추가
		$('#output_mark').attr('src', output);
		$('#output_markcnt').text(param.count);
	} //end of displayMark
	
	//초기 데이터 표시
	selectMark($('#output_mark').attr('data-num'));
});