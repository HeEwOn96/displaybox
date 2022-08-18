package com.forus.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.forus.domain.GoodsBuyCompleteVO;
import com.forus.domain.GoodsBuyVO;
import com.forus.domain.GoodsInfoVO;
import com.forus.domain.GoodsPwVO;
import com.forus.domain.GoodsVO;
import com.forus.mapper.GoodsMapper;

@Service
public class GoodsService {
	@Autowired
	private GoodsMapper mapper;
	
	// 1. main.do
	public List<GoodsInfoVO> findAllList(){
		return mapper.mainGoodsList();
	}
	
	public GoodsVO goodsOne(int g_seq) {
		return mapper.goodsOne(g_seq);
	}
	
	// 2. detail.do
	public GoodsInfoVO detailGoods(int g_seq){
		return mapper.goodsDetail(g_seq);
	}
	
	// 3. buy.do
	public GoodsBuyVO buyGoods(int g_seq){
		return mapper.goodsBuy(g_seq);
	}
	
	// 4. goodsStatusUpdate.do
	public int goodsStatusUpdate(int g_seq, String user_id) {
		return mapper.goodsStatusUpdate(g_seq, user_id);
	}
	
	// 5. buycomplete.do
	public GoodsBuyCompleteVO buyComplete(int g_seq){
		return mapper.goodsComplete(g_seq);
	}
		
	// 6. keypad.do
	public GoodsPwVO goodsPassword(int g_seq) {
		return mapper.goodsPassword(g_seq);
	}
}
