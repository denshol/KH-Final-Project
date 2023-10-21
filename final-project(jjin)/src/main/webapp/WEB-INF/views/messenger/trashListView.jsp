<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴지통</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
	.messenger_content {
	    background-color:#0E6251;
	    width:100%;
	    height: 750px;
	    margin:auto;
	}
	.innerOuter {
	    border:1px solid lightgray;
	    width:80%;
	    height:100%;
	    margin:auto;
	    padding:3% 7%;
	    background-color:white;
	}
    
    /* navi + 검색창 영영  */    
	.innerOuter>#msg_header{
		width:100%;
		height: 130px;
		margin-top: 10px;
		margin-bottom : 10px;
	}
    /* navi 영역 */
    #msg_header>#msg_nav{
       	width: 25%;
       	height: 100%;
       	float : left;
    }
        
	#msg_nav>ul{
		list-style-type: none;
		padding: 0;
		margin : 0;
		
	}
        
    #msg_nav li a{
		text-decoration-line: none;
		color: black;
		font-size: 20px;
		font-weight: 700;
	}

	#msg_nav li a:hover{
		font-size :23px;
		color: #009966;	
	}

	/* msg_search area */
    #msgSearchForm{
		width: 75%;
        height: 100%; 
        float : left;
         
   	}
      
     #msgSearchForm>form{
      	width:100%;
      	height:100%;
      	display : flex; /* 중앙정렬 방법 - 부모 요소 고정 */
      	justify-content: left; /* 자식 요소들 가운데로 이동  */
		align-items: center;
	}
      
    form>.custom-select{
    	width: 20%;
    	float:left;
    	margin-right:5px;
	}
      
    form .form-control{
    	width: 40%;
    	float:left;
    	margin-right: 5px;
	}
	
	/* list- button 영역 */
	#msg_list>#msg_btn_area{
		width : 100%;
		margin-top : 10px;
		margin-bottom :20px;
	}  
  
	#trashList {
      	text-align:center;
	}
      
    #trashList>tbody>tr:hover {
      	cursor:pointer;
   	}
	
	#pagingArea {
      
      width:fit-content;
      margin:auto;
   	}
      
