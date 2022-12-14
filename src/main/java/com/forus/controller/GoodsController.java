  package com.forus.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.ws.Response;

import org.apache.jasper.tagplugins.jstl.core.Out;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.forus.domain.GoodsBuyCompleteVO;
import com.forus.domain.GoodsBuyVO;
import com.forus.domain.GoodsGetVO;
import com.forus.domain.GoodsInfoVO;
import com.forus.domain.GoodsOrderListVO;
import com.forus.domain.GoodsPwVO;
import com.forus.domain.GoodsVO;
import com.forus.domain.GsonDateAdapter;
import com.forus.domain.KakaoResponse;
import com.forus.domain.PaymentRequestResponse;
import com.forus.domain.UserVO;
import com.forus.domain.ledVO;
import com.forus.service.GoodsService;
import com.forus.service.LedService;
import com.forus.service.SensorService;
import com.forus.service.UserService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import com.google.gson.JsonObject;
import com.mysql.cj.x.protobuf.MysqlxCrud.Order;


@Controller
public class GoodsController {
	public static String doorbtn = "";
	public static String lastTid = "";
	public static String list = null;
	
	

	@Autowired
	private GoodsService goodsService;
	@Autowired
	private UserService userService;
	@Autowired
	private SensorService sensorService;
	@Autowired
	private LedService ledService;

	// ????????????
	@RequestMapping("/")
	public String primaryPage() {
		System.out.println("???????????? ??????");
		return "start";
	}

	// 1. main ???????????????
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

	// 2. ?????? ?????? ?????????
	@RequestMapping("/detail.do")
	public String detailGoodsList(Integer g_seq, Model model, HttpServletRequest request, HttpSession session) {
		String user_id = request.getParameter("user_id");
		System.out.println(user_id);

		System.out.println("?????? ??????????????? ??????");
		GoodsInfoVO goods = goodsService.detailGoods(g_seq);
		model.addAttribute("vo", goods);
		System.out.println(goods);

		return "detail";
	}

	// 3. ?????? ?????? ?????????
	@RequestMapping("/buy.do")
	public String buyGoods(Integer g_seq, Model model, HttpServletRequest request, HttpSession session) {
		String user_id = request.getParameter("user_id");
		System.out.println(user_id);

		System.out.println("?????? ????????? ??????");
		GoodsBuyVO goods = goodsService.buyGoods(g_seq);
		model.addAttribute("vo", goods);

		return "buy";
	}

	// 4. ?????? ?????? ?????? ??????
	@RequestMapping("/goodsStatusUpdate.do")
	public @ResponseBody GoodsVO goodsStatus(int g_seq, int user_point, HttpServletRequest request, HttpSession session) {
		String user_id = (String) session.getAttribute("user_id");
		
		
		System.out.println("????????? : " +user_point);
		// ?????? ???
		System.out.println("g_seq : " + g_seq + "??????????????? : " + user_id);
		if (user_point > 0) {
			userService.updatePoint(user_id, user_point);
		}
		
		goodsService.goodsStatusUpdate(g_seq,user_id);
		GoodsVO vo = goodsService.goodsOne(g_seq);
		System.out.println(vo);
		return vo;
	}

	// 5. ?????? ?????? ?????????
	@RequestMapping("/buycom.do")
	public String buyGoodsComplete(Integer g_seq, Model model, HttpServletRequest request, HttpSession session) {
		String user_id = request.getParameter("user_id");
		System.out.println(user_id);

		System.out.println("?????? ?????? ?????????");

		GoodsBuyCompleteVO vo = (GoodsBuyCompleteVO) goodsService.buyComplete(g_seq);
		model.addAttribute("vo", vo);
		System.out.println(vo);

		return "buycomplete";
	}

	// 6-1. login ??? ?????????
	@RequestMapping("/viewLogin.do")
	public String viewLogin() {
		System.out.println("viewlogin.do ??????");
		return "viewLogin";
	}

