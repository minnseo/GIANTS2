package kr.spring.gcart.vo;

import java.sql.Date;

import kr.spring.goods.vo.GoodsOptionVO;
import kr.spring.goods.vo.GoodsVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class GcartVO {
	private int cart_num;
	private int goods_num;
	private int mem_num;
	private int order_quantity;
	private Date reg_date; //장바구니에 넣은 날짜, default SYSDATE
	private int opt_num; //옵션 식별 번호
	private String goods_name;
	private int goods_stock;
	
	//컬럼에 없는 값들
	private int sub_total; //같은 상품의 총구매 금액
	private int order_point; //예상 적립금으로 각 굿즈 금액의 2%
	private String goods_size; //옵션값에 있는 굿즈 사이즈
	private GoodsVO goodsVO;
	private GoodsOptionVO goodsOptionVO;
}
