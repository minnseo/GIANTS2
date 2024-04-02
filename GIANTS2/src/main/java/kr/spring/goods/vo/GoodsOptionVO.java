package kr.spring.goods.vo;

import org.hibernate.validator.constraints.Range;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class GoodsOptionVO {
	private int opt_num;
	private int goods_num;
	private String goods_size;
	@Range(min=0, max=9999999)
	private int goods_stock;
}