	// 6-2. login ??????
	@PostMapping("/login.do")
	public String login(UserVO vo, HttpSession session) throws Exception {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		System.out.println("????????? ????????? ??????");
		System.out.println(vo.getUser_id());
		if (userService.loginUser(vo) != null) {
			UserVO result = userService.loginUser(vo);
			System.out.println("????????? ??????" + result);

			// ???????????? ?????????
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

	// 6-2. ????????????
	@RequestMapping("/logoutService.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/main.do";
	}

	// 7. ????????? ?????? ???????????? ?????????
	@RequestMapping("/orderlist.do")
	public String userOrderList(Model model, HttpServletRequest request, HttpSession session) {
		System.out.println("???????????? ??????");

		String user_id = (String) session.getAttribute("user_id");
		System.out.println(user_id);
		List<GoodsOrderListVO> vo = userService.userOrderList(user_id);
		model.addAttribute("vo", vo);

		return "orderlist";
	}

	// 7-1 ????????? ?????? ????????? ????????? ??????
	@PostMapping("/completeBuy.do")
	public @ResponseBody GoodsVO completeBuy(int g_seq) {
		// ?????? ???
		System.out.println("g_seq : " + g_seq);
		userService.completeBuyGoods(g_seq);
		GoodsVO vo = goodsService.goodsOne(g_seq);
		System.out.println(vo);
		return vo;
	}

	// 8. ?????? ?????? ?????????
	@RequestMapping("/getGoods.do")
	public String getGoodsList(Model model, HttpServletRequest request, HttpSession session) {
		System.out.println("?????? ?????? ????????? ??????");

		String user_id = (String) session.getAttribute("user_id");
		System.out.println("?????? ?????? ????????? ?????? : " + user_id);
		List<GoodsGetVO> vo = userService.userSellList(user_id);
		model.addAttribute("vo", vo);

		return "getgoods";
	}

	// 9. ?????? ????????????
	@RequestMapping("/deleteGoods.do")
	public String goodsDelete(int g_seq,Model model) {

		// ?????? ???
		System.out.println("?????? ?????? ????????? g_seq : " + g_seq);
		userService.deleteGoods(g_seq);
		GoodsVO vo = goodsService.goodsOne(g_seq);
		System.out.println("?????? ?????? ??????");
		
		return"redirect:/getGoods.do";
	}

	// 10. ???????????? ?????? ?????????
	@RequestMapping("/keypad.do")
	public String keypadOpen(Integer g_seq, Model model) {
		System.out.println("????????? ??????");

		GoodsPwVO vo = goodsService.goodsPassword(g_seq);
		model.addAttribute("vo", vo);
		return "keypad";
	}

	// 11. ?????? ?????? ?????????
	@RequestMapping("/inputGoods.do")
	public String inputGoodsList(Model model, HttpServletRequest request, HttpSession session) {
		System.out.println("?????? ?????? ????????? ??????");

		String user_id = (String) session.getAttribute("user_id");
		System.out.println("?????? ?????? ????????? ?????? : " + user_id);
		List<GoodsGetVO> vo = userService.inputGoodsList(user_id);
		model.addAttribute("vo", vo);

		return "goodsinput";
	}

	// 12. ????????? ?????? ????????????
	@PostMapping("/inputGoodsAdd.do")
	public @ResponseBody GoodsVO inputGoodsAdd(Integer g_seq) {

		System.out.println("?????? ?????? g_seq : " + g_seq);
		userService.addGoods(g_seq);
		GoodsVO vo = goodsService.goodsOne(g_seq);
		return vo;
	}

	// 13. ??????????????? ?????? api
	@RequestMapping("/kakaopay.do")

	public @ResponseBody String kakaopay() {
		try {
			URL address = new URL("https://kapi.kakao.com/v1/payment/ready");
			// ?????? ??????
			HttpURLConnection connection = (HttpURLConnection) address.openConnection();
			connection.setRequestMethod("POST");
			connection.setRequestProperty("Authorization", "KakaoAK c9ed322880ff2e79a994f9b1b5f7bb7b");
			connection.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			// setDoInput ????????? : true, setDoOutput ????????? : false????????? ?????? true??? ????????????
			connection.setDoOutput(true);

			// parameter ??????????????? ??????????????? O ?????? ???????????? ?????????
			String parameter = "cid=TC0ONETIME&partner_order_id=partner_order_id&partner_user_id=partner_user_id"
					+ "&item_name=??????&item_code=35&quantity=1&total_amount=2200&vat_amount=200&tax_free_amount=0"
					+ "&approval_url=http://localhost:8081/buySuccess.do" + "&fail_url=http://localhost:8081/buyFail.do"
					+ "&cancel_url=http://localhost:8081/buyCancel.do";

			// parameter??? ????????? ????????? ???????????????
			// OutputStream = ??? ??? ????????? ???????????? ??????
			OutputStream outputstream = connection.getOutputStream();
			// data??? ?????? ??????
			DataOutputStream datastream = new DataOutputStream(outputstream);
			// byte ???????????? ???????????????
			datastream.writeBytes(parameter);
			datastream.close();

			// ????????????
			int result = connection.getResponseCode();

			// ?????? ??? ?????? ??????
			InputStream inputstream;
			// ?????? ????????? ????????? ?????? 200 ??? ????????? ?????? error
			if (result == 200) {
				inputstream = connection.getInputStream();
			} else {
				inputstream = connection.getErrorStream();
			}

			String jsonStr = new BufferedReader(new InputStreamReader(inputstream)).lines()
					.collect(Collectors.joining("\n"));

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

	// ?????? ?????? ??????
	@RequestMapping("buySuccess.do")
	public String kakaopaySuccess(String pg_token, String tid) {
		try {
			URL address = new URL("https://kapi.kakao.com/v1/payment/approve");

			// ?????? ??????
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
			Gson gson = new GsonBuilder().registerTypeAdapter(Date.class, new GsonDateAdapter()).create();
			KakaoResponse response = gson.fromJson(buffer, KakaoResponse.class);
			
			return "redirect:/buycom.do?g_seq=" + response.item_code;

		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		// ????????? ????????? ???????????? ???????????? ??????????????????.
		return "redirect:/buy.do";
	}

	// ?????? ????????? ?????? url
	@RequestMapping("buyCancel.do")
	public String payCancel() {
		return "redirect:/buy.do";
	}

	// ?????? ????????? ?????? url
	@RequestMapping("buyFail.do")
	public String payFail() {
		return "redirect:/buy.do";
	}

	@RequestMapping("/interface.do")
	public String f6() {
		System.out.println("??????????????? ??????");
		return "interface";
	}

	@RequestMapping("/manual.do")
	public String manualOpen() {
		System.out.println("???????????? ??????");
		return "manual";
	}

	@RequestMapping("/text.do")
	public String f9() {
		System.out.println("????????? ??????");
		return "text";
	}

	// ???????????? ?????? ?????? ??? ??????
	@RequestMapping("/ledmodule.do")
	@ResponseBody
	public String Arduino(String keypad) {
		return doorbtn;
	}

	@RequestMapping("/BoxLed1.do")
	public String boxled1(String btn) {
		System.out.println("???????????? : "+btn);
		doorbtn = btn;

		return "redirect:/main.do";
	}

	@RequestMapping("/BoxLed2.do")
	public String boxled2(String btn) {
		System.out.println("???????????? : "+btn);
		doorbtn = btn;

		return "redirect:/main.do";
	}

	@RequestMapping("/BoxLed3.do")
	public String boxled3(String btn) {
		System.out.println("???????????? : "+btn);
		doorbtn = btn;

		return "redirect:/main.do";
	}

	@RequestMapping("/BoxLed4.do")
	public String boxled4(String btn) {
		System.out.println("???????????? : "+btn);
		doorbtn = btn;

		return "redirect:/main.do";
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

//	@GetMapping("/api/led")	
//	@ResponseBody
//	public Object GetLedList() {
//		return ledService.GetLedStatusList();	
//	}
//	
//	@GetMapping("/api/led/{id}")	
//	@ResponseBody
//	public Object GetLed(@PathVariable Integer id) {
//		return ledService.GetLedStatus(id);		
//	}
//	
//	@PutMapping("/api/led/{id}")	
//	@ResponseBody
//	public ResponseEntity<Object> PutLed(@PathVariable Integer id, Integer status) {
//		ledService.UpdateLedStatus(id, status);
//		System.out.println("led: " + id + ", status: " + status);
//		return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
//	}
	
//	@RequestMapping("/api/led")
//	@ResponseBody
//	public List<ledVO> Arduino() {
//		List<ledVO> list = ledService.dataLed();
//		System.out.println("???????????? ????????? data :" + list);
//		return list;
//	}
	

//	@RequestMapping("/BoxLed1.do")
//	public String boxled1(String btn, String status) {
//		doorbtn = btn;
//		ledVO vo = null;
//		System.out.println("??????  :" +status);
//		System.out.println("btn : " + btn);
//		int led_id = Integer.parseInt(btn);
//		int led_status = Integer.parseInt(status);
////		vo.setLed_id(number);
////		vo.setLed_status(Integer.parseInt(status));
//
//		int row = ledService.UpdateLed(led_id,led_status);
//		System.out.println("?????? : " + row);
//		//btn=1 ??????..
//		//BoxLed1??? ???????????? 1??? ??????????????????.
//		return "text";
//	}
	

	
}
