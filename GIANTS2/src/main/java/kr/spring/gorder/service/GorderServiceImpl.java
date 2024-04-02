package kr.spring.gorder.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.gcart.vo.GcartVO;
import kr.spring.gorder.dao.GorderMapper;
import kr.spring.gorder.vo.GorderDetailVO;
import kr.spring.gorder.vo.GorderVO;

@Service
@Transactional
public class GorderServiceImpl implements GorderService{
	  
	@Autowired
	GorderMapper orderMapper;

	@Override
	public void insertOrder(GorderVO order, List<GorderDetailVO> list) {
		order.setOrder_num(orderMapper.selectOrderNum());
		orderMapper.insertOrder(order);
		for(GorderDetailVO vo : list) {
			vo.setOrder_num(order.getOrder_num());
			orderMapper.insertOrderDetail(vo);//재고수 업데이트
			orderMapper.updateQuantity(vo);
			orderMapper.deleteCartItem(vo.getGoods_num(), order.getMem_num());//주문 상품 장바구니에서 제거
		}
	}

	@Override
	public int selectOrderCount(Map<String, Object> map) {
		return orderMapper.selectOrderCount(map);
	}

	@Override
	public List<GorderVO> selectListOrder(Map<String, Object> map) {
		return orderMapper.selectListOrder(map);
	}


	@Override
	public void updatePoint(int mem_num) {
		orderMapper.updatePoint(mem_num);
	}

	@Override
	public int selectOrderCountByMem_num(Map<String, Object> map) {
		return orderMapper.selectOrderCountByMem_num(map);
	}

	@Override
	public List<GorderVO> selectListOrderByMem_num(Map<String, Object> map) {
		return orderMapper.selectListOrderByMem_num(map);
	}


	@Override
	public void updateOrder(GorderVO order) {
		orderMapper.updateOrder(order);
	}


	@Override
	public GorderVO selectOrder(int order_num) {
		return orderMapper.selectOrder(order_num);
	}

	@Override
	public List<GorderDetailVO> selectListOrderDetail(int order_num) {
		return orderMapper.selectListOrderDetail(order_num);
	}

	@Override
	public void usingPoint(int mem_point, int mem_num) {
		orderMapper.usingPoint(mem_point, mem_num);
	}

	@Override
	public void rollbackPoint(int used_point, int mem_num) {
		orderMapper.rollbackPoint(used_point, mem_num);
	}

	@Override
	public void updateGoodsQuantity(GorderDetailVO orderDetailVO) {
		orderMapper.updateGoodsQuantity(orderDetailVO);
	}
	
	@Override
	public void updateOrderStatus(GorderVO order) {
		orderMapper.updateOrderStatus(order);
		//주문취소일 경우 상품 개수, 포인트 롤백
		if(order.getOrder_status() == 5) {
			List<GorderDetailVO> detailList = 
					orderMapper.selectListOrderDetail(order.getOrder_num());
			for(GorderDetailVO vo : detailList) {
				orderMapper.updateGoodsQuantity(vo);
			}
		}
	}


	@Override
	public int allTotal() {
		// TODO Auto-generated method stub
		return orderMapper.allTotal();
	}

	@Override
	public List<GorderVO> getListSale() {
		return orderMapper.getListSale();
	}

	@Override
	public String dbGoodsName(int goods_num) {
		return orderMapper.dbGoodsName(goods_num);
	}

	@Override
	public List<GorderDetailVO> orderMonth(String year) {
		return orderMapper.orderMonth(year);
	}

	@Override
	public List<GorderDetailVO> countCategory() {
		return orderMapper.countCategory();
	}

	@Override
	public List<GcartVO> CheckCartToDirectBuy(int mem_num) {
		return orderMapper.CheckCartToDirectBuy(mem_num);
	}




	

	
	
	

}
