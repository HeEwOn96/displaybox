package com.forus.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.forus.domain.GoodsBuyCompleteVO;
import com.forus.domain.GoodsBuyVO;
import com.forus.domain.GoodsGetVO;
import com.forus.domain.GoodsInfoVO;
import com.forus.domain.GoodsOrderListVO;
import com.forus.domain.GoodsPwVO;
import com.forus.domain.GoodsVO;
import com.forus.domain.GsonDateAdapter;
import com.forus.domain.PaymentRequestResponse;
import com.forus.domain.UserVO;
import com.forus.service.GoodsService;
import com.forus.service.SensorService;
import com.forus.service.UserService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.mysql.cj.x.protobuf.MysqlxCrud.Order;

@Controller
public class GoodsController {
	public static String doorbtn = "";
	public static String lastTid = "";

	@Autowired
	private GoodsService goodsService;
	@Autowired
	private UserService userService;
	@Autowired
	private SensorService sensorService;

	// 초기화면
	@RequestMapping("/")
	public String primaryPage() {
		System.out.println("초기화면 실행");
		return "start";
	}

	// 1. main 상품리스트
	@RequestMapping("/main.do")
	public String mainGoodsList(Model model, HttpServletRequest request, HttpSession session) {
		String user_id = (String) session.getAttribute("user_id");
		System.out.println(user_id);

		List<GoodsInfoVO> list = goodsService.findAllList();
		model.addAttribute("list", list);
		System.out.println(list);
		session.setAttribute("user_id", user_id);
		System.out.println(session.getAttribute("user_id"));

		return "index";
	}

	// 2. 제품 상세 페이지
	@RequestMapping("/detail.do")
	public String detailGoodsList(Integer g_seq, Model model, HttpServletRequest request, HttpSession session) {
		String user_id = request.getParameter("user_id");
		System.out.println(user_id);

		System.out.println("제품 상세페이지 실행");
		GoodsInfoVO goods = goodsService.detailGoods(g_seq);
		model.addAttribute("vo", goods);
		System.out.println(goods);

		return "detail";
	}

	// 3. 제품 구매 페이지
	@RequestMapping("/buy.do")
	public String buyGoods(Integer g_seq, Model model, HttpServletRequest request, HttpSession session) {
		String user_id = request.getParameter("user_id");
		System.out.println(user_id);

		System.out.println("구매 페이지 실행");
		GoodsBuyVO goods = goodsService.buyGoods(g_seq);
		model.addAttribute("vo", goods);

		return "buy";
	}

	// 4. 상품 판매 상태 변경
	@RequestMapping("/goodsStatusUpdate.do")
	public @ResponseBody GoodsVO goodsStatus(int g_seq) {

		// 통신 됨
		System.out.println("g_seq : " + g_seq);
		goodsService.goodsStatusUpdate(g_seq);
		GoodsVO vo = goodsService.goodsOne(g_seq);
		System.out.println(vo);
		return vo;
	}

	// 5. 결제 완료 페이지
	@RequestMapping("/buycom.do")
	public String buyGoodsComplete(Integer g_seq, Model model, HttpServletRequest request, HttpSession session) {
		String user_id = request.getParameter("user_id");
		System.out.println(user_id);

		System.out.println("구매 완료 페이지");

		GoodsBuyCompleteVO vo = (GoodsBuyCompleteVO) goodsService.buyComplete(g_seq);
		model.addAttribute("vo", vo);
		System.out.println(vo);

		return "buycomplete";
	}

	// 6-1. login 폼 페이지
	@RequestMapping("/viewLogin.do")
	public String viewLogin() {
		System.out.println("viewlogin.do 진입");
		return "viewLogin";
	}

	// 6-2. login 기능
	@PostMapping("/login.do")
	public String login(UserVO vo, HttpSession session) throws Exception {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		System.out.println("로그인 페이지 진입");
		System.out.println(vo.getUser_id());
		if (userService.loginUser(vo) != null) {
			UserVO result = userService.loginUser(vo);
			System.out.println("로그인 확인" + result);

			// 암호키를 복호화
			encoder.matches(vo.getUser_pw(), result.getUser_pw());
			if (encoder.matches(vo.getUser_pw(), result.getUser_pw())) {
				session.setAttribute("user_id", result.getUser_id());
				System.out.println("My model: " + session.getAttribute("user_id"));
				return "redirect:/main.do";
			} else {
				return "redirect:/viewLogin.do";
			}
		}
		return "redirect:/viewLogin.do";

	}

	// 6-2. 로그아웃
	@RequestMapping("/logoutService.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/main.do";
	}

