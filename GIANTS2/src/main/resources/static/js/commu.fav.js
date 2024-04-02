$(function(){
	//좋아요 읽기
	//좋아요 선택 여부 & 선택한 총 개수 표시
	function selectFav(commu_num){
		$.ajax({
			url:'getFav.do',
			type:'post',
			data:{commu_num:commu_num},
			dataType:'json',
			success:function(param){
				displayFav(param);
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	} //end of selectFav
	
	
	//좋아요 등록&삭제
	$('#output_fav').click(function(){
		$.ajax({
			url:'writeFav.do',
			type:'post',
			data:{commu_num:$('#output_fav').attr('data-num')},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 좋아요를 눌러주세요!');
				}else if(param.result == 'success'){
					displayFav(param); //좋아요 표시 공통 함수
				}else{
					alert('등록 시 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	}); //end of click;
	
	
	//좋아요 표시 공통 함수
	function displayFav(param){
		let output;
		if(param.status == 'yesFav'){
			output = '../images/fav02.png';
		}else if(param.status == 'noFav'){
			output = '../images/fav01.png';
		}else{
			alert('좋아요 표시 오류 발생');
		}
		//문서 객체에 추가
		$('#output_fav').attr('src',output);
		$('#output_fcount').text(param.count);
	} //end of displayFav

	
	//초기 데이터 표시
	//#output_fav의 data-num에 넣어놓은 commu_num을 가져와 넣어줌
	selectFav($('#output_fav').attr('data-num'));

});