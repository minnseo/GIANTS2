package kr.spring.food.vo;

import java.sql.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class F_orderVO {					//논리명					키 분류
	private String f_order_num;			//주문번호(영수증번호)		PK		//DB에서 from dual로 시퀀스 뽑음
	private int mem_num;				//회원번호					FK
	private String comp_num;			//기업번호					FK
	private String f_order_name;		//주문 상품명들
	private int total_price;			//총 주문금액
	@NotEmpty
	private String buyer_name;			//구매자 이름
	@Size(min = 11, max = 11)
	@NotEmpty
	private String buyer_phone;			//구매자 전화번호
	@Email
	@NotEmpty
	private String buyer_email;			//구매자 이메일
	private Date f_order_regDate;		//주문날짜
	private Date f_order_expireDate;	//주문유효기간
	private int f_order_status;			//QR사용상태		사용 전 = 1, 후 = 0 , 취소 = 9, 리뷰완료= 2
	private String qrlink;				//QR링크
	private String pg;					//PG사
	private String pay_method;			//결제수단			
	
	private int[] cart_numbers;		//장바구니에서 선택한 상품의 번호들
	
}
