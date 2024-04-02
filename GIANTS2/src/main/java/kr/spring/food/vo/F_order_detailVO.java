package kr.spring.food.vo;

import javax.validation.constraints.NotEmpty;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class F_order_detailVO {			//논리명				키 분류
	@NotEmpty
	private int f_detail_num;			//주문상세번호			PK
	@NotEmpty
	private int food_num;				//식품번호				FK
	@NotEmpty
	private String f_order_num;			//주문번호				FK
	private int order_quantity;			//주문개수				
	private String food_name;			//상품명
	private int food_price;				//식품가격
	private int food_total;				//총 상품 금액
}
