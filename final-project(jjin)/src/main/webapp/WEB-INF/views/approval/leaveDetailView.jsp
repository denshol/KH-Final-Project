<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
	<%@ include file="../common/menubar.jsp" %>
    <link rel="stylesheet" href="/final3/resources/css/Approval_LeaveDetail.css" >
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Song+Myung&display=swap" rel="stylesheet">
</head>
<body>
	<br><br><br><br>
    <h1 align="center">휴가계</h1>
    <br><br>
        <div class="leave-area">
            <input type="hidden" name="deptCode" value="${loginUser.deptCode }">
            <input type="hidden" name="docType" value="1">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <input type="hidden" name="docWriter" value="${loginUser.userNo}">
            <c:if test="${(a.secondApproverNo == loginUser.userNo) || (a.lastApproverNo == loginUser.userNo) }">
	            <div id="leave-btn-area">
	                <button type="button" class="btn btn-primary" id="approval-btn" onclick="approval();">승인</button>
    	            <button type="button" class="btn btn-danger" id="reject-btn" data-bs-toggle="modal" data-bs-target="#rejectModal">반려</button>
    	            <button type="button" class="btn btn-success" onclick="saveApproval();">나가기</button>
        	        <input type="checkbox" id="emergency-btn" value="${ad.emergency }"><label for="긴급">긴급문서</label>
	            </div>
           	</c:if>
            <div id="leave-header">
            	<c:choose>
               		<c:when test="${!empty a.secondApprover }">
			    		<table class='table table-bordered' id='approver-signature'>
			                <tbody>
			                    <tr><th width="20px" rowspan="4">결재</th></tr>
			                    <tr><td><input type="text" value="${a.lastJobName}" readonly/></td></tr>
			                    <tr height="50px"><td><input type="text" id="lastApprover" value="${a.lastApprover }" readonly/></td></tr>
			                    <tr height="80px"><td><input type="text" id="lastSignature" value="${a.lastSignature }" style="font-family: 'Song Myung', serif;font-size: 20px" readonly/></td></tr>
			                </tbody>
			    		</table>
               			<table class='table table-bordered' id='approver-signature'>
			                <tbody>
			                    <tr><th width="20px" rowspan="4">결재</th></tr>
			                    <tr><td><input type="text" value="${a.secondJobName}" readonly/></td></tr>
			                    <tr height="50px"><td><input type="text" id="secondApprover" value="${a.secondApprover}" readonly/></td></tr>
			                    <tr height="80px"><td><input type="text" id="secondSignature" value="${a.secondSignature }" style="font-family: 'Song Myung', serif;font-size: 20px" readonly/></td></tr>
			                </tbody>
			    		</table>
               		</c:when>
               		<c:otherwise>
               			<table class='table table-bordered' id='approver-signature'>
			                <tbody>
			                    <tr><th width="20px" rowspan="4">결재</th></tr>
			                    <tr><td><input type="text" value="${a.lastJobName}" readonly/></td></tr>
			                    <tr height="50px"><td><input type="text" id="lastApprover" value="${a.lastApprover }" readonly/></td></tr>
			                    <tr height="80px"><td><input type="text" id="lastSignature" value="${a.lastSignature }" style="font-family: 'Song Myung', serif;font-size: 20px" readonly/></td></tr>
			                </tbody>
			    		</table>
               		</c:otherwise>
               </c:choose>
            </div>
            <div id="leave-content">
                <div id="leave-content1">
                    <table class="table table-bordered" width="100%" height="100%" style="border-collapse: collapse;vertical-align: middle">
                        <tr>
                            <th width="13%">작성자</th>
                            <td><input type="text" id="docWriter" value="${ad.userName }" readonly></td>
                            <th width="13%">전화번호</th>
                            <td><input type="text" id="phone" name="phone" value="${ad.phone }" readonly></td>
                            <th width="13%">문서번호</th>
                            <td><input type="text" id="docNo" value="${ad.docNo }" readonly></td>
                        </tr>
                        <tr>
                            <th>제목</th>
                            <td colspan="5"><input type="text" id="docTitle" name="docTitle" value="${ad.docTitle }"></td>
                        </tr>
                    </table>
                </div>
                <br><br><br>
                <div id="leave-content2">
                    <table class="table table-bordered" style="text-align: center;">
                    	<tbody>
                            <th width="15%">연차현황</th>
                            <th width="15%">발생현황</th>
                            <td><input type="text" value="" id="total-leave" readonly></td>
                            <th width="15%">사용현황</th>
                            <td><input type="text" value="" id="use-leave" readonly></td>
                            <th width="15%">잔여현황</th>
                            <td><input type="text" value="" id="remain-leave" readonly></td>
                        </tbody>
                    </table>
                    <table class="table table-bordered" style="text-align: center;" id="leave-table">
                        <thead>
                            <tr>
                                <th width="16%">휴가신청구분</th>
                                <th width="15%">휴가구분</th>
                                <th width="15%">시작일</th>
                                <th width="15%">종료일</th>
                                <th width="15%">기간</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:set var="arrayLength" value='${fn:length(lList)}' />
                        	<c:forEach var="l" items="${lList }">
	                            <tr>
	                                <td>
	                                     ${l.leaveStatus}
	                                </td>
	                                <td>
	                                     ${l.leaveCode}
	                                </td>
	                                <td>
	                                	<input type="text" id="start-date" value="${l.startDate}" readonly>
	                                </td>
	                                <td>
	                                    <input type="text" id="end-date" value="${l.endDate}" readonly>
	                                <td>
	                                    <input type="text" id="total-date" value="" readonly>
	                                </td>
	                            </tr>
	                            <tr>
	                            <th colspan="6">사유</th>
	                            </tr>
	                            <tr>
	                                <td colspan="6">
	                                    <textarea>${l.leaveContent}</textarea>
	                                </td>
	                            </tr>
	                            <tr>
	                                <th colspan="3" style="vertical-align: middle;" >업무인수자</th>
	                                <td colspan="3">
	                                    <input type="text" name="workReceiver" value="${l.workReceiver }" style="width: 80%;vertical-align: middle;" >
	                                </td>
	                            </tr>
                        	</c:forEach>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="6">
                                    <pre name="leave-notice" id="leave-notice" readonly>
