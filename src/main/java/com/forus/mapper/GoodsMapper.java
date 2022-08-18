package com.forus.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.forus.domain.GoodsBuyCompleteVO;
import com.forus.domain.GoodsBuyVO;
import com.forus.domain.GoodsInfoVO;
import com.forus.domain.GoodsPwVO;
import com.forus.domain.GoodsVO;

@Mapper
public interface GoodsMapper {
	
	// 1. 상품리스트
	public List<GoodsInfoVO> mainGoodsList();
	
	// 2. 상품 상세 페이지
	public GoodsInfoVO goodsDetail(int g_seq);
	
	public GoodsVO goodsOne(int g_seq);
	
	// 3. 상품 구매 페이지
	public GoodsBuyVO goodsBuy(int g_seq);
	
	// 4. 상품 상태 판매 -> 완료로 변경
	public int goodsStatusUpdate(int g_seq, String user_id);
	
	// 5. 상품 판매 완료
	public GoodsBuyCompleteVO goodsComplete(int g_seq);
	
	// 6. 상품 비밀번호 추출
	public GoodsPwVO goodsPassword(int g_seq);
	

}
