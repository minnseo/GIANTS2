package kr.spring.goods.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.goods.vo.GoodsAnswerVO;
import kr.spring.goods.vo.GoodsFavVO;
import kr.spring.goods.vo.GoodsOptionVO;
import kr.spring.goods.vo.GoodsQnaVO;
import kr.spring.goods.vo.GoodsReviewVO;
import kr.spring.goods.vo.GoodsVO;
import kr.spring.gorder.vo.GorderDetailVO;

@Mapper
public interface GoodsMapper {
	//=====일반 상품=====//
	//전체|검색 상품 목록
	public List<GoodsVO> selectGoodsList(Map<String, Object> map);
	//전체|검색 상품 레코드수
	public int selectGoodsRowCount(Map<String, Object> map);
	
	//상품 정보 등록 
	@Select("SELECT goods_seq.nextval FROM dual")
	public int selectGoodsNum();
	public void insertGoods(GoodsVO goodsVO);
	//상품 재고 등록
	public void insertGoodsOption(@Param(value="goods_num") Integer goods_num, 
								@Param(value="goods_size") String goods_size, 
								@Param(value="goods_stock") Integer goods_stock);
	
	//상품 상세
	@Select("SELECT * FROM goods WHERE goods_num=#{goods_num}")
	public GoodsVO selectGoods(Integer goods_num);
	//상품 전체 정보
	@Select("SELECT * FROM goods join goods_option using(goods_num) WHERE goods_num=#{goods_num}")
	public GoodsVO selectGoodsAllInfo(Integer goods_num);
	//상품 재고 목록
	public List<GoodsOptionVO> selectOptionList(Integer goods_num);
	//상품 재고 수 - for 품절 표시
	@Select("SELECT sum(goods_stock) FROM goods_option WHERE goods_num=#{goods_num}")
	public int getGoodsStockSum(Integer goods_num);
	//상품에 대한 총 재고 현황
	@Select("SELECT sum(goods_stock) FROM goods_option WHERE goods_num=#{goods_num}")
	public int getGoodsTotalStock(Integer goods_num);
	 
	//상품 정보 수정
	public void updateGoods(GoodsVO goods);
	//상품 재고 수정
	public void updateOption(@Param(value="goods_num") Integer goods_num, 
							@Param(value="goods_size") String goods_size, 
							@Param(value="goods_stock") Integer goods_stock);
	//상품 삭제
	@Delete("DELETE FROM goods WHERE goods_num=#{goods_num}")
	public void deleteGoods(Integer goods_num);
	//상품 옵션 삭제
	@Delete("DELETE FROM goods_option WHERE goods_num=#{goods_num}")
	public void deleteOption(Integer goods_num);
	
	//=====상품 찜=====//
	//상품 찜 정보 읽어오기
	@Select("SELECT * FROM goods_fav WHERE goods_num=#{goods_num} AND mem_num=#{mem_num}")
	public GoodsFavVO selectGoodsFav(GoodsFavVO fav);
	//상품 찜 레코드 수
	@Select("SELECT count(*) FROM goods_fav WHERE goods_num=#{goods_num}")
	public int selectGoodsFavCount(Integer goods_num);
	//상품 찜 등록
	@Insert("INSERT INTO goods_fav(fav_num, goods_num, mem_num) VALUES(goods_fav_seq.nextval, #{goods_num}, #{mem_num})")
	public void insertGoodsFav(GoodsFavVO fav);
	//상품 찜 취소
	@Delete("DELETE FROM goods_fav WHERE fav_num=#{fav_num}")
	public void deleteGoodsFav(Integer fav_num);
	//상품삭제시 상품 찜 취소
	public void deleteGoodsFavByGoodsNum(Integer goods_num);
	//찜 목록 - 마이페이지
	public List<GoodsFavVO> selectGoodsFavList(Map<String, Object> map);
	//찜 목록 - 레코드 수
	public int selectGoodsFavCountByMem_num(Map<String, Object> map);
	
	//=====상품 후기=====//
	//상품 후기 목록
	public List<GoodsReviewVO> selectGoodsReviewList(Map<String, Object> map);
	//상품 후기 레코드 수
	public int selectGreviewRowCount(Integer goods_num);
	