	// 7. 주문한 내역 불러오는 페이지
	@RequestMapping("/orderlist.do")
	public String userOrderList(Model model, HttpServletRequest request, HttpSession session) {
		System.out.println("주문내역 실행");

		String user_id = (String) session.getAttribute("user_id");
		System.out.println(user_id);
		List<GoodsOrderListVO> vo = userService.userOrderList(user_id);
		model.addAttribute("vo", vo);

		return "orderlist";
	}

	// 7-1 주문한 물건 실제로 꺼내는 기능
	@PostMapping("/completeBuy.do")
	public @ResponseBody GoodsVO completeBuy(int g_seq) {
		// 통신 됨
		System.out.println("g_seq : " + g_seq);
		userService.completeBuyGoods(g_seq);
		GoodsVO vo = goodsService.goodsOne(g_seq);
		System.out.println(vo);
		return vo;
	}

	// 8. 물건 삭제 페이지
	@RequestMapping("/getGoods.do")
	public String getGoodsList(Model model, HttpServletRequest request, HttpSession session) {
		System.out.println("상품 회수 페이지 실행");

		String user_id = (String) session.getAttribute("user_id");
		System.out.println("상품 회수 페이지 세션 : " + user_id);
		List<GoodsGetVO> vo = userService.userSellList(user_id);
		model.addAttribute("vo", vo);

		return "getgoods";
	}

	// 9. 상품 삭제하기
	@RequestMapping("/deleteGoods.do")
	public @ResponseBody GoodsVO goodsDelete(int g_seq) {

		// 통신 됨
		System.out.println("상품 삭제 페이지 g_seq : " + g_seq);
		userService.deleteGoods(g_seq);
		GoodsVO vo = goodsService.goodsOne(g_seq);
		System.out.println("상품 삭제 성공");
		return vo;
	}

	// 10. 비밀번호 입력 페이지
	@RequestMapping("/keypad.do")
	public String keypadOpen(Integer g_seq, Model model) {
		System.out.println("다이얼 실행");

		GoodsPwVO vo = goodsService.goodsPassword(g_seq);
		model.addAttribute("vo", vo);
		return "keypad";
	}

	// 11. 상품 등록 페이지
	@RequestMapping("/inputGoods.do")
	public String inputGoodsList(Model model, HttpServletRequest request, HttpSession session) {
		System.out.println("상품 등록 페이지 실행");

		String user_id = (String) session.getAttribute("user_id");
		System.out.println("상품 등록 페이지 세션 : " + user_id);
		List<GoodsGetVO> vo = userService.inputGoodsList(user_id);
		model.addAttribute("vo", vo);

		return "goodsinput";
	}

	// 12. 실제로 상품 등록하기
	@PostMapping("/inputGoodsAdd.do")
	public @ResponseBody GoodsVO inputGoodsAdd(Integer g_seq) {

		System.out.println("상품 등록 g_seq : " + g_seq);
		userService.addGoods(g_seq);
		GoodsVO vo = goodsService.goodsOne(g_seq);
		return vo;
	}

	// 13. 카카오페이 결제 api
	@RequestMapping("/kakaopay.do")

