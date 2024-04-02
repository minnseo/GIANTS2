package kr.spring.goods.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class GoodsFavVO {
	private int fav_num; //찜번호
	private int goods_num; //상품번호
	private int mem_num; //회원번호
	
	private int fav_cnt; //찜 갯수
	private String mem_id;
	private String goods_name;
	
	//private GoodsVO goodsVO;
}
