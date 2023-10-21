package com.kh.final3.approval.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.kh.final3.approval.model.service.ApprovalService;
import com.kh.final3.approval.model.vo.Approval;
import com.kh.final3.approval.model.vo.ApprovalAttachment;
import com.kh.final3.approval.model.vo.ApprovalDoc;
import com.kh.final3.approval.model.vo.DocType;
import com.kh.final3.approval.model.vo.Item;
import com.kh.final3.approval.model.vo.Leave;
import com.kh.final3.common.template.Pagination;
import com.kh.final3.common.template.SaveFile;
import com.kh.final3.common.vo.PageInfo;
import com.kh.final3.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping(value = {"/member", "/admin"}, method= {RequestMethod.GET,RequestMethod.POST})
public class ApprovalController {
	@Autowired
	private ApprovalService as;
	
	@RequestMapping("home.ap")
	public String approvalHome() {
		return "approval/approvalHome";
	}
	
	@RequestMapping("list.ap")
	public String approvalList(@RequestParam(value="currentPage",defaultValue="1")int currentPage,HttpServletRequest request, Model m) {
		String status = request.getParameter("status");
		int listCount = as.selectListCount(status);
		int pageLimit = 20;
		int boardLimit = 10;
		
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		ArrayList<ApprovalDoc> list = as.selectApprovalDocList(pi,status);
		m.addAttribute("list",list).addAttribute("pi",pi).addAttribute("status", status);
		return "approval/approvalListView";
	}
	//검색
	@RequestMapping("search.ap")
	public String searchApprovalDocList(@RequestParam(value="currentPage",defaultValue="1")int currentPage
								,String option, String keyword, Model m, String status) {
		HashMap<String, String> map = new HashMap<>();
		map.put("option", option);
		map.put("keyword", keyword);
		map.put("status",status);
		
		int listCount = as.searchApprovalCount(map);
		int pageLimit = 20;
		int boardLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		ArrayList<ApprovalDoc> list = as.searchApprovalDocList(map, pi);
		log.info(String.valueOf(listCount));
		System.out.println(list);
		
		
		m.addAttribute("option", option).addAttribute("keyword",keyword)
		 .addAttribute("list", list).addAttribute("pi",pi);
		return "approval/approvalListView";
	}
	@ResponseBody
	@RequestMapping(value="approvalMainList.ap", produces="application/json; charset=UTF-8")
	public String approvalMainList(String status) {
		ArrayList<ApprovalDoc> list = as.approvalMainList(status);
		
		return new Gson().toJson(list);
	}
	
	@RequestMapping("enrollList.ap")
	public String enrollList(Model m) {
		ArrayList<DocType> list = as.selectEnrollList();
		
		m.addAttribute("list",list);
		return "approval/enrollListView";
	}
	
	@RequestMapping("enrollForm.ap")
	public ModelAndView enrollForm(HttpServletRequest request, ModelAndView mv) {
		int appNo = Integer.parseInt(request.getParameter("appNo"));
		
		if(appNo==1) {
			mv.setViewName("approval/leaveForm");
		}else if(appNo==2) {
			
			mv.setViewName("approval/itemForm");
		}else if(appNo==3) {
			mv.setViewName("approval/minutes");
		}
		return mv;
	}
	
//	결재자 조회
	@ResponseBody
	@PostMapping(value="selectApproverList.ap",produces = "application/json; charset=UTF-8")
//	@RequestMapping(value="selectApproverList.ap", method = {RequestMethod.GET,RequestMethod.POST}, produces = "application/json; charset=UTF-8")
	public String selectApproverList(String deptCode) {
		ArrayList<Member> list = as.selectApproverList(deptCode);
		return new Gson().toJson(list);
	}
	//결재자 검색
	@ResponseBody
	@PostMapping(value="searchApprover.ap",produces = "application/json; charset=UTF-8")
//	@RequestMapping(value="searchApprover.ap",method = {RequestMethod.GET,RequestMethod.POST},produces="application/json; charset=UTF-8")
	public String searchApprover(String status, String keyword){
		HashMap<String, String> map = new HashMap<>();
		
		map.put("status", status);
		map.put("keyword", keyword);
		
		ArrayList<Member> list = as.searchApproverList(map);

		return new Gson().toJson(list);
	}
	
