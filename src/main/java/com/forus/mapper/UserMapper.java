package com.forus.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.forus.domain.GoodsGetVO;
import com.forus.domain.GoodsOrderListVO;
import com.forus.domain.UserVO;
import com.forus.domain.sensorVO;

@Mapper
public interface UserMapper {
	
	// 1. 앱 구매자 로그인
	public UserVO loginUser(UserVO vo);
	
	// 2. 주문 리스트
	public List<GoodsOrderListVO> userOrderList(String user_id);
	
	// 3. 리스트에 있는 물건 실제로 꺼내기
	public int completeBuyGoods(int g_seq);
	
	// 4. 상품 회수 페이지
	public List<GoodsGetVO> userSellList(String user_id);
	
	// 5. 상품 삭제하기
	public int deleteGoods(int g_seq);
	
	// 6. 상품 등록 페이지
	public List<GoodsGetVO> inputGoodsList(String user_id);
	
	// 7. 실제로 상품 등록하기
	public int addGoods(int g_seq);
	
	// 8. 센서 값 전체 받아오기
	public List<sensorVO> GetSensorList();
	
	public sensorVO GetSensorStatus(int id);
	
	public int UpdateSensorStatus(sensorVO sensor);
	
	// 포인트 차감
	public int updatePoint(String user_id, int user_point);
}
