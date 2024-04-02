$(function(){
	//찜하기 읽기
	//찜하기 선택 여부와 선택한 총 갯수 표시
	function selectFav(goods_num){
		$.ajax({
			url:'getFav.do',
			type:'post',
			data:{goods_num:goods_num},
			dataType:'json',
			success:function(param){
				displayFav(param);
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		}); //end of ajax
	} //end of selectFav
	
	//찜하기 등록 | 삭제
	$('#fav_btn').click(function(){
		$.ajax({
			url:'writeFav.do',
			type:'post',
			data:{goods_num:$('#fav_btn').attr('data-num')},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 찜하기 기능 이용이 가능합니다.');
				}else if(param.result == 'success'){
					displayFav(param);
				}else{
					alert('찜하기 등록 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		}); //end of ajax
	}); //end of fav_btn click
	
	//찜하기 표시 공통 함수
	function displayFav(param){
		let output;
		if(param.status == 'yesFav'){
			output = '../images/yesFav.png';
		}else if(param.status == 'noFav'){
			output = '../images/noFav.png';
		}else{
			alert('찜하기 표시 오류 발생');
		}
		//문서 객체에 정보 추가
		$('#fav_btn').attr('src', output);
		$('#output_fcount').text(param.count);
	} //end of displayFav
	
	//초기 데이터 표시
	selectFav($('#fav_btn').attr('data-num'));	
});