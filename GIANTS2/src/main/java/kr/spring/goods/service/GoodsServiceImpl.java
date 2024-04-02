package kr.spring.goods.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.goods.dao.GoodsMapper;
import kr.spring.goods.vo.GoodsAnswerVO;
import kr.spring.goods.vo.GoodsFavVO;
import kr.spring.goods.vo.GoodsOptionVO;
import kr.spring.goods.vo.GoodsQnaVO;
import kr.spring.goods.vo.GoodsReviewVO;
import kr.spring.goods.vo.GoodsVO;
import kr.spring.gorder.vo.GorderDetailVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class GoodsServiceImpl implements GoodsService{
	
	@Autowired
	GoodsMapper goodsMapper;
 
	@Override
	public List<GoodsVO> selectGoodsList(Map<String, Object> map) {
		return goodsMapper.selectGoodsList(map);
	}

	@Override
	public int selectGoodsRowCount(Map<String, Object> map) {
		return goodsMapper.selectGoodsRowCount(map);
	}
	
	@Override
	public void insertGoods(GoodsVO goodsVO) {
		//상품번호 생성해서 자바빈에 저장
		goodsVO.setGoods_num(goodsMapper.selectGoodsNum());
		
		//상품 정보 저장
		goodsMapper.insertGoods(goodsVO);
		
		for(int i=0; i < (goodsVO.getGoods_stocks()).length; i++) {
			String goods_size = goodsVO.getGoods_sizes()[i];
			int goods_stock = goodsVO.getGoods_stocks()[i];
			
			goodsMapper.insertGoodsOption(goodsVO.getGoods_num(), goods_size, goods_stock);
		}
		
		goodsMapper.getGoodsTotalStock(goodsVO.getGoods_num());
		 
	}

	@Override
	public GoodsVO selectGoods(Integer goods_num) {
		return goodsMapper.selectGoods(goods_num);
	}
	
	@Override
	public List<GoodsOptionVO> selectOptionList(Integer goods_num) {
		return goodsMapper.selectOptionList(goods_num);
	}

	@Override
	public void updateGoods(GoodsVO goods) {
		//상품 정보 업데이트
		goodsMapper.updateGoods(goods);
		
		log.debug(">>" + goods);
		
		for(int i=0; i < (goods.getGoods_stocks()).length; i++) {
			String goods_size = goods.getGoods_sizes()[i];
			log.debug("<<goods.getGoods_sizes()[i]>> : " + goods.getGoods_sizes()[i]);
			int goods_stock = goods.getGoods_stocks()[i];
			log.debug("<<goods.getGoods_stocks()[i]>> : " + goods.getGoods_stocks()[i]);
			
			goodsMapper.updateOption(goods.getGoods_num(), goods_size, goods_stock);
		}
	}
	
	@Override
	public void deleteGoods(Integer goods_num) {
		//장바구니에서 삭제
		//리뷰 삭제
		//goodsMapper.deleteGoodsReview();
		//문의 삭제
		//찜하기 목록에서 삭제
		//굿즈 옵션 삭제
		goodsMapper.deleteOption(goods_num);
		//굿즈목록에서 삭제
		goodsMapper.deleteGoods(goods_num);
		
	}

	@Override
	public GoodsFavVO selectGoodsFav(GoodsFavVO fav) {
		return goodsMapper.selectGoodsFav(fav);
	}

	@Override
	public int selectGoodsFavCount(Integer goods_num) {
		return goodsMapper.selectGoodsFavCount(goods_num);
	}

	@Override
	public void insertGoodsFav(GoodsFavVO fav) {
		goodsMapper.insertGoodsFav(fav);
	}

	@Override
	public void deleteGoodsFav(Integer fav_num) {
		goodsMapper.deleteGoodsFav(fav_num);
	}

	@Override
	public List<GoodsReviewVO> selectGoodsReviewList(Map<String, Object> map) {
		return goodsMapper.selectGoodsReviewList(map);
	}

	@Override
	public int selectGreviewRowCount(Integer goods_num) {
		return goodsMapper.selectGreviewRowCount(goods_num);
	}

	@Override
	public void insertGoodReview(GoodsReviewVO review) {
		goodsMapper.insertGoodReview(review);
	}

	@Override
	public GoodsReviewVO selectGoodsReview(Integer review_num) {
		return goodsMapper.selectGoodsReview(review_num);
	}

	@Override
	public void updateGoodsReview(GoodsReviewVO review) {
		goodsMapper.updateGoodsReview(review);
	}

	@Override
	public void deleteGoodsReview(Integer review_num) {
		goodsMapper.deleteGoodsReview(review_num);
	}
	
	@Override
	public float getAvgScore(Integer goods_num) {
		return goodsMapper.getAvgScore(goods_num);
	}

	//===== 상품문의 =====//
	@Override
	public void insertGoodsQna(GoodsQnaVO qna) {
		goodsMapper.insertGoodsQna(qna);
	}

	@Override
	public List<GoodsQnaVO> selectGoodsQnaList(Map<String, Object> map) {
		return goodsMapper.selectGoodsQnaList(map);
	}

	@Override
	public int selectGoodsQnaCount(Integer goods_num) {
		return goodsMapper.selectGoodsQnaCount(goods_num);
	}

	@Override
	public GoodsQnaVO selectQna(Integer qna_num) {
		return goodsMapper.selectQna(qna_num);
	}

	@Override
	public void updateGoodsQna(GoodsQnaVO qna) {
		goodsMapper.updateGoodsQna(qna);
	}

	@Override
	public void deleteGoodsQna(Integer qna_num) {
		goodsMapper.deleteGoodsQna(qna_num);
	}

	//===== 상품문의 답변 =====//
	
	@Override
	public List<GoodsAnswerVO> selectListGoodsAnswer(Map<String, Object> map) {
		return goodsMapper.selectListGoodsAnswer(map);
	}

	@Override
	public int selectGoodsAnswerCount(Integer qna_num) {
		return goodsMapper.selectGoodsAnswerCount(qna_num);
	}

	@Override
	public GoodsAnswerVO selectGoodsAnswer(Integer gans_num) {
		return goodsMapper.selectGoodsAnswer(gans_num);
	}

	@Override
	public void insertGoodsAnswer(GoodsAnswerVO answer) {
		goodsMapper.insertGoodsAnswer(answer);
	}

	@Override
	public void updateGoodsAnswer(GoodsAnswerVO answer) {
		goodsMapper.updateGoodsAnswer(answer);
	}

	@Override
	public void deleteGoodsAnswer(Integer gans_num) {
		goodsMapper.deleteGoodsAnswer(gans_num);
	}

	@Override
	public void updateGoodsQnaStatusDone(Integer qna_num) {
		goodsMapper.updateGoodsQnaStatusDone(qna_num);
	}

	@Override
	public void updateGoodsQnaStatusNot(Integer qna_num) {
		goodsMapper.updateGoodsQnaStatusNot(qna_num);
	}

	@Override
	public int getGoodsTotalStock(Integer goods_num) {
		return goodsMapper.getGoodsTotalStock(goods_num);
	}

	@Override
	public GoodsVO selectGoodsAllInfo(Integer goods_num) {
		return goodsMapper.selectGoodsAllInfo(goods_num);
	}

	@Override
	public List<GorderDetailVO> selectOrderDetailList(Integer mem_num) {
		return goodsMapper.selectOrderDetailList(mem_num);
	}

	@Override
	public List<GoodsFavVO> selectGoodsFavList(Map<String, Object> map) {
		return goodsMapper.selectGoodsFavList(map);
	}

	@Override
	public int selectGoodsFavCountByMem_num(Map<String, Object> map) {
		return goodsMapper.selectGoodsFavCountByMem_num(map);
	}

	@Override
	public List<GoodsVO> selectListByDisc(GoodsVO goodsVO) {
		return goodsMapper.selectListByDisc(goodsVO);
	}

}
