<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 상품 구매 시작 -->
<!-- list, all_total 가져옴 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/LYJ/orderForm.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/LYJ/cart.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/goods_order_form.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<style>
.btn-api{
	background-color : #dd032f;
	color : white;
	width: 1200px;
	height: 30px;
	border : none;
}
.btn-account{
background-color : #dd032f;
	color : white;
	width: 1200px;
	height: 30px;
	border : none;

}
</style>
<div class="page-main">
		<h3>주문 리스트</h3>
		<hr size="1">
		<br>
		
		 <table class="basic-table">
			<tr>
				<th>사진</th>
				<th>상품정보</th>
				<th>판매가</th>
				<th>수량</th>
				<th>적립</th>
				<th>합계</th>
			</tr>
			<c:set var="totalOrderPoint" value="0" /> <!-- 합계를 저장할 변수 초기화 -->
			<c:forEach var="cart" items="${list}">
				<tr>
					<td>
						<a href="${pageContext.request.contextPath}/goods/goodsDetail.do?goods_num=${cart.goods_num}">
							<img src="${pageContext.request.contextPath}/goods/imageView.do?goods_num=${cart.goods_num}" width="80" height="80">
						</a>
					</td>
					<td>
							${cart.goodsVO.goods_name}
					</td>
					<td class="align-center">
						<span class="goods-price" data-price="${cart.goodsVO.goods_dprice}"><fmt:formatNumber value="${cart.goodsVO.goods_dprice}"/>원</span>
					</td>
					
					<td class = "align-center">
						${cart.order_quantity}
					</td>
					<td>
						${cart.order_point}p
					</td>
					
					<td class="align-center">
						<div class="sub-total" data-total="${cart.sub_total}">
						<fmt:formatNumber value="${cart.sub_total}"/>원
						<br>
						</div>
					</td>					
					<c:if test="${cart.goods_size!='옵션없음'}">
						<tr class="option-tr">
						    <td colspan="6"><span>⤷</span> <img src="${pageContext.request.contextPath}/images/btn_order_option.gif" alt="옵션" title="옵션">
						    <span>사이즈 : ${cart.goods_size}</span>
						    </td>
						</tr>

					</c:if>
				</tr>
				
				<c:set var="totalOrderPoint" value="${totalOrderPoint + cart.order_point}" /> <!-- 상품 여러개인 경우 합산 -->
				</c:forEach>		
				<tr class="all_total">
					<td colspan="5" class="align-right"><b>총구매금액</b></td>
					<td class="align-center"><span class="all-total" data-alltotal="${all_total}"><fmt:formatNumber value="${all_total}"/>원</span></td>
				</tr>
				
				<tr>
					<td colspan="5" class="align-right"><b>예정 적립 포인트</b></td>
					<td class="align-center"><span class="all-total"> ${totalOrderPoint}p</span></td>
				</tr>
		
		</table>  
		<br>
		<br>
		<h3>포인트적용</h3> <!-- 전액 사용 버튼을 누르거나 직접 입력해서 적용버튼 누르면 차감되도록 -->
		<hr size="1">
			잔여포인트 : ${mem_point}p   <input type="button" value="전액사용" id="point-btn" class="default-btn">
			<br>
			<input type="number" id="used_point" name="used_point" min=1 max="${mem_point}">원  
			<input type="button" value="적용" id="usingPoint">
			<input type="button" value="취소" id="cancelPoint">
		<br>
		<br>
		
		<!-- 주문금액 + 배송비 - 사용포인트 = 결제금액, 하단에 5만원 이상 결제 시 무료배송 -->
		<div class="order-info">
			<div class="order-dprice">
			<h2>주문금액</h2>
			<p>
				<em class="em-highlight"><fmt:formatNumber value="${all_total}"/>원 
					<span id="operator"><img src="${pageContext.request.contextPath}/images/order-plus.png" width="30"></span>
				</em>
				</p>
			</div>
			
			<div class="order-dcostt">
			<h2>배송비</h2>
			<p>
				<em class="em-highlight" id="order-dcost">
					<c:if test="${all_total >= 50000}">
						0원
						<input type="hidden" value="0" name="order_dcost" id="order_dcost">

					</c:if>
					<c:if test="${all_total<50000}">
						3,000원
						<input type="hidden" value="3000" name="order_dcost" id="order_dcost">
					</c:if>
				</em>
				
				</p>
			</div>
			<span id="operator"><img src="${pageContext.request.contextPath}/images/order-minus.png" width="30"></span>
			<div class="order-use-point">
			<h2>사용포인트</h2>
			<p>
				<em class="em-highlight" id="used-point-result"> 0p</em><!-- usedpoint -->
				</p>
			</div>
			<span id="operator"><img src="${pageContext.request.contextPath}/images/order-equals.png" width="30"></span>
			
			
			<c:set var="allTotalAndDcost">
			    <c:choose>
			        <c:when test="${all_total >= 50000}">
			            ${all_total}
			        </c:when>
			        <c:otherwise>
			            ${all_total + 3000}
			        </c:otherwise>
			    </c:choose>
			</c:set>

			<div class="order-final-price">
			<h2>결제금액</h2> 
				<p> 
				<em class="em-highlight-result" id="all_total_result"><fmt:formatNumber value="${allTotalAndDcost}"/>원</em>
				</p>
			</div>
		</div>
		<span class="annot">5만원 이상 결제 시 무료배송입니다.</span>
		
		<br>
		<br>
		
		<h3>배송정보</h3>
		<hr size="1">
		<br>
		<ul>
			<li>
				<label for="receive_name">받는 사람</label>
				<input type="text" name="receive_name" id="receive_name">
				<input type="button" value="회원주소사용" id="member_address" class="default-btn"> <!-- 회원 가입 시 입력했던 정보 가져오기 -->
			</li>
			<li>
				<label for="zipcode">우편번호</label>
				<input type="text" name="order_zipcode" id="zipcode" maxlength="10" readonly="readonly">
				<input type="button" onclick="execDaumPostcode()"
				            value="우편번호 찾기" class="default-btn"> 
			</li>
			<li>
				<label for="address1">주소</label>
				<input type="text" name="order_address1" id="address1" maxlength="30">
			</li>
			<li>
				<label for="address2">상세주소</label>
				<input type="text" name = "order_address2" id="address2" maxlength="30">
			</li>
			<li>
				<label for="mem_phone">전화번호</label>
				<input type="text" maxlength="15" name="mem_phone" id="mem_phone">
			</li>
			<li>
				<label for="order_message">남기실 말씀</label>
				<input type="text" name="order_message" id="order_message">
			</li>
			
		</ul>	
		
		
		
		<h3>결제 정보</h3>
		<hr size="1">
		입금자명 <input type="text" id="order_name"> 
		
		
		<br>
		
		<h3>결제수단</h3>
		<hr size="1">
		<li>	<!-- 통장입금 radio  버튼 누르면 계좌번호 보이도록 처리-->
			<input type="radio" path="order_payment" id="payment1" value="2">무통장입금 <!-- 무통장이면 결제 정보에서 쓴 이름 가져옴 -->
			<input type="radio" path="order_payment" id="payment2" value="1">카드결제                
		</li>
		
		<div id="bankInfo" style="display: none;">
			<select>
				<option class="align-center">====3시간 이내로 입금하지 않으면 자동취소됩니다.====</option>
				<option class="align-center">(국민)123-1234-1234 자이언트</option>
			</select>
			<br>
			<br>
			<div class="align-center">
			<button class="btn-account">주문하기</button>
			</div>
		</div>
		<script type="text/javascript">
		//=================radio 버튼 처리 시작=================
		const payment1Radio = document.getElementById('payment1');
	    const payment2Radio = document.getElementById('payment2');
	    const bankInfoDiv = document.getElementById('bankInfo');
	    const payInfoDiv = document.getElementById('payInfo');
	    
	    let payment1Checked = false; // 무통장입금 라디오 버튼의 상태
	 // 무통장입금 라디오 버튼이 선택되었을 때
		payment1Radio.addEventListener('change', function() {
		    if (this.checked) {
		        bankInfoDiv.style.display = 'block';
		        payInfoDiv.style.display = 'none';
		        payment1Checked = true;
		        payment2Radio.checked = false;
		    } else {
		        // 계좌번호 <div> 요소를 숨김
		        bankInfoDiv.style.display = 'none';
		        payment1Checked = false;
		    }
		});

		 payment2Radio.addEventListener('change', function() {
		        if (this.checked) {
		            bankInfoDiv.style.display = 'none'; //계좌번호 숨기기
		            payInfoDiv.style.display = 'block'; //결제 api 버튼 보여주기
		            payment1Radio.checked = false; // 무통장입금 라디오 버튼 선택 해제
		            payment1Checked = false;
		        }
		        
		        else{
		        	payInfoDiv.style.display = 'none';
		        	
		        }
		        
		    });		
		</script>				

		<div class="align-center">
		<input type="button" value="주문취소" class="default-btn"
			 onclick="location.href='${pageContext.request.contextPath}/gorder/goods_cart.do'">
		 <input type="button" value="굿즈목록" class="default-btn"
		 onclick="location.href='${pageContext.request.contextPath}/goods/goodsList.do'">
		</div>
		
		
		<c:forEach var="cart" items="${list}">
		<script>
		//=================결제 api 처리 시작=================
		// 주문번호 만들기
		function createMid(){
			const date = new Date();
			const year = date.getFullYear();
			const month = String(date.getMonth() + 1).padStart(2, "0");
			const day = String(date.getDate()).padStart(2, "0");
			
			let merchant_uid = year + month + day;
			for(let i=0;i<10;i++) {
				merchant_uid += Math.floor(Math.random() * 8);	
			}
			return merchant_uid;
		}
		
		function requestPay() {
			
			/*유효성 검사*/
			 if($('#receive_name').val().trim()==''){
					alert('수령인 입력은 필수입니다.');
					$('#receive_name').val('').focus();
					return false;
				}
			
			if($('#mem_phone').val().trim()==''){
				alert('전화번호는 필수입니다.');
				$('#mem_phone').val('').focus();
				return false;
			}
			if($('#zipcode').val().trim()==''){
				alert('우편번호는 필수입니다.');
				$('#zipcode').val('').focus();
				return false;
			}
			if($('#address1').val().trim()==''){
				alert('주소는 필수입니다.');
				$('#address1').val('').focus();
				return false;
			}
			if($('#address2').val().trim()==''){
				alert('상세주소를 입력해주세요.');
				$('#address2').val('').focus();
				return false;
			}
			if($('#order_name').val().trim()==''){
				alert('결제자 이름은 필수입니다.');
				$('#order_name').val('').focus();
				return false;
			}
			
			/* Portone 결제 API */
			var IMP = window.IMP;
		    IMP.init('imp40441146');  // 가맹점 식별코드
			
		    let order_name = document.getElementById('order_name').value;
		    let receive_name = document.getElementById('receive_name').value;
		    let mem_phone = document.getElementById('mem_phone').value;
		    let order_zipcode = document.getElementById('zipcode').value;
		    let order_address1 = document.getElementById('address1').value;
		    let order_address2 = document.getElementById('address2').value;
		    let order_message = document.getElementById('order_message').value;
		    let used_point = document.getElementById('used_point').value;
		    let all_total = parseInt(document.getElementById('all_total_result').textContent);
		    let order_dcost = document.getElementById('order_dcost').value;
		 
		    if (used_point === "" || used_point === null) {
		        used_point = 0; // 포인트를 사용하지 않았으면 0으로 처리
		    }
		    console.log(used_point); 
		 	// IMP.request_pay(param, callback) 결제창 호출
		 	IMP.request_pay({
		 		pg:'kakaopay.TC0ONETIME', //kakaopay.CID
		 		pay_method:'card',
		 		merchant_uid:createMid(),   // 주문번호
		 		name: '${cart.goodsVO.goods_name}', //상품명
		 		amount:${allTotalAndDcost},	// 숫자 타입
		 		buyer_name:order_name,
		 		buyer_tel:mem_phone
		 	},
		 	//callback
		 	function(rsp) {
		 		//결제 성공
		 		if(rsp.success) {
		 			const impUid = rsp.imp_uid;
		 			const merchant_uid = rsp.merchant_uid;
		 			const sysdate = new Date();
		 			let msg = '결제가 완료되었습니다.';
		 			
		 			//~~~~~~~상품명이 2개 이상이면 마지막 값으로 덮어씌워짐... 반복문 - list처리 chat~~~~~~~
		 			//controller로 넘어가는 값들
		 			let result = {
			 				'mem_num':${cart.mem_num},
			 				'order_status' : '0',
			 				'order_payment':'1', //카드가 1
			 				'order_name' : order_name, //결제자 이름
			 				'receive_name' : receive_name, //수령자 이름
			 				'order_zipcode' : order_zipcode,
			 				'order_address1' :order_address1,
			 				'order_address2' : order_address2,
			 				'mem_phone' : mem_phone, //받는 사람 전화번호
			 				'order_message' : order_message, 
			 				'goods_name' : '${cart.goodsVO.goods_name}',
			 				'order_quantity' : '${cart.order_quantity}',
			 				'used_point' : used_point,
			 				'order_point' : '${totalOrderPoint}', //적립 포인트
			 				'goods_num' : '${cart.goods_num}',
			 				'goods_size' : '${cart.goods_size}',
			 				'goods_dprice' : '${cart.goodsVO.goods_dprice}',
			 				'order_total': all_total,  //최종 결제금액(가격+배송비-포인트)
			 				'pg':'kakaopay',
			 				'pay_method' : 'card',
			 				'merchant_uid' : createMid(),
			 				'goods_total' : ${cart.sub_total}, //동일 상품 합계 - detail
			 				'name' : '${cart.goodsVO.goods_name}',
			 				'amount' : all_total,
			 				'order_dcost' : order_dcost
		 			}
		 			console.log(result); 
		 			
		 			paymentComplete(result); //ajax 통신 처리
		 			}
		 		//결제 실패
		 		else {
		 			let msg = '결제 실패\n';
		 			msg += 'ERROE : ' + rsp.error_msg;
		 		}
			}); 
		 
		}
		
		//계산 완료
		function paymentComplete(result){
			
			$.ajax({
				 url: '../gorder/insertMPay.do',
			        type: 'post',
			        dataType: 'json', // 서버로부터 받을 데이터의 타입을 JSON으로 설정
			        data: result, // 데이터를 JSON 문자열로 변환하여 보냄
			        success:function(param){
						if(param.result == 'logout'){
							alert('로그인 후 사용하세요!');
						} 
						else if(param.result=='orderError'){
							alert('주문할 상품이 없습니다');
						}
						else if(param.result=='noStatus'){
							alert('판매가 중지된 상품이 있습니다');	
						} else if(param.result=='noQuantity'){
							alert('상품 재고가 부족합니다');
						}	
						else if(param.result == 'success'){
							alert('결제 성공! 결제 목록으로 이동합니다.');
							location.href='../gorder/orderList.do?mem_num=${cart.mem_num}';
						}else{
							alert('구매 오류!');
						}
					},
					error:function(){
						alert('네트워크 오류 발생 - 장바구니 api 구매');
					}
 			});
		}
		

		 </script>
		</c:forEach>
		
<!-- 우편번호 검색 시작 -->
<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    //(주의)address1에 참고항목이 보여지도록 수정
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    //(수정) document.getElementById("address2").value = extraAddr;
                
                } 
                //(수정) else {
                //(수정)    document.getElementById("address2").value = '';
                //(수정) }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode;
                //(수정) + extraAddr를 추가해서 address1에 참고항목이 보여지도록 수정
                document.getElementById("address1").value = addr + extraAddr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("address2").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
</script>
<!-- 상품 구매 끝 -->