[증빙서류 첨부안내]
(1) 훈련
- 예비군/민방위 훈련 확인서
(2) 휴직
- 병가휴직 : 1개월 이상 3개월 이내 의사 진단서
(3) 출산
- 본인출산(女) : 출산예정일이 적힌 산모수첩이나 의사진단서
- 배우자 출산휴가(男) : 출생증명서
                                    </pre>
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                    <br><br>
                    <div class="mb-3" id="file-area">
                        <table class="table table-bordered" id="file-table" >
				            <thead>
				                <tr>
				                    <th width="5%"></th>
					                <th>첨부파일</th>          
				                </tr>
				            </thead>
				            <tbody>
				            	<c:forEach var="at" items="${at}">
				                <tr>
				                    <td></td>
				                    <td><a href="/final3${at.filePath }" download="${at.originName }" style="float:left">${at.originName}</a></td>
				                </tr>
				                </c:forEach>
				            </tbody>
				        </table>
                    </div>
                </div>
            </div>
        </div>
		<!-- 반려 이유 입력 -->
	<div class="modal fade" id="rejectModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel">반려사유</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
		      <textarea name="returnReason" id="returnReason">${a.returnReason}</textarea>	      
		  </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	        <button type="button" class="btn btn-primary" onclick="updateReject();">완료</button>
	      </div>
	    </div>
	  </div>
	</div>
	<script>
	//시간 계산
	$(function(){
		for(var i=0;i<"${arrayLength}";i++){
		var startDate = new Date($("#start-date").val());
		var endDate = new Date($("#end-date").val());
		
		var timeDiff = endDate.getTime()-startDate.getTime();
		
		var dayDiff = Math.floor(timeDiff/(1000*60*60*24));
		
		$("#total-date").attr("value",dayDiff);
		}
	});
		
	//긴급문서 체크
	$(function(){
		var result = $("#emergency-btn").val();
		
		if(result == 'Y'){
			$("#emergency-btn").attr("checked",true);
		}else{
			$("#emergency-btn").attr("checked",false);
		}
	});
	//승인
	function approval(){
		var loginUserNo = "${loginUser.userNo}";
		var loginUserName = "${loginUser.userName}"
		var lastApprover = "${a.lastApproverNo}";
		var secondApprover = "${a.secondApproverNo}";
		var docNo = "${ad.docNo}";
		
		if(loginUserNo === secondApprover){
			$.ajax({
				url : "updateSecondApprover.ap",
				type : "POST",
				data : {
					secondSignature : loginUserName,
					docNo : docNo
				},
				beforeSend : function(xhr)
                {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
				success : function(result){
					if(result>0){
						$("#secondSignature").attr("value",loginUserName);
    					alert("승인이 완료되었습니다.")
					}
				},
				error : function(){
					console.log("통신오류")
				}
			});
		}else if(loginUserNo===lastApprover){
			if("${a.secondApprover}" ==null){
				alert("중간결재자의 승인이 누락되었습니다.");
			}else{
				$.ajax({
    				url : "updateLastApprover.ap",
    				type : "POST",
    				data : {
    					lastSignature : loginUserName,
    					docNo : docNo,
    					status:'Y'
    				},
    				beforeSend : function(xhr)
                    {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                    },
    				success : function(result){
    					console.log(result)
    					if(result>0){
    						$("#lastSignature").attr("value",loginUserName);
    						$("#approval-btn").attr("disabled",true);
    						$("#reject-btn").attr("disabled",true);
    						$("#emergency-btn").attr("checked",false);
    						alert("승인이 완료되었습니다.");
    					}
    				},
    				error : function(){
    					console.log("통신오류")
    				}
    			})
			}
		}
	}
	//반려
	function updateReject(){
		var loginUserNo = "${loginUser.userNo}";
		var lastApprover = "${a.lastApproverNo}";
		var secondApprover = "${a.secondApproverNo}";
		var docNo = "${ad.docNo}";
		var returnReason = $("#returnReason").val();
		
		if(secondApprover == loginUserNo){
			if(confirm("반려하시겠습니까?")){
	    		$.ajax({
					url: "updateSecondReturnReason.ap",
					type:"POST",
					data:{
						returnReason:returnReason,
						docNo : docNo,
					},
					beforeSend : function(xhr)
	                {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
	                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	                },
					success : function(result){
						if(result>0){
							$("#secondSignature").attr("value","반려");	
						}else{
							console.log("실패");
						}
					},
					error : function(){
						console.log("통신오류");
					}
				});
			}
		}else if(loginUserNo == lastApprover){
			if("${a.secondApprover}" ==null){
				alert("중간결재자의 승인이 누락되었습니다.");
			}else if(confirm("반려하시겠습니까?")){
	    		$.ajax({
					url: "updateLastReturnReason.ap",
					type:"POST",
					data:{
						returnReason:returnReason,
						docNo : docNo,
						status:'R'
					},
					beforeSend : function(xhr)
	                {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
	                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	                },
					success : function(result){
						if(result>0){
							$("#emergency-btn").attr("checked",false);
							$("#lastSignature").attr("value","반려");	
							$("#returnReason").attr("readonly",true);
							$("#approval-btn").attr("disabled",true);
							$("#reject-btn").attr("disabled",true);
						}else{
							console.log("실패");
						}
					},
					error : function(){
						console.log("통신오류");
					}
				});
			}
		}
		$("#rejectModal").modal('hide');
	}
	
	//반려와 승인이이후 버튼 막기
	$(function(){
		var status = "${ad.status}"
		if(status == 'Y'){
			$("#approval-btn").attr("disabled",true);
			$("#reject-btn").attr("disabled",true);
			$("#emergency-btn").attr("checked",false);
		}else if(status=='R'){
			$("#approval-btn").attr("disabled",true);
			$("#reject-btn").attr("disabled",true);
			$("#emergency-btn").attr("checked",false);
		}
	});
	function saveApproval(){
		location.href ="list.ap";
	}
	</script>
   </body>
</html>