package com.kh.final3.payment.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.final3.common.vo.PageInfo;
import com.kh.final3.member.model.vo.Member;
import com.kh.final3.payment.dao.PaymentDao;
import com.kh.final3.payment.model.vo.Payment;

@Service
public class PaymentServiceImpl implements PaymentService {
	
	@Autowired
	private PaymentDao paymentDao;
	
	@Autowired
	private SqlSession sqlSession;
	
	//전체 회원수 조회
	@Override
	public int selectMemberCount() {

		return paymentDao.selectMemberCount(sqlSession);
	}
	
	//관리자 - 회원 목록 조회 
	@Override
	public ArrayList<Member> selectMemberList(PageInfo pi) {
		
		return paymentDao.selectMemberList(sqlSession, pi);
	}

	//관리자- 회원 기본정보 조회 
	@Override
	public Member selectMemberInfo(int userNo) {

		return paymentDao.selectMemberInfo(sqlSession, userNo);
	}
	
	//월별 비교 메소드 - 관리자 
	@Override
	public int compareMonthly(HashMap<String, Object> key) {

		return paymentDao.compareMonthly(sqlSession, key);
	}
	
	//관리자-급여 입력 
	@Override
	public int insertPayment(Payment pay) {

		return paymentDao.insertPayment(sqlSession, pay);
	}
	
	//관리자-급여 목록 조회 
	@Override
	public ArrayList<Payment> selectPaymentList(int userNo) {

		return paymentDao.selectPaymentList(sqlSession, userNo);
	}

	//관리자 - 급여계좌 미등록, 변경 신청 개수 조회 
	@Override
	public int selectAccount() {

		return paymentDao.selectAccount(sqlSession);
	}
	//관리자 - 계좌 미등록, 계좌 변경 신청 회원 목록 조회 
	@Override
	public ArrayList<Member> selectAccountList(PageInfo pi) {

		return paymentDao.selectAccountList(sqlSession, pi);
	}
	
	//관리자 - 필터에 해당하는 회원수 조회
	@Override
	public int selectSearchMemberCount(HashMap<String, String> key) {

		return paymentDao.selectSearchMemberCount(sqlSession, key);
	}

	//관리자 - 필터에 해당하는 회원수 목록 조회 
	@Override
	public ArrayList<Member> selectSearchMemberList(HashMap<String, String> key,PageInfo pi) {

		return paymentDao.selectSearchMemberList(sqlSession,pi,key);
	}
	
	

}
