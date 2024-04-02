$(function(){
	//페이지와 관련된 정보를 가지는 변수
	let pageSize = 5;//화면에 보여줄 레코드 수 = rowCount
	let pageBlock = 5;//페이지 표시 단위
	let currentPage =1;//현재 보고 있는 화면
	let totalItem;//총 레코드 수
	
	function qnaList(currentPage, dataPerPage){
		$.ajax({
			url:'qnaList.do',
			type:'post',
			data:{goods_num:$('#goods_num').val(), currentPage:currentPage, rowCount:pageSize},
			dataType:'json',
			success:function(param){
				currentPage = Number(currentPage);
				
				dataPerPage = 5;
				dataPerPage = Number(dataPerPage);
				
				$('#qna_output').empty();
				let a = '';
				
				if(param.count <= 0){
					a += '<span>작성된 리뷰가 없습니다.</span>';
				}
				
				else{
					let list = param.list;
					
					a += '<table class="detail-tb align-center">';
					a += '<tr>';
					a += '<th style="width:10%;">번호</th>';
					a += '<th>제목</th>';
					a += '<th style="width:13%;">작성자ID</th>';
					a += '<th style="width:12%;">등록일</th>';
					a += '<th style="width:12%;">처리상태</th>';
					a += '</tr>';
									
					$.each(list, function(index, value){
						a += '<tr>';
						a += '<td>' + value.qna_num +'</td>';
						
						a += '<td style="cursor:pointer;">';
						a += '<a href="detailQna.do?qna_num=' + value.qna_num + '">';
						a += value.qna_title + '</a></td>'
						
						a += '<td>' + value.mem_id + '</td>';
						a += '<td>' + value.qna_regdate + '</td>';
						
						if(value.qna_status == 1){
							a += '<td>처리전</td>';
						} else if(value.qna_status == 2){
							a += '<td><b style="color: #0000FF;">답변완료</b></td>';
						}
						
						a += '</tr>';
					}); //end of each
					
					a += '</table>';
					
					//페이지 번호 호출
					setPage();
				}
				$('#qna_output').append(a);
				
			},
			error:function(){
				alert('네트워크 오류 발생!');
			}
		}); //end of ajax
	}
	
	//페이지 설정
	function setPage(){
		$.ajax({
			url:'qnaListCountAjax.do',
			type:'post',
			data:{goods_num:$('#goods_num').val(), rowCount:pageSize, currentPage:currentPage},
			dataType:'json',
			success:function(data){
				if(data.result == 'success'){
					//ul 태그 초기화
					$('#qna_page').empty();
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
					$('#qna_page').append(add);
					
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
	$(document).on('click','#qna_page li',function(){
		//페이지 번호를 읽어들임
		currentPage = $(this).attr('data-page');
		//목록 호출
		qnaList(currentPage, pageSize);
	});
	
	//초기 세팅
	qnaList(1, pageSize);
	
});