	//구매품의서
	@RequestMapping("item.ap")
	public ModelAndView insertItem(Item i, ApprovalDoc ad,ApprovalAttachment at, Approval a,ModelAndView mv,HttpSession session, ArrayList<MultipartFile> upfile){
		ArrayList<ApprovalAttachment> atList = new ArrayList<>();
		ArrayList<Item> iList = new ArrayList<>();
		
		//파일 첨부
			for(MultipartFile file : upfile) {
				if(!file.getOriginalFilename().equals("")) {
					String changeName = new SaveFile().getSaveFile(file, session);
					
					String filePath = session.getServletContext().getRealPath("/resources/uploadFiles/approvalDoc/");
					
					try {
						file.transferTo(new File(filePath+changeName));
					} catch (IllegalStateException | IOException e) {
						e.printStackTrace();
					}
					
					at = ApprovalAttachment.builder().originName(file.getOriginalFilename())
																		.changeName(changeName)
																		.deptCode(ad.getDeptCode()).build();
					
					atList.add(at);
				}
			}
		//item 리스트
		for(int j=0;j<i.getArrSupplyName().length;j++) {
			Item i2 = new Item();
			
			String supplyName = i.getArrSupplyName()[j];
			String supplySize = i.getArrSupplySize()[j];
			String amount = i.getArrAmount()[j];
			String price = i.getArrPrice()[j];
			
			i2.setDeptCode(i.getDeptCode());
			i2.setSupplyName(supplyName);
			i2.setSupplySize(supplySize);
			i2.setAmount(amount);
			i2.setPrice(price);
			
			iList.add(j, i2);
		}
		int result = as.insertItem(iList,atList,ad,a);
		if(result>0) {
			session.setAttribute("alertMsg", "결재등록이 완료되었습니다.");
			mv.setViewName("redirect:list.ap");
		}else {
			for(ApprovalAttachment aa : atList) {
				new File(session.getServletContext().getRealPath(aa.getFilePath())).delete();
			}
			session.setAttribute("alertMsg", "결재등록에 실패하였습니다.");
			mv.setViewName("redirect:list.ap");
		}
		return mv;
	}
	//휴가계
		@RequestMapping("leave.ap")
		public ModelAndView insertItem(Leave l, ApprovalDoc ad,ApprovalAttachment at, Approval a,ModelAndView mv,HttpSession session, ArrayList<MultipartFile> upfile){
			ArrayList<ApprovalAttachment> atList = new ArrayList<>();
			ArrayList<Leave> leaveList = new ArrayList<>();
			
			//파일
				for(MultipartFile file : upfile) {
					if(!file.getOriginalFilename().equals("")) {
						String changeName = new SaveFile().getSaveFile(file, session);
						
						String filePath = session.getServletContext().getRealPath("/resources/uploadFiles/approvalDoc/");
						
						try {
							file.transferTo(new File(filePath+changeName));
						} catch (IllegalStateException | IOException e) {
							e.printStackTrace();
						}
						
						at = ApprovalAttachment.builder().originName(file.getOriginalFilename())
																			.changeName(changeName)
																			.filePath(filePath+changeName)
																			.deptCode(ad.getDeptCode()).build();
						
						atList.add(at);
					}
				}
			
			//leave 리스트
			for(int i=0;i<l.getArrLeaveStatus().length;i++) {
				Leave ll = new Leave();
				
				String leaveCode = l.getArrLeaveCode()[i];
				String startDate = l.getArrStartDate()[i];
				String endDate = l.getArrEndDate()[i];
				String leaveStatus = l.getArrLeaveStatus()[i];
				
				ll.setDeptCode(l.getDeptCode());
				ll.setWorkReceiver(l.getWorkReceiver());
				ll.setLeaveCode(leaveCode);
				ll.setStartDate(startDate);
				ll.setEndDate(endDate);
				ll.setLeaveContent(l.getLeaveContent());
				ll.setLeaveStatus(leaveStatus);
				
				leaveList.add(i, ll);
			}
			int result = as.insertLeave(leaveList,atList,ad,a);
			
			if(result>0) {
				session.setAttribute("alertMsg", "결재등록이 완료되었습니다.");
				mv.setViewName("redirect:list.ap");
			}else {
				for(ApprovalAttachment aa : atList) {
					new File(session.getServletContext().getRealPath(aa.getFilePath())).delete();
				}
				session.setAttribute("alertMsg", "결재등록에 실패하였습니다.");
				mv.setViewName("redirect:list.ap");
			}
			
			return mv;
		}
		@RequestMapping("detail.ap")
		public ModelAndView detailApp(int docNo, String docType, ModelAndView mv) {
			Approval a = as.selectApproval(docNo);
			ArrayList<ApprovalAttachment> at = as.selectApprovalAttachment(docNo);
			ApprovalDoc ad = as.selectApprovalDoc(docNo);
			ArrayList<Item> iList = new ArrayList<>();
			ArrayList<Leave> lList = new ArrayList<>();
			
			if(docType.equals("구매품의서")) {
				iList = as.selectItem(docNo);
				mv.addObject("a",a).addObject("at",at).addObject("ad", ad)
				.addObject("iList", iList)
				.setViewName("approval/itemDetailView");
				
			}else if(docType.equals("휴가계")) {
				lList = as.selectLeave(docNo);
				mv.addObject("a",a).addObject("at",at).addObject("ad", ad)
				.addObject("lList", lList)
				.setViewName("approval/leaveDetailView");
			}
			
			return mv;
			
		}
		//중간결재자 반려
		@ResponseBody
		@PostMapping("updateSecondReturnReason.ap")
		public int updateSecondReturnReason(Approval a) {
			int result = as.updateSecondReturnReason(a);
			return result;
		}
		
		//최종결재자 반려
		@ResponseBody
		@PostMapping("updateLastReturnReason.ap")
		public int updateLastReturnReason(Approval a, ApprovalDoc ad) {
			int result = as.updateLastReturnReason(a,ad);
			return result;
		}
		
		//중간결재자 승인
		@ResponseBody
		@PostMapping("updateSecondApprover.ap")
		public int updateSecondApprover(Approval a) {
			int result = as.updateSecondApprover(a);
			return result;
		}
		
		//최종결재자 승인
		@ResponseBody
		@PostMapping("updateLastApprover.ap")
		public int updateLastApprover(Approval a, ApprovalDoc ad) {
			int result = as.updateLastApprover(a,ad);
			return result;
		}
		
		//그래프
		@ResponseBody
		@GetMapping(value="monthData.ap",produces="application/json; charset=UTF-8")
		public String monthData(ModelAndView mv, ApprovalDoc ad) {
			List<ApprovalDoc> list = as.monthData(ad);
			
			Iterator<ApprovalDoc> it = list.iterator();
			
			JsonArray jArr = new JsonArray();
			
			while(it.hasNext()){
				ad = it.next();
				JsonObject obj = new JsonObject();
				
				String createDate = ad.getCreateDate();
				int approval = ad.getApproval();
				int reject = ad.getReject();
				
				obj.addProperty("createDate", createDate);
				obj.addProperty("approval", approval);
				obj.addProperty("reject", reject);
				jArr.add(obj);
			}
			return new Gson().toJson(jArr);
		}
}