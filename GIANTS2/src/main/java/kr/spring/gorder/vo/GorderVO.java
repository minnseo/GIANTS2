package kr.spring.gorder.vo;

import java.sql.Date;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
public class GorderVO {
	private int goods_num; //상품 번호
	private int opt_num;
	private int goods_revenue; //상품 매출
	
	private String start_month;//01~12월 - sql문에서 비교를 해주기 때문에 날짜 크기 비교 따로 처리 x
	private String end_month; //01~12월
	
	
	//==========
	
	private int used_point; //사용한 포인트
	private int order_dcost; //배송비 default 3000
	
	private int order_num;//주문번호  
	private int mem_num;
	private String goods_name;
	private int order_payment; //(0:무통장, 1:카드)
	private int order_status; //배송 상태(default 0, 배송상태(0:결제완료, 1:배송준비, 2:배송중, 3:배송완료)
	private Date order_regdate;
	private Date order_modifydate; //수정일
	@NotEmpty
	private String order_name; //주문자 이름
	@NotEmpty
	private String receive_name; //수령자 이름
	@NotEmpty
	private String order_zipcode;
	@NotEmpty
	private String order_address1; //배송지 주소
	@NotEmpty
	private String order_address2; //배송지 상세주소
	@NotEmpty
	private String mem_phone; //배송지 전화번호
	private String order_message;
	
	private int order_total; //최종 결제 금액 (goods_dprice - used_point - order_dcost) - sql문에서 처리해주자(dcost는 detail에 있음)
	
	
	
	
	private String merchant_uid; //결제 api
	
	private String id; //구매자 id
	private int[] cart_numbers; //장바구니에서 선택한 상품의 번호들
	private GorderDetailVO gorderDetailVO;
	
	private String impUid; // 아임포트 결제번호 추가
	
}
