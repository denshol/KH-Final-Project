package com.kh.final3.payment.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.kh.final3.common.template.Pagination;
import com.kh.final3.common.vo.PageInfo;
import com.kh.final3.member.model.vo.Member;
import com.kh.final3.payment.model.vo.Payment;
import com.kh.final3.payment.service.PaymentService;

@RequestMapping(value= {"/member","/admin"})
@Controller
public class PaymentController {
	
	@Autowired
	private PaymentService paymentService;
	
	//일반회원 - 급여 조회 페이지 이동
	@RequestMapping("payment.me")
	public String paymentHome(int userNo) {
		
		return "payment/paymentView";
	}
	
	//관리자 - 급여 관리 페이지 이동 
	@RequestMapping("payment.ad")
	public ModelAndView paymentAdminHome(@RequestParam(value="currentPage", defaultValue="1") int currentPage, ModelAndView mv) {
		
		//전체 회원수 조회 
		int listCount = paymentService.selectMemberCount();
		int boardLimit = 10;
		int pageLimit = 5;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		//회원 조회 
		ArrayList<Member> mList = paymentService.selectMemberList(pi);
		
		mv.addObject("mList", mList).addObject("pi", pi).setViewName("payment/paymentList");
		
		return mv;
		
	}
	
	//관리자 - 급여 작성 페이지 이동 
	@RequestMapping("enrollPayment.ad")
	public ModelAndView enrollPayment(int userNo, ModelAndView mv) {
		
		//회원 기본정보 조회 -> 급여 작성페이지 이동(사번,이름,부서,직급,입사일, 은행, 계좌번호)
		Member mInfo = paymentService.selectMemberInfo(userNo);
		
		mv.addObject("mInfo", mInfo).setViewName("payment/enrollPaymentForm");
		
		return mv;
	}
	
	//관리자 - 급여 입력 메소드 
	@ResponseBody
	@RequestMapping("insertPayment.ad")
	public String insertPayment(Payment pay) {
		
		//해당 회원의 급여 명세서 이미 등록되었는지 확인 -> 등록하려고 하는 급여 명세서의 날짜와 기존 등록 날짜 비교 
		int userNo = pay.getUserNo();
		String month = pay.getMonthly().substring(0, 6);
		
		HashMap <String, Object> key = new HashMap <>();
		key.put("userNo", userNo);
		key.put("month", month);
		
		int count = paymentService.compareMonthly(key); 
		
		if(count<0) { //등록된 명세서 없음 
			
			int result = paymentService.insertPayment(pay);
			return (result>0)? "YYYY":"NNNN";
			
		}else {// 등록된 명세서 있음 
			
			return "duplicate";
		}
		
	}
	
	//관리자 - 해당 회원의 급여 명세서 목록 조회 
	@ResponseBody
	@RequestMapping(value="list.pa", produces = "application/json; UTF-8")
	public String selectPaymentList (int userNo) {
		
		ArrayList <Payment> pList = paymentService.selectPaymentList(userNo);
		
		return new Gson().toJson(pList);
	}
	
	//관리자 - 급여 계좌 관리 페이지 이동 
	@RequestMapping("account.ad")
	public ModelAndView accountList(@RequestParam(value="currentPage", defaultValue="1") int currentPage, ModelAndView mv) {
		
		//계좌 미등록, 계좌 변경 신청 회원 숫자 조회 
		int listCount = paymentService.selectAccount();
		int boardLimit =10;
		int pageLimit = 5;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		//계좌 미등록, 계좌 변경 신청 회원 목록 조회 
		ArrayList <Member> mList = paymentService.selectAccountList(pi);
		
		mv.addObject("mList", mList).addObject("pi", pi).setViewName("payment/accountList");
		
		return mv;
	}
	
	//관리자 - 급여 관리 검색 필터 
	@ResponseBody
	@RequestMapping("search.pa")
	public ModelAndView searchPayment(@RequestParam(value="currentPage", defaultValue="1") int currentPage,String deptCode, String keyword ,ModelAndView mv) {
		
		HashMap <String, String> key = new HashMap<>();
		
		key.put("deptCode", deptCode);
		key.put("keyword", keyword);
		
		//필터에 해당하는 회원수 조회 
		int listCount = paymentService.selectSearchMemberCount(key);
		int boardLimit = 10;
		int pageLimit =5;
		
		System.out.println(listCount);
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList <Member> mList = paymentService.selectSearchMemberList(key,pi);
		
		System.out.println(mList);
		
		mv.addObject("mList", mList)
		  .addObject("pi", pi)
		  .addObject("keyword", keyword)
		  .addObject("deptCode", deptCode)
		  .setViewName("payment/paymentList");
		
		return mv;
	}
}
