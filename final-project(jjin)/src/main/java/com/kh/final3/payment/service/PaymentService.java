package com.kh.final3.payment.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.final3.common.vo.PageInfo;
import com.kh.final3.member.model.vo.Member;
import com.kh.final3.payment.model.vo.Payment;

public interface PaymentService {
	
	//회원 전체수 조회 
	int selectMemberCount();
	
	//회원 목록 조회 
	ArrayList<Member> selectMemberList(PageInfo pi);
	
	//회원 기본정보 조회 
	Member selectMemberInfo(int userNo);
	
	//월별 비교 메소드 - 관리자 
	int compareMonthly(HashMap<String, Object> key);
	
	//급여 입력 - 관리자
	int insertPayment(Payment pay);
	
	//급여 목록 조회 - 관리자 
	ArrayList<Payment> selectPaymentList(int userNo);
	
	//미등록, 계좌변경 신청수 조회 -관리자  
	int selectAccount();
	
	//계좌 미등록, 계좌 변경 신청 회원 목록 조회  - 관리자 
	ArrayList<Member> selectAccountList(PageInfo pi);

	//필터에 해당하는 회원수 조회 - 관리자 
	int selectSearchMemberCount(HashMap<String, String> key);

	//필터에 해당하는 회원수 목록 조회 - 관리자 
	ArrayList<Member> selectSearchMemberList(HashMap<String, String> key, PageInfo pi);


}