	public @ResponseBody String kakaopay() {
		try {
			URL address = new URL("https://kapi.kakao.com/v1/payment/ready");
			// 서버 연결
			HttpURLConnection connection = (HttpURLConnection) address.openConnection();
			connection.setRequestMethod("POST");
			connection.setRequestProperty("Authorization", "KakaoAK c9ed322880ff2e79a994f9b1b5f7bb7b");
			connection.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			// setDoInput 기본값 : true, setDoOutput 기본값 : false이므로 모두 true로 맞춰주자
			connection.setDoOutput(true);

			// parameter 설정해주기 홈페이지에 O 표시 되어있는 애들만
			String parameter = "cid=TC0ONETIME&partner_order_id=partner_order_id&partner_user_id=partner_user_id"
					+ "&item_name=engitem&quantity=1&total_amount=2200&vat_amount=200&tax_free_amount=0"
					+ "&approval_url=http://localhost:8081/buySuccess.do" + "&fail_url=http://localhost:8081/buyFail.do"
					+ "&cancel_url=http://localhost:8081/buyCancel.do";

			// parameter를 실제로 서버에 전달해주기
			// OutputStream = 줄 수 있도록 연결하는 역할
			OutputStream outputstream = connection.getOutputStream();
			// data를 주는 역할
			DataOutputStream datastream = new DataOutputStream(outputstream);
			// byte 형식으로 전달해야함
			datastream.writeBytes(parameter);
			datastream.close();

			// 통신결과
			int result = connection.getResponseCode();

			// 받을 수 있는 역할
			InputStream inputstream;
			// 정상 통신을 뜻하는 숫자 200 그 외에는 모두 error
			if (result == 200) {
				inputstream = connection.getInputStream();
			} else {
				inputstream = connection.getErrorStream();
			}

			String jsonStr = new BufferedReader(new InputStreamReader(inputstream)).lines()
					.collect(Collectors.joining("\n"));
			System.out.print(jsonStr);

			Gson gson = new GsonBuilder().registerTypeAdapter(Date.class, new GsonDateAdapter()).create();
			PaymentRequestResponse paymentRequestResponse = gson.fromJson(jsonStr, PaymentRequestResponse.class);
			lastTid = paymentRequestResponse.tid;
			return jsonStr;
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "{\"result\":\"NO\"}";
	}

	// 결제 승인 요청
	@RequestMapping("buySuccess.do")
	public String kakaopaySuccess(String pg_token, String tid) {
		try {
			URL address = new URL("https://kapi.kakao.com/v1/payment/approve");

			// 서버 연결
			HttpURLConnection connection = (HttpURLConnection) address.openConnection();
			connection.setRequestMethod("POST");
			connection.setRequestProperty("Authorization", "KakaoAK c9ed322880ff2e79a994f9b1b5f7bb7b");
			connection.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			connection.setDoOutput(true);

			String parameter = "cid=TC0ONETIME&tid=" + lastTid
					+ "&partner_order_id=partner_order_id&partner_user_id=partner_user_id&" + "pg_token=" + pg_token;

			OutputStream outputstream = connection.getOutputStream();
			DataOutputStream datastream = new DataOutputStream(outputstream);
			datastream.writeBytes(parameter);
			datastream.close();

			int result = connection.getResponseCode();

			InputStream inputstream;
			if (result == 200) {
				inputstream = connection.getInputStream();
			} else {
				inputstream = connection.getErrorStream();
			}
			InputStreamReader reader = new InputStreamReader(inputstream);
			BufferedReader buffer = new BufferedReader(reader);

			return buffer.readLine();

		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return "redirect:/buy.do";
	}

	// 결제 취소시 실행 url
	@RequestMapping("buyCancel.do")
	public String payCancel() {
		return "redirect:/buy.do";
	}

	// 결제 실패시 실행 url
	@RequestMapping("buyFail.do")
	public String payFail() {
		return "redirect:/buy.do";
	}

	@RequestMapping("/interface.do")
	public String f6() {
		System.out.println("인터페이스 실행");
		return "interface";
	}

	@RequestMapping("/manual.do")
	public String manualOpen() {
		System.out.println("이용방법 실행");
		return "manual";
	}

	@RequestMapping("/text.do")
	public String f9() {
		System.out.println("텍스트 실행");
		return "text";
	}

	// 아두이노 통신 부분 돈 터치
	@RequestMapping("/ledmodule.do")
	@ResponseBody
	public String Arduino(String keypad) {
		return doorbtn;
	}

	@RequestMapping("/BoxLed1.do")
	public String boxled1(String btn) {
		doorbtn = btn;

		return "text";
	}

	@RequestMapping("/BoxLed2.do")
	public String boxled2(String btn) {
		doorbtn = btn;

		return "text";
	}

	@RequestMapping("/BoxLed3.do")
	public String boxled3(String btn) {
		doorbtn = btn;

		return "text";
	}

	@RequestMapping("/BoxLed4.do")
	public String boxled4(String btn) {
		doorbtn = btn;

		return "text";
	}

	@GetMapping("/api/sensor")	
	@ResponseBody
	public Object GetSensorList() {
		return sensorService.GetSensorStatusList();		
	}
	
	@GetMapping("/api/sensor/{id}")	
	@ResponseBody
	public Object GetSensor(@PathVariable Integer id) {
		return sensorService.GetSensorStatus(id);		
	}
	
	@PutMapping("/api/sensor/{id}")	
	@ResponseBody
	public ResponseEntity<Object> PutSensor(@PathVariable Integer id, Integer status) {
		sensorService.UpdateSensorStatus(id, status);
		System.out.println("id: " + id + ", status: " + status);
		return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
	}

//	@RequestMapping("/module_warning.do")
//	public ResponseEntity<Object> modulewarning(Integer sensor, Boolean isOpend, Model model) {
//		if(isOpend == null){		
//		    return new ResponseEntity<Object>(HttpStatus.BAD_REQUEST);
//		}
//		System.out.println("sensor: " + sensor + ", isOpend: " + isOpend);
//		if(isOpend.booleanValue()) {
//		}else {
//		}
//		
//		
//	    return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
//
//	}
//	
//	public ResponseEntity<Object> Waring(int sensor, boolean isOpend) {
//		
//	    return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
//	}

}