	//상품 후기 등록
	public void insertGoodReview(GoodsReviewVO review);
	//상품 후기 - 구매목록 불러오기
	@Select("SELECT goods_num, goods_name FROM g_order_detail WHERE mem_num=#{mem_num}")
	public List<GorderDetailVO> selectOrderDetailList(Integer mem_num);
	
	//상품 후기 상세
	public GoodsReviewVO selectGoodsReview(Integer review_num);
	//상품 후기 수정
	@Update("UPDATE goods_review SET review_title=#{review_title}, review_content=#{review_content}, review_score=#{review_score}, review_photo=#{review_photo}, review_photoname=#{review_photoname}, review_mdate=sysdate, review_ip=#{review_ip} WHERE review_num=#{review_num}")
	public void updateGoodsReview(GoodsReviewVO review);
	//상품 후기 삭제
	@Delete("DELETE FROM goods_review WHERE review_num=#{review_num}")
	public void deleteGoodsReview(Integer review_num);
	
	//평균 별점 표시
	@Select("SELECT NVL(ROUND(AVG(review_score),1),0) FROM goods_review WHERE goods_num=#{goods_num}")
	public float getAvgScore(Integer goods_num);
	
	//=====상품 문의=====//
	//전체 | 검색 상품 문의 목록
	public List<GoodsQnaVO> selectGoodsQnaList(Map<String, Object> map);
	//전체 | 검색 상품 문의 레코드 수 - 상품페이지
	@Select("SELECT count(*) FROM goods_qna WHERE goods_num=#{goods_num}")
	public int selectGoodsQnaCount(Integer goods_num);
	//상품 문의 등록
	public void insertGoodsQna(GoodsQnaVO qna);
	//상품 문의 상세
	public GoodsQnaVO selectQna(Integer qna_num);
	//상품 문의 수정
	@Update("UPDATE goods_qna SET qna_title=#{qna_title}, qna_content=#{qna_content}, qna_mdate=sysdate, qna_ip=#{qna_ip} WHERE qna_num=#{qna_num}")
	public void updateGoodsQna(GoodsQnaVO qna);
	//상품 문의 삭제
	@Delete("DELETE FROM goods_qna WHERE qna_num=#{qna_num}")
	public void deleteGoodsQna(Integer qna_num);
	
	//상품 문의 처리 상태 => 처리완료
	@Update("UPDATE goods_qna SET qna_status=2 WHERE qna_num=#{qna_num}")
	public void updateGoodsQnaStatusDone(Integer qna_num);
	//상품 문의 처리 상태 => 처리전
	@Update("UPDATE goods_qna SET qna_status=1 WHERE qna_num=#{qna_num}")
	public void updateGoodsQnaStatusNot(Integer qna_num);
	
	
	//=====상품 문의 답변=====//
	//답변 목록
	public List<GoodsAnswerVO> selectListGoodsAnswer(Map<String, Object> map);
	//답변 갯수
	@Select("SELECT count(*) FROM goods_answer WHERE qna_num=#{qna_num}")
	//public int selectGoodsAnswerCount(Map<String, Object> map);
	public int selectGoodsAnswerCount(Integer qna_num);
	
	
	//답변 보기
	@Select("SELECT * FROM goods_answer WHERE gans_num=#{gans_num}")
	public GoodsAnswerVO selectGoodsAnswer(Integer gans_num);
	//답변 등록
	public void insertGoodsAnswer(GoodsAnswerVO answer);
	//답변 수정
	@Update("UPDATE goods_answer SET gans_content=#{gans_content}, gans_mdate=SYSDATE WHERE gans_num=#{gans_num}")
	public void updateGoodsAnswer(GoodsAnswerVO answer);
	//답변 삭제
	@Delete("DELETE FROM goods_answer WHERE gans_num=#{gans_num}")
	public void deleteGoodsAnswer(Integer gans_num);
	
	//문의글 삭제시 댓글이 존재하면 문의글 삭제 전에 답변 삭제
	public void deleteGoodsAnswerByQnaNum(Integer qna_num);
	
	//할인율 높은 순으로 정렬한 굿즈목록
	@Select("SELECT goods_num, goods_name FROM goods WHERE goods_status=1 ORDER BY goods_disc DESC")
	public List<GoodsVO> selectListByDisc(GoodsVO goodsVO);
}
