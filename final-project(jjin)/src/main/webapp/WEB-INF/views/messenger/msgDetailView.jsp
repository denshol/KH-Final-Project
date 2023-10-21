<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지</title>
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
        
        /* navi 영역 */
		.innerOuter>#msg_nav{
			width:100%;
			height: 130px;
		}
        
        #msg_nav>ul{
        	list-style-type: none;
        	padding: 0;
        	margin-top: 10px;
        	
        }
        
        #msg_nav li a{
			text-decoration-line: none;
			color: black;
			font-size: 18px;
			font-weight: 900;
        }
		
		#msg_nav li a:hover{
			font-size :20px;
			color: #009966;
		}
		
        #msg-detailForm{
            width:100%;
        }
        
        #msg-detailForm>table {
            width:100%;
        }

        #msg-detailForm>table * {
            margin:5px;
            background-color : white;
        }
        
      
    </style>
</head>
<body>
	<div class="messenger_content">
		<div class="innerOuter">
			<c:if test="${msg.recvrUno eq loginUser.userNo}">
			<h2 style="font-weight: 700;">받은 쪽지</h2> 
			</c:if>
			<c:if test="${msg.senderUno eq loginUser.userNo}">
			<h2 style="font-weight: 700;">보낸 쪽지</h2> 
			</c:if>
			<div id="msg_nav">
					<ul>
						<li><a href="insert.mg">쪽지쓰기</a></li>
						<li><a href="list.mg">받은쪽지함</a></li>
						<li><a href="slist.mg">보낸쪽지함</a></li>
						<li><a href="tlist.mg">휴지통</a></li>
					</ul>
			</div>
			<script>
				/* 답장 버튼 클릭 */
				$(function(){
					$("#reply-btn").on("click", function(){
						if(confirm("답장을 보내시겠습니까?")){
							location.href="relpyMsg.mg?msgNo="+${msg.messengerNo}
						}
					});	
				})
				
				/* 삭제버튼 클릭(받은 쪽지함) */
				$(function(){
					
					var msgNoArr = [];
					
					var msgNo = ${msg.messengerNo};
					
					msgNoArr.push(msgNo);
					
					$("#delete-btn").on("click",function(){
						if(confirm("쪽지를 삭제하시겠습니까?")){
							$.ajax({
								url : "recvMsgUpdate.mg",
								
								data : {msgNoArr : msgNoArr },
								
								traditional: true,
								
								success: function(result){
									if(result == "YYYY"){
										alert("쪽지 삭제가 완료되었습니다.");
										location.href ="list.mg";
									}else{
										alert("쪽지 삭제에 실패하였습니다.");
									}
								}
							});
						}
					});
				})
				
			</script>
			<div id="msg_list">
				<!-- 받은 쪽지 조회  -->
				<c:if test="${msg.recvrUno eq loginUser.userNo}">
				<div id="msg-detailForm">
	                <div id="msg_btn_area">
	                    <button id="reply-btn" type="button" class="btn btn-primary">답장</button>
	                    <button id="delete-btn" type="button" class="btn btn-danger">삭제</button>
	                </div>
	                <br>
	                <table algin="center">
	                    <tr>
	                        <th width="15%">제목</th>
	                        <td><input type="text" id="" class="form-control" value="${msg.msgTitle}" name="msgTitle" readonly></td>
	                    </tr>
	                    <tr>
	                        <th>보낸사람</th>
	                        <td><input type="text" id="writer" class="form-control" value="${msg.senderId} (${msg.sender})" name="sender" readonly></td>
	                    </tr>
	                    <tr>
	                        <th>받는사람</th>
	                        <td><input type="text" id="sendUser" class="form-control"  value="${msg.recvrId} (${msg.receiver})" name="receiver" readonly></td>
	                    </tr>
	                    <tr>
	                        <th>내용</th>
	                        <td><textarea id="content" class="form-control" rows="8" style="resize:none;" name="msgContent" required>${msg.msgContent}</textarea></td>
	                    </tr>
	                </table>
	                <br>
	            </div>
				</c:if>
				
				<!-- 보낸 쪽지 조회 -->
				<c:if test="${msg.senderUno eq loginUser.userNo}">
				<script>
					/*  보낸 쪽지 삭제 */
					$(function(){
						var msgNoArr = [];
						
						var msgNo = ${msg.messengerNo};
						
						msgNoArr.push(msgNo)
						
						$("#send-delete-btn").on("click",function(){
							if(confirm("보낸 쪽지를 삭제하시겠습니까?")){
								$.ajax({
									
									url: "sendMsgUpdate.mg",
									
									data : {msgNoArr : msgNoArr},
									
									traditional : true,
									
									success: function(result){
										if(result == "YYYY"){
											alert("쪽지 삭제가 완료되었습니다.");
											location.href="slist.mg";
										}else{
											alert("쪽지 삭제에 실패하였습니다. 다시 시도해주세요");
										}
									}
								});
							}
						});
					})
				</script>
				<div id="msg-detailForm">
	                <div id="msg_btn_area">
	                    <button id="send-delete-btn" type="button" class="btn btn-danger">삭제</button>
	                </div>
	                <br>
	                <table algin="center">
	                    <tr>
	                        <th width="15%">제목</th>
	                        <td><input type="text" class="form-control" value="${msg.msgTitle}"name="msgTitle" readonly></td>
	                    </tr>
	                    <tr>
	                        <th>보낸사람</th>
	                        <td><input type="text" class="form-control" value="${msg.senderId} (${msg.sender})" name="sender" readonly></td>
	                    </tr>
	                    <tr>
	                        <th>받는사람</th>
	                        <td><input type="text" class="form-control" value="${msg.recvrId} (${msg.receiver})" name="receiver" readonly></td>
	                    </tr>
	                    <tr>
	                        <th>내용</th>
	                        <td><textarea class="form-control" rows="8" style="resize:none;" name="msgContent" readonly>${msg.msgContent}</textarea></td>
	                    </tr>
	                </table>
	                <br>
	            </div>
				</c:if>
	        </div>
		</div>
	</div>
</body>
</html>