</style>
</head>
<body>
	<div class="messenger_content">
	<div class="innerOuter">
		<h2 style="font-weight:800;" > 휴지통 </h2> 
		<div id="msg_header">
			<!-- 쪽지 네비영역 -->
			<div id="msg_nav">
				<ul>
					<li><a href="insert.mg">쪽지쓰기</a></li>
					<li><a href="list.mg">받은쪽지함</a></li>
					<li><a href="slist.mg">보낸쪽지함</a></li>
					<li><a href="tlist.mg">휴지통</a></li>
				</ul>
			</div>
	        <!-- 쪽지 검색 영역 -->
	        <div id="msgSearchForm">
		        <form action="trashSearch.mg" method="get">
		        	<select id="option-box" class="custom-select" name="category">
		            	<option value="send">받은쪽지</option> <!-- 나한테 보낸사람 -->
		            	<option value="receive">보낸쪽지</option> <!-- 내가 보낸사람  -->
						<option value="title">제목</option>
		           	</select>
		            <input type="text" class="form-control" name="keyword" value="${keyword}" required>
		            <input type="hidden" value="${loginUser.userNo}" name="userNo">
					<button type="submit" class="btn btn-secondary">검색</button>
		    	</form>
	        </div>
	        <c:if test ="${not empty category }">
	        <script>
	        	$(function(){
	        		$("#option-box option[value = '${category}']").attr("selected", true)
	        	});
	        
	        </script>
	        </c:if>
	        
		</div>		
		<div id="msg_list">
			<div id="msg_btn_area">
				<button id="trash-delete" class="btn btn-danger">삭제</button> 
				<button id="trash-recover" class="btn btn-success">복구</button> 
			</div>
            <table id="trashList" class="table table-hover" align="center">
                <thead>
                    <tr>
                        <th width="10%">선택</th>
                        <th width="20%">보낸사람/받는사람</th>
                        <th width="40%">제목</th>
                        <th width="30%">날짜</th>
                    </tr>
                </thead>
                <tbody>
                	<c:choose>
                		<c:when test="${empty tList}">
                			<tr>
                				<td colspan ="4">삭제된 쪽지가 없습니다.</td>
                			</tr>
                		</c:when>
                		<c:otherwise>
               			<c:forEach var='t' items="${tList}">
               				<tr>
               					<td onclick="event.cancelBubble=true"><input type="checkbox" style="width:15px; height:15px;">
               						<input type="hidden" value="${t.recvDelete}">
               					</td>
               					<c:choose>
                					<c:when test="${t.recvrUno eq loginUser.userNo}">
                						<td><label style="font-weight: 600; margin-bottom:0px;">[받은쪽지]</label> ${t.sender}</td>
                					</c:when>
               						<c:otherwise>
               							<td><label style="font-weight: 600; margin-bottom:0px;">[보낸쪽지]</label> ${t.receiver}</td>
               						</c:otherwise>
               					</c:choose>
               					<c:choose>
               						<c:when test="${t.readStatus eq 'Y'}">
                       					<td style="text-align: left;">${t.msgTitle}</td>
                       				</c:when>
                       				<c:otherwise>
                       						<td style="text-align: left; font-weight:700;">${t.msgTitle}</td>
                       				</c:otherwise>
                       			</c:choose>
                       			<td>${t.sendDate}<input type="hidden" value="${t.messengerNo}"></td>
               				</tr>
               			</c:forEach>
               		</c:otherwise>
                	</c:choose>
                </tbody>
            </table>
		</div>
		<br>
		<div id="board-pagebar-area">
            <div id="pagingArea">
                <ul class="pagination">
                	<c:choose>
                		<c:when test="${pi.currentPage eq 1 }">
	                        <li class="page-item disabled"><a class="page-link">이전</a></li>
                   		</c:when>
                   		<c:otherwise>
	                        <li class="page-item"><a class="page-link" href="tlist.mg?currentPage=${pi.currentPage-1}">이전</a></li>
                   		</c:otherwise>
                   	</c:choose>
                   	<c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
                        <li class="page-item"><a class="page-link" href="tlist.mg?currentPage=${p}">${p}</a></li>
                   	</c:forEach>
                   	<c:choose>
                   		<c:when test="${pi.maxPage eq pi.currentPage}">
	                        <li class="page-item disabled"><a class="page-link">다음</a></li>
                   		</c:when>
                   		<c:otherwise>
	                        <li class="page-item"><a class="page-link" href="tlist.mg?currentPage=${pi.currentPage+1}">다음</a></li>
                   		</c:otherwise>
                	</c:choose>
                </ul>
            </div>
		</div>   
		
		<script>
			/* 상세페이지 이동 script */
			$(function(){
				$("#trashList>tbody tr ").on("click","td", function(){
					
					//console.log($(this).siblings().eq(2).children().val());
					var msgNo = $(this).siblings().eq(2).children().val();
					
					location.href="messenger.mg?msgNo="+msgNo;
					
				});	
			})
			
			/*선택 삭제 or 선택 복구 script*/
			$(function(){
				var sendArr = [];
				var recvArr = [];
				
				//체크 박스 선택시, 받은 쪽지함에서 삭제된 쪽지와 보낸 쪽지함에서 삭제된 쪽지 나눠서 배열에 담기 
				$("#trashList>tbody td").on("click","input[type=checkbox]", function(){
					
					//console.log($(this).parent().siblings().eq(2).children().val())
					var $msgNo = $(this).parent().siblings().eq(2).children().val();
					
					var $status = $(this).next().val() //recv_delete 상태값 => K라면 받은 쪽지함에서 삭제 된것,N 이라면 보낸쪽지함에서 삭제된 것 	
					console.log("상태값: ",$status)
					if($(this).prop("checked") == true){
						if($status == 'K'){
							recvArr.push($msgNo)
						}else{
							sendArr.push($msgNo)
						}
					}else{
						if($status == 'K'){
							for(var i = 0 ; recvArr.length ; i++){
								if(recvArr[i] === $msgNo){
									recvArr.splice(i,1);
								}
							}
						}else{
							for(var i = 0 ; sendArr.length ; i++){
								if(sendArr[i] === $msgNo){
									sendArr.splice(i,1);
								}
							}
						}
					}
					
				});	
				
				//삭제버튼 클릭시 발생 이벤트 
				$("#trash-delete").on("click", function(){
					if((recvArr.length == 0) && (sendArr.length == 0)){
						alert("삭제하실 쪽지를 선택해주세요.")
					}else{
						if(confirm("삭제된 쪽지는 복구가 불가능합니다. 삭제하시겠습니까?")){
							
							if(recvArr.length == 0){
								
								$.ajax({
									url : "sendMsgUpdate.mg",
									
									type :"get",
		            				
		            				traditional: true, //배열 넘기는 옵션
									
		            				data : {msgNoArr : sendArr},
									
									success : function(result){
										
										if(result == "YYYY"){
											alert("쪽지가 삭제되었습니다.")
										}else{
											alert("쪽지 삭제에 실패하였습니다. 다시 시도해 주세요 ")
										}
										
										location.reload();
									}
								
								});
							}else if(sendArr.length == 0) {
								
								$.ajax({
									url : "recvMsgUpdate.mg",
									
									type :"get",
		            				
		            				traditional: true, //배열 넘기는 옵션
									
		            				data : {msgNoArr : recvArr},
									
									success : function(result){
										if(result == "YYYY"){
											alert("쪽지가 삭제되었습니다.")
										}else{
											alert("쪽지 삭제에 실패하였습니다. 다시 시도해 주세요 ")
										}
										
										location.reload();
									}
								
								});
								
							}else{
								
								$.ajax({
									url : "recvMsgUpdate.mg",
									
									type :"get",
		            				
		            				traditional: true, //배열 넘기는 옵션
									
		            				data : {msgNoArr : recvArr},
	
		            				async : false,
		            				
									success : function(result){
										
										if(result == "YYYY"){
											
											$.ajax({
												url : "sendMsgUpdate.mg",
												
												type :"get",
					            				
					            				traditional: true, //배열 넘기는 옵션
												
					            				data : {msgNoArr : sendArr},
												
												success : function(result){
													
													if(result == "YYYY"){
														alert("쪽지가 삭제되었습니다.")
													}else{
														alert("쪽지 삭제에 실패하였습니다. 다시 시도해 주세요 ")
													}
												}
											
											});
											
										}else{
											alert("쪽지 삭제에 실패하였습니다. 다시 시도해 주세요 ")
										}
										
										location.reload();
									}
									
								});
							}
						}
					}
				})	
				
				
				/*선택 복구 */
				$("#trash-recover").on("click",function(){
					if((recvArr.length == 0) && (sendArr.length == 0)){
						alert("복구할 쪽지를 선택해주세요.")
					}else{
						if(confirm("쪽지를 복구하시겠습니까?")){
							
							if(recvArr.length == 0){
								
								$.ajax({
									url : "sendMsgRecover.mg",
									
									type :"get",
		            				
		            				traditional: true, //배열 넘기는 옵션
									
		            				data : {msgNoArr : sendArr},
									
									success : function(result){
										
										if(result == "YYYY"){
											alert("복구가 완료 되었습니다.")
											
										}else{
											alert("쪽지 복구에 실패하였습니다. 다시 시도해 주세요 ")
										}
										
										location.reload();
									}
								
								});
							}else if(sendArr.length == 0) {
								
								$.ajax({
									url : "recvMsgRecover.mg",
									
									type :"get",
		            				
		            				traditional: true, //배열 넘기는 옵션
									
		            				data : {msgNoArr : recvArr},
									
									success : function(result){
										if(result == "YYYY"){
											alert("복구가 완료 되었습니다.")
										}else{
											alert("쪽지 복구에 실패하였습니다. 다시 시도해 주세요 ")
										}
										
										location.reload();										
									}
								})
								
							}else{
								
								$.ajax({
									url : "recvMsgRecover.mg",
									
									type :"get",
		            				
		            				traditional: true, //배열 넘기는 옵션
									
		            				data : {msgNoArr : recvArr},
	
		            				async : false,
		            				
									success : function(result){
										
										if(result == "YYYY"){
											
											$.ajax({
												url : "sendMsgRecover.mg",
												
												type :"get",
					            				
					            				traditional: true, //배열 넘기는 옵션
												
					            				data : {msgNoArr : sendArr},
												
												success : function(result){
													
													if(result == "YYYY"){
														alert("복구가 완료 되었습니다.")
													}else{
														alert("쪽지 복구에 실패하였습니다. 다시 시도해 주세요 ")
													}
												}
											});
											
										}else{
											alert("쪽지 복구에 실패하였습니다. 다시 시도해 주세요 ")
										}
										
		            					location.reload();
									}
								});
							}
						}
						
					}
				});
			});
		
		</script>		
		
            <br clear="both"><br>
        </div>
	</div>
</body>
</html>