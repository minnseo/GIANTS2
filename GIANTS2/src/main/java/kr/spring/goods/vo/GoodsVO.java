package kr.spring.goods.vo;

import java.io.IOException;
import java.sql.Date;

import javax.validation.constraints.NotEmpty;

import org.hibernate.validator.constraints.Range;
import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(exclude="goods_photo")
public class GoodsVO {
	private int goods_num; //상품번호
	@NotEmpty
	private String goods_name; //상품명
	@Range(min=1, max=4)
	private int goods_category; //카테고리 - 1:유니폼/2:모자/3:응원도구/4:기타
	@Range(min=0, max=99999999)
	private int goods_price; //상품가격
	@Range(min=0, max=100)
	private int goods_disc; //할인율
	@Range(min=0, max=99999999)
	private int goods_dprice; //판매가 = 상품가격 * (1-할인율)
	@NotEmpty
	private String goods_content; //상품설명
	private byte[] goods_photo; //(목록에 보이는) 상품 사진
	private String goods_photoname; //상품 사진 파일명
	private Date goods_regdate; //상품 등록일
	private Date goods_mdate; //상품 최근수정일
	
	@Range(min=1, max=2)
	private int goods_status; //1:미표시, 2:표시
	
	@NotEmpty
	private String[] goods_sizes; //상품 사이즈
	private int[] goods_stocks; //상품 재고수량
	
	
	//굿즈 옵션
	private GoodsOptionVO goodsOptionVO;
	private int total_stock;
	
	private int fav_cnt;
	private int re_cnt;
	
	//======이미지를 byte[]로 변환하는 메서드(BLOB 처리)=====//
	public void setUpload(MultipartFile upload) throws IOException{
		setGoods_photo(upload.getBytes()); //MultipartFile -> byte[]
		setGoods_photoname(upload.getOriginalFilename()); //파일 이름
	}
}
