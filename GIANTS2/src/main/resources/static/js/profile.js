$(function(){
	//MyPage 프로필 사진 등록 및 수정
	//수정 버튼 이벤트 처리
	$('#photo_btn').click(function(){
		$('#photo_choice').show();
		$(this).hide();
	});
	
	//처음 화면에 보여지는 이미지 읽기
	let photo_path = $('.my-photo').attr('src');
	let my_photo; //업로드하고자 선택한이미지 저장
	$('#upload').change(function(){
		my_photo = this.files[0];
		if(!my_photo){	
			$('.my_photo').attr('src',photo_path);
			return;
		}
		
		if(my_photo.size > 1024*1024){ //용량체크
			alert(Math.round(my_photo.size/1024) 
			+ 'kbytes(1024kbytes까지만 업로드 가능)');
			$('.my-photo').attr('src',photo_path);
			$(this).val('');
			return;
		}
		
		//이미지 미리보기 처리
		let reader = new FileReader();
		reader.readAsDataURL(my_photo);
		
		reader.onload=function(){
			$('.my-photo').attr('src',reader.result);
		}
	})	
	
	//파일 업로드 처리
	$('#photo_submit').click(function(){
		if($('#upload').val()==''){
			alert('파일을 선택하세요');
			$('#upload').focus();
			return;
		}
		
		//서버에 파일 전송
		let form_data = new FormData();
		form_data.append('upload',$('#upload')[0].files[0]);
		$.ajax({
			url:'../member/updateMyPhoto.do',
			type:'post',
			data:form_data,
			dataType:'json',
			contentType:false,
			processData:false,
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 사용하세요');
				}else if(param.result == 'success'){
					alert('프로필 사진이 수정되었습니다.');
					//교체된 이미지 저장
					photo_path=$('.my-photo').attr('src');
					$('#upload').val('');
					$('#photo_choice').hide();
					$('#photo_btn').show();
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});//end of click
	
	//취소 버튼 처리
	$('#photo_reset').click(function(){
		$('.my-photo').attr('src',photo_path);
		$('#upload').val('');
		$('#photo_choice').hide();
		$('#photo_btn').show();
	});
});