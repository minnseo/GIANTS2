package kr.spring.gcart.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.gcart.dao.GcartMapper;
import kr.spring.gcart.vo.GcartVO;

@Service
@Transactional
public class GcartServiceImpl implements GcartService{
	@Autowired
	GcartMapper cartMapper;

	@Override
	public void insertCart(GcartVO cart) {
		cartMapper.insertCart(cart);
	}

	@Override
	public int getTotalByMem_num(Map<String, Object> map) {
		return cartMapper.getTotalByMem_num(map);
	}

	@Override
	public List<GcartVO> getListCart(Map<String, Object> map) {
		return cartMapper.getListCart(map);
	}

	@Override
	public GcartVO getCart(GcartVO cart) {
		return cartMapper.getCart(cart);
	}

	@Override
	public void updateCart(GcartVO cart) {
		cartMapper.updateCart(cart);
		
	}

	@Override
	public void updateCartByItem_num(GcartVO cart) {
		cartMapper.updateCartByItem_num(cart);
	}

	@Override
	public void deleteCart(int cart_num) {
		cartMapper.deleteCart(cart_num);
		
	}

	@Override
	public int getStockByoption(int goods_num, int opt_num) {
		return cartMapper.getStockByoption(goods_num, opt_num);
	}

	@Override
	public void deleteCartAll(int mem_num) {
		cartMapper.deleteCartAll(mem_num);
		
	}
	
	@Override
	public int getTotalByPoint(Map<String, Object> map) {
		return cartMapper.getTotalByMem_num(map);
	}
	

	

}
