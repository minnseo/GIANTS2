package kr.spring.goods.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.goods.vo.GoodsAnswerVO;
import kr.spring.goods.vo.GoodsFavVO;
import kr.spring.goods.vo.GoodsOptionVO;
import kr.spring.goods.vo.GoodsQnaVO;
import kr.spring.goods.vo.GoodsReviewVO;
import kr.spring.goods.vo.GoodsVO;
import kr.spring.gorder.vo.GorderDetailVO;

public interface GoodsService {
	//=====일반 상품=====//
	//전체|검색 상품 목록 
	public List<GoodsVO> selectGoodsList(Map<String, Object> map);
	//전체|검색 상품 레코드수
	public int selectGoodsRowCount(Map<String, Object> map);
	//상품 등록
	public void insertGoods(GoodsVO goods);
	//상품 상세
	public GoodsVO selectGoods(Integer goods_num);
	public GoodsVO selectGoodsAllInfo(Integer goods_num);
	//상품 재고 목록
	public List<GoodsOptionVO> selectOptionList(Integer goods_num);
	//상품에 대한 총 재고 현황
	public int getGoodsTotalStock(Integer goods_num);
	
	//상품 정보 수정
	public void updateGoods(GoodsVO goods);
	
	//상품 삭제
	public void deleteGoods(Integer goods_num);
	
	//=====상품 찜=====//
	//상품 찜 목록
	public GoodsFavVO selectGoodsFav(GoodsFavVO fav);
	//상품 찜 레코드 수
	public int selectGoodsFavCount(Integer goods_num);
	//상품 찜 등록
	public void insertGoodsFav(GoodsFavVO fav);
	//상품 찜 취소
	public void deleteGoodsFav(Integer fav_num);
	//찜 목록
	public List<GoodsFavVO> selectGoodsFavList(Map<String, Object> map);
	//찜 목록 - 레코드 수
	public int selectGoodsFavCountByMem_num(Map<String, Object> map);
	
	//=====상품 후기=====// 
	//전체|검색 상품 후기 목록
	public List<GoodsReviewVO> selectGoodsReviewList(Map<String, Object> map);
	//전체|검색 상품 후기 레코드 수
	public int selectGreviewRowCount(Integer goods_num);
	//상품 후기 등록
	public void insertGoodReview(GoodsReviewVO review);
	//상품 후기 - 구매목록 불러오기
	public List<GorderDetailVO> selectOrderDetailList(Integer mem_num);
	//상품 후기 상세
	public GoodsReviewVO selectGoodsReview(Integer review_num);
	//상품 후기 수정
	public void updateGoodsReview(GoodsReviewVO review);
	//상품 후기 삭제
	public void deleteGoodsReview(Integer review_num);
	//평균 별점 표시
	public float getAvgScore(Integer goods_num);
	
	//=====상품 문의=====//
	//전체 | 검색 상품 문의 목록
	public List<GoodsQnaVO> selectGoodsQnaList(Map<String, Object> map);
	//전체 | 검색 상품 문의 레코드 수
	public int selectGoodsQnaCount(Integer goods_num);
	//상품 문의 등록
	public void insertGoodsQna(GoodsQnaVO qna);
	//상품 문의 상세
	public GoodsQnaVO selectQna(Integer qna_num);
	//상품 문의 수정
	public void updateGoodsQna(GoodsQnaVO qna);
	//상품 문의 삭제
	public void deleteGoodsQna(Integer qna_num);
	
	//상품 문의 처리 상태 => 처리완료
	public void updateGoodsQnaStatusDone(Integer qna_num);
	//상품 문의 처리 상태 => 처리전
	public void updateGoodsQnaStatusNot(Integer qna_num);
	
	//=====상품 문의 답변=====//
	//답변 목록
	public List<GoodsAnswerVO> selectListGoodsAnswer(Map<String, Object> map);
	//답변 수
	public int selectGoodsAnswerCount(Integer qna_num);
	//답변 보기
	public GoodsAnswerVO selectGoodsAnswer(Integer gans_num);
	//답변 등록
	public void insertGoodsAnswer(GoodsAnswerVO answer);
	//답변 수정
	public void updateGoodsAnswer(GoodsAnswerVO answer);
	//답변 삭제
	public void deleteGoodsAnswer(Integer gans_num);
	
	//할인율 높은 순으로 정렬한 굿즈목록
	public List<GoodsVO> selectListByDisc(GoodsVO goodsVO);
}
