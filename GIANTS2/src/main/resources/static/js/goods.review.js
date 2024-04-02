$(function(){
	//페이지와 관련된 정보를 가지는 변수
	let pageSize = 5;//화면에 보여줄 레코드 수 = rowCount
	let pageBlock = 5;//페이지 표시 단위
	let currentPage =1;//현재 보고 있는 화면
	let totalItem;//총 레코드 수
	
	function reviewList(currentPage, dataPerPage){
		$.ajax({
			url:'reviewList.do',
			type:'post',
			data:{goods_num:$('#goods_num').val(), currentPage:currentPage, rowCount:pageSize},
			dataType:'json',
			success:function(param){
				currentPage = Number(currentPage);
				
				console.log('currentPage-' + currentPage);
				
				dataPerPage = 5;
				dataPerPage = Number(dataPerPage);
				
				$('#review_output').empty();
				let a = '';
				
				if(param.count <= 0){
					a += '<span>작성된 리뷰가 없습니다.</span>';
				}
				
				else{
					
					let list = param.list;
					
					a += '<table class="detail-tb align-center">';
					a += '<tr>';
					a += '<th style="width:10%;">별점</th>';
					a += '<th>제목</th>';
					a += '<th style="width:13%;">작성자ID</th>';
					a += '<th style="width:12%;">등록일</th>';
					a += '</tr>';
									
					$.each(list, function(index, value){
						a += '<tr>';
						a += '<td>';
						if(value.review_score == 5){
							a += '★★★★★(5)';
						} else if(value.review_score == 4){
							a += '★★★★(4)';
						} else if(value.review_score == 3){
							a += '★★★(3)';
						} else if(value.review_score == 2){
							a += '★★(2)';
						} else if(value.review_score == 1){
							a += '★(1)';
						}
						a += '</td>';
						
						a += '<td class="re-title" id="title' + index + '" style="cursor:pointer;">' + value.review_title + '</td>';
						a += '<td>' + value.mem_id + '</td>';
						a += '<td>' + value.review_regdate + '</td>';
						a += '</tr>';
						
						a += '<tr class="re-content" id="content' + index + '" style="display:none;">';
						a += '<td colspan="5" class="show-content" id="td'+index+'">';
						a += '<div class="align-right" style="margin:5px 5px 0 0; height:50px;">';
						a += ' <input type="button" value="닫기" id="close_this">';
						if(param.user_num == value.mem_num){
							a += ' <input type="button" value="수정" class="modify-btn" data-num="' + value.review_num + '">';
							a += ' <input type="button" value="삭제" class="delete-btn" data-num="' + value.review_num + '">';
						}
						a += '</div>';  
						
						a += '<div class="align-left" style="margin-left:10px;">';
						if(value.review_photoname != null){
							a += '<img src="../goods/imageView2.do?review_num=' + value.review_num + '" height="300"><br>';
						}
						a += value.review_content + '</div>';
						a += '</td>';
						a += '</tr>';
					}); //end of each
					
					
					a += '</table>';
					
					//페이지 번호 호출
					setPage();
				}
				$('#review_output').append(a);
				
			},
			error:function(){
				alert('네트워크 오류 발생!');
			}
		}); //end of ajax
	}
	
	//페이지 설정
	function setPage(){
		$.ajax({
			url:'reviewListCountAjax.do',
			type:'post',
			data:{goods_num:$('#goods_num').val(), rowCount:pageSize, currentPage:currentPage},
			dataType:'json',
			success:function(data){
				if(data.result == 'success'){
					//ul 태그 초기화
					$('#review_page').empty();
					totalItem = data.count;
					if(totalItem == 0){
						return;
					}
					
					var totalPage = Math.ceil(totalItem/pageSize);
					
					if(currentPage == undefined || currentPage == ''){
						currentPage = 1;
					}
					//현재 페이지가 전체 페이지 수보다 크면 전체 페이지수로 설정
					if(currentPage > totalPage){
						currentPage = totalPage;
					}
						
					//시작 페이지와 마지막 페이지 값을 구하기
					var startPage = Math.floor((currentPage-1)/pageBlock)*pageBlock + 1;
					var endPage = startPage + pageBlock - 1;
						
					//마지막 페이지가 전체 페이지 수보다 크면 전체 페이지 수로 설정
					if(endPage > totalPage){
						endPage = totalPage;
					}
						
					var add='';
					if(startPage>pageBlock){
						add += '<li data-page='+(startPage-1)+' style="cursor:pointer;">[이전]</li>';
					}
						
					for(var i=startPage;i<=endPage;i++){
						add += '<li data-page='+i+' style="cursor:pointer;">'+i+'</li>';
					}
					if(endPage < totalPage){
						add += '<li data-page='+(startPage+pageBlock)+' style="cursor:pointer;">[다음]</li>';;
					}
					//ul 태그에 생성한 li를 추가
					$('#review_page').append(add);
					
					console.log('currentPage' + currentPage);
					
				}else{
					alert('오류발생!');
				}
				console.log(currentPage);
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		}); //end of ajax
	}
	
	//페이지 버튼 이벤트 연결
	$(document).on('click','#review_page li',function(){
		//페이지 번호를 읽어들임
		currentPage = $(this).attr('data-page');
		//목록 호출
		reviewList(currentPage, pageSize);
	});
	
	//리뷰 내용 접었다 피기
	$(document).on('click', '.re-title', function(){
		let num = $(this).attr('id').substring(5);
		
		if($('#content' + num).css('display') == 'none'){
			$('#content' + num).show();
		}
	}); //end of re-title
				
	$(document).on('click', '#close_this', function(){
		let tmp = $(this).parent();
		tmp = $(tmp).parent();
		let target = $(tmp).parent();
		$(target).hide();
	}); //end of close_this
	
	//리뷰 삭제 버튼
	$(document).on('click', '.delete-btn', function(){
		let review_num = $(this).attr('data-num');
		
		let choice = confirm('삭제하시겠습니까?');
		
		if(choice){
			location.replace('deleteReview.do?review_num=' + review_num);
		}
	}); //end of delete-btn
	
	//리뷰 수정 버튼
	$(document).on('click', '.modify-btn', function(){
		let review_num = $(this).attr('data-num');
		
		location.href = 'updateReview.do?review_num=' + review_num;
	}); //end of modify-btn
	
	//초기 세팅
	reviewList(1, pageSize);
	
});