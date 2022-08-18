package com.forus.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.forus.domain.GoodsGetVO;
import com.forus.domain.GoodsOrderListVO;
import com.forus.domain.UserVO;
import com.forus.domain.sensorVO;
import com.forus.mapper.UserMapper;

@Service
public class UserService {
	@Autowired UserMapper mapper;
	
	// 1. 앱 구매자 로그인
	public final UserVO loginUser(UserVO vo){
		System.out.println(mapper.loginUser(vo));
		return mapper.loginUser(vo);
	}
	
	// 2. 주문내역
	public List<GoodsOrderListVO> userOrderList(String user_id) {
		return mapper.userOrderList(user_id);
	}
	
	// 3. 물건 꺼내기(g_status : '구매' -> '완료')
	public int completeBuyGoods(int g_seq) {
		return mapper.completeBuyGoods(g_seq);
	}
	
	// 4. 판매 내역(상품 상세페이지)
	public List<GoodsGetVO> userSellList(String user_id){
		return mapper.userSellList(user_id);
	}
	
	// 5. 상품삭제
	public int deleteGoods(int g_seq) {
		return mapper.deleteGoods(g_seq);
	}
	
	// 6. 상품 등록 페이지
	public List<GoodsGetVO> inputGoodsList(String user_id){
		return mapper.inputGoodsList(user_id);
	}
	
	// 7. 실제 상품 등록
	public int addGoods(int g_seq) {
		return mapper.addGoods(g_seq);
	}
	
	// 8. 센서 상태가져오기
	public List<sensorVO> sensor(int sesnor_id){
		return mapper.GetSensorList();
	}
	
	// 9.포인트 차감
	public int updatePoint(String user_id, int user_point) {
		return mapper.updatePoint(user_id, user_point);
	}
}
