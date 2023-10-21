<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    
	<!--아이콘 cdn-->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"/>
	<!-- 풀캘린더 -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.4.0/fullcalendar.css" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.4.0/fullcalendar.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js"></script> <!-- 동현님 -->
    
	<!-- <link href="/final3/resources/css/menubar.css" rel="stylesheet"> -->
    <link rel="stylesheet" href="/final3/resources/css/chat.css"> 
    <!-- sock js -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.2/sockjs.min.js"></script>
    <!-- STOMP -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<!--
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	-->	
	<style>
:root{
	--header-height: 5.4rem;
	--nav-width: 80px;
	--menubar-color: #0E6251; /*메뉴바 색상*/
	--menubar-font-color: white; /*메뉴바 글씨 색상*/
	--header-color: #F3F5F3; /*헤더 색상*/
	--body-font: ; /*폰트*/
	--normal-font-size: 1.7rem; /*기본 글씨 크기*/
	--z-fixed: 100; /*?*/
	--main_profile_height: ;
}*,

::before, ::after{
    box-sizing: border-box;
}

body{
    position: relative;
    margin: var(--header-height) 0 0 0;
    padding: 0 1rem;
    font-family: var(--body-font);
    font-size: var(--normal-font-size);
}

a{
    text-decoration: none;
}

.header{
    width: 100%;
    height: var(--header-height);
    position: fixed;
    top: 0;
 left: 0;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 1rem;
    background-color: var(--header-color);
    z-index: var(--z-fixed);
    transition: .5s;
}


.head{
    font-size: 2.4rem;
    cursor: pointer;
}

.header_right{
    display: flex;
    padding: .5rem 1rem 0 0;
    column-gap: 4rem;
    font-size: 2.4rem;
    cursor: pointer;
    align-items: center;
}

.header_profile img{
    border: 1px solid black;
    width: 35px;
    height: 35px;
    display: flex;
    justify-content: center;
    border-radius: 50%;
    cursor: pointer;
}

/* menubar 전체 div */
.menubar{
    position: fixed;
    background-color: var(--menubar-color);
    top: 0;
    left: -30%;
    width: var(--nav-width);
    height: 100vh;
    padding: .5rem 1rem 0 0;
    transition: .5s;
    z-index: var(--z-fixed);
}

.nav{
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    overflow: hidden;
}

.nav_logo{
 	margin-top: 10px;

}

.nav_logo, .nav_link{
    display: grid;
    grid-template-columns: max-content max-content;
    align-items: center;
    column-gap: 1rem;
	padding: .5rem 0 .5rem 1.5rem; 
	position: relative;
}

.nav_link{
    position: relative;
    color: var(--menubar-font-color);
    transition: .3s;
}

.nav_link:hover{
    color: var(--white-color);
	text-decoration: none;
}


/*로그아웃 영역 */
.nav_logout{
    margin-left: 15px;
    margin-top: auto;
	margin-bottom: 40px;
}
   
/* 로그아웃 버튼이 이상해서 따로 설정함 */
#menubar_logout {
	background-color: #0E6251;
	border: 0px;
	color: #999999;
}
   	
#menubar_logout:hover{
	color: white;
}
       
@media (max-width: 768px) {
	.nav_logo,
	.nav_link,
	.nav_logout {
		display: block;
		text-align: center;
		margin-top: 10px;
	}
}

.show{
	left: 0;
}

.body-pd{
	padding-left: calc(var(--nav-width) + 1rem);
}
       
.active{
	color: var(--white-color);
}
.active::before{
	content: '';
	position: absolute;
	left: 0;
	width: 2px;
	height: 32px;
	background-color: var(--white-color);
}
.height-100{
	height:100vh;
}
@media screen and (min-width: 768px){
	body{
		margin: calc(var(--header-height) + 1rem) 0 0 0;
		padding-left: calc(var(--nav-width) + 2rem);
	}
	
	.header{
		height: calc(var(--header-height) + 1rem);
		padding: 0 2rem 0 calc(var(--nav-width) + 2rem);
	}
	
	.header_profile{
		width: 40px;
		height: 40px;
	}
	
	.header_profile img{
		width: 45px;
	}
	
	.menubar{
		left: 0;
		padding: 1rem 1rem 0 0;
	}
	
	.show{
		width: calc(var(--nav-width) + 156px);
	}
	
	.body-pd{
		padding-left: calc(var(--nav-width) + 188px);
	}
}

/* 사이드바를 감싸고있는 div */
.sidebar-nav { 
    width: 250px;
    /* margin-left: 10px;
    padding: 0; */
    margin: 0 0 0 0;
    padding: 0 0 0 0;
}

/* 큰 ul */
.sidebar-nav ul {
    width: 250px;
    margin: 10px;
    padding: 0;
    list-style: none;
}

/* 큰 ul 안에 있는 li */
.sidebar-nav li {
    line-height: 60px;
}

/* 소메뉴 */
.sidebar-nav li a {
    display: block;
    padding-left: 20px;
    text-decoration: none;
    color: #999;
}

/* 소메뉴 hover */
.sidebar-nav li a:hover {
    text-decoration: none;
    color: #fff;
    background: rgba(0, 0, 0, 0.2);
}


.sidebar-nav li a:active, .sidebar-nav li a:focus {
    text-decoration: none;
}

.sidebar-nav li a.active{
    text-decoration: none;
    color: #fff;
    background: rgba(0, 0, 0, 0.2);
}

#menu_submenu{
    display: none;
}

/* --------------- */
/* 프로필 호버시 메뉴 */
.header_profile_menu{
    list-style: none;
    margin: 0;
    padding: 0;
}

.header_profile_submenu{
    list-style: none;
    /* margin: 0; */
    /* padding: 0; */
}

.header_profile_menu:after{
    display: block;
    content: '';
    clear: both;
}

.header_profile_menu>li{
    position: relative;
    float: left;
    margin-right: 5px;
}

.header_profile_menu>li>a{
    display: block;
    padding: 0 25px 0 0;
    height: 48px;
    line-height: 40px;
}

.header_profile_menu>li:hover .header_profile_submenu,
.header_profile_menu:hover .hd_pro_con{
    display: block;
}

.header_profile_menu .header_profile_submenu{
    display: none;
    position: absolute;
    right: 1px;
    text-align: center;
}

.header_profile_menu .header_profile_submenu a {
    display: block;
    padding: 5px;
    font-size: 18px;
    background-color: #0E6251;
    color: white;
    width: 100px;
    height: 40px;
    padding: 10px 0;
    
}
   
/* 말풍선 말꼬리 만들기  */
.hd_pro_con::after{
    content: "";
    position: absolute;
    top: 25px;
    left: 8px;
    border: 13px solid transparent;
    border-bottom: 10px solid #0E6251;
    z-index: 999;
}

.header_profile_menu .hd_pro_con {
    display: none;
}

.header_profile_menu:hover .hd_pro_con {
    display: block;
}

.header_profile_submenu a:hover{
	background: #234d42;
}

.content{
	width: 1570px;
	/* height: 800px; */
	margin-top: 80px;
	/* background-color: khaki; */
}
   
   /* 상태표시 모달  */
   .active_update{
    width: 200px;
    border: 1px solid #C4C4C4;
    box-sizing: border-box;
    border-radius: 10px;
    padding: 12px 13px;
    font-family: 'Roboto';
    font-style: normal;
    font-weight: 400;
    font-size: 14px;
    line-height: 16px;
}

.active_update:focus{
    border: 1px solid #9B51E0;
    box-sizing: border-box;
    border-radius: 10px;
    outline: 3px solid #F8E4FF;
    border-radius: 10px;
}
   
/* 채팅  */
.header_chat{
 
}

#alarm{
	margin-left:20px;
	position:absolute;
	text-align:center;
	background-color:red;
	color:#fff;
	border-radius:200px;
	width:18px;
	height:17px;
	font-size:12px;
	font-weight:400;
	line-height:15px;
}
</style>
</head>
<body id="body-pd">

	<!-- 알림메세지 -->
	<c:if test="${not empty alertMsg }">
		<script>
			alert("${alertMsg}");
		</script>
		<c:remove var="alertMsg" scope="session"/>
	</c:if>
	<c:if test="${not empty errorMsg }">
		<script>
			alert("${errorMsg}")		
		</script>
		<c:remove var="errorMsg" scope="session"/>
	</c:if>
	

    <div class="header" id="header">
    	
    	<!-- 헤더 메뉴버튼  -->
        <div class="head">
            <i class="fa-sharp fa-solid fa-bars fa-lg" id="header-toggle" style="color: #0E6251;"></i>
        </div>

		<!-- 헤더 오른쪽  -->
        <div class="header_right">
        	<!-- 쪽지  -->
            <div class="header_letter">
            	<a href="#">
                	<i id="messenger" class="fa-sharp fa-solid fa-paper-plane fa-lg" style="color: #0E6251;"></i>
            	</a>
            </div>
            <script>
				/* 쪽지 아이콘 클릭시 새창 띄우기 */
				$(function(){
					$("#messenger").on("click",function(){
						window.open("list.mg","메신저","width = 1100 , height = 600");
					})
				})	
			
			</script>

			<!-- 메일  -->
            <div class="header_mail">
            	<a href="email.em">
                	<i class="fa-sharp fa-solid fa-envelope fa-lg" style="color: #0E6251;"></i>
                </a>
            </div>

			<!-- 실시간 채팅  -->
            <div class="header_chat">
            <div id="alarm">new</div>
            	<a href="#mySmallModal" data-toggle="modal">
                    <i class="fa-sharp fa-solid fa-comments fa-lg" style="color: #0E6251;"></i>
                </a>
            </div>
       

			<!-- 알림  -->
            <div class="header_alert">
            	<a href="#">
                	<i class="fa-sharp fa-solid fa-bell fa-lg" style="color: #0E6251;"></i>
                </a>
            </div>
            
            <!-- 회원 프로필  -->
            <div class="header_profile">
            	<ul class="header_profile_menu">
                    <li>
                        <a href="#"><img src="https://i.imgur.com/hczKIze.jpg" alt="" ></a>

                        <div class="hd_pro_con">
                            <ul class="header_profile_submenu">
                                <li>
                                	<a href="#user_active" data-toggle="modal">상태 표시</a>
                                </li>
                                <li><a href="#">마이 페이지</a></li>
                            </ul>
                        </div>
                    </li>
                </ul>
				
                
                
            </div>  
        </div>
    </div>

	<!-- auth 추출해서 소문자로 바꾸기 -->
    <c:set var="lastIndex" value="${fn:length(loginUser.auth)}"/>
    <c:set var="subString_auth" value="${fn:substring(loginUser.auth,5,lastIndex)}"/>
    <c:set var="role" value="${fn:toLowerCase(subString_auth)}"/>
    
    <div class="menubar" id="nav-bar">
        <nav class="nav"> <!--nav는 블럭요소, span은 인라인요소-->
            <div>
            	<!--로고 부분-->
                <a href="#" class="nav_logo"> 
                    <img src="" alt="">
                    <span class="nav_logo_name">로고</span>
                </a>

                <div class="sidebar-nav">
                    <ul>
                        <!--  홈  -->
                        <li>
                            <a href="/final3/${role}/mainPage.me" class="nav_link active">
                                <i class="fa-sharp fa-solid fa-house fa-xl" id="menu_img" style="color: #ffffff;"></i>
                                &nbsp;
                                <span class="nav_name">홈</span>
                            </a>
                        </li>
                        
                        <!-- 근태관리  -->
                        <li>
                            <a href="userAtt.at" class="nav_link">
                                <i class="fa-sharp fa-solid fa-business-time" style="color: #ffffff; font-size: 22px;"></i>
                                &nbsp;
                                <span class="nav_name">근태관리</span>
                            </a>
                        </li>
						<!-- 전자결재 -->
                        <li class ="menu">
                            <a href="home.ap" class="nav_link" data-toggle="collapse" data-target="">
                                <i class="fa-sharp fa-solid fa-pen-to-square fa-xl" style="color: #ffffff;"></i>
                                &nbsp;
                                <span class="nav_name">전자결재</span>
                            </a>
                            <ul id="menu_submenu" class="collapse">
                                <li>
                                    <a href="home.ap">결재홈</a>
                                </li>
                                <li>
                                    <a href="enrollList.ap">결재 작성</a>
                                </li>
                                <li>
                                    <a href="list.ap">결재함</a>
                                </li>
                            </ul>
                        </li>
                        
                        <!-- 인사관리  -->
                        <li class="menu2">
                            <a href="#" class="nav_link">
                                <i class="fa-sharp fa-solid fa-users" style="color: #ffffff; font-size: 21px;"></i>
                                &nbsp;
                                <span class="nav_name">인사관리</span>
                            </a>
                            <ul id="menu_submenu2" class="collapse">
                                <li>
                                    <a href="/final3/${role}/list.me">임직원 조회</a>
                                </li>
                                 <li>
                                    <a href="payment.me?userNo=${loginUser.userNo}">급여명세서 조회</a>
                                </li>
                                <c:if test="${(loginUser.auth eq 'ROLE_ADIM' and loginUser.deptCode eq 'D9') or (loginUser.deptCode eq 'D9') }">
                                <li>
                                    <a href="payment.ad">급여명세서 작성</a>
                                </li>
                                </c:if>
                            </ul>
                            
                        </li>

						<!-- 일정관리  -->
                        <li>
                            <a href="schedule.sc" id="scheduleIcon"  class="nav_link">
                                <i class="fa-sharp fa-solid fa-calendar-day" style="color: #ffffff; font-size: 28px;"></i>
                                &nbsp;
                                <span class="nav_name">&nbsp;일정관리</span>
                            </a>
                        </li>
                       
                        <!--커뮤니티  -->
                        <li>
                            <a href="list.no" class="nav_link">
                                <i class="fa-sharp fa-solid fa-newspaper fa-xl" style="color: #ffffff; font-size: 28px;"></i>
                                &nbsp;
                                <span class="nav_name">커뮤니티</span>
                            </a>
                        </li>
                    </ul>

                </div>
            </div>

			<!-- 로그아웃  -->
            <div class="nav_logout">
                <a href="#" class="nav_link">
                    <i class="fa-sharp fa-solid fa-right-from-bracket fa-xl" style="color: #ffffff; "></i>
                    <span class="nav_n">
						<form action="/final3/logout" method="post">
					        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					        <button type="submit" id="menubar_logout">LOGOUT</button>
						</form>
                    </span>
                </a>
            </div>
        </nav>
    </div>
    
    <div class="modal fade" id="user_active" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">상태 업데이트 </h4>
				</div>
				<div class="modal-body">
						<form action="">
							<select class="active_update">
								<option value="" selected>활동중 </option>
								<option value="">퇴근 </option>
								<option value="">자리 비움 </option>
							</select>
						
						</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기 </button>
					<button type="button" class="btn btn-primary">변경 </button>
				</div>
			</div>
		</div>
	</div>

    <script>
    	document.addEventListener("DOMContentLoaded", function(event) {
        const showNavbar = (toggleId, navId, bodyId, headerId) =>{
		const toggle = document.getElementById(toggleId),
		nav = document.getElementById(navId),
		bodypd = document.getElementById(bodyId),
		headerpd = document.getElementById(headerId)

		// Validate that all variables exist
		if(toggle && nav && bodypd && headerpd){
			toggle.addEventListener('click', ()=>{
			// show navbar
			nav.classList.toggle('show')
			// add padding to body
			bodypd.classList.toggle('body-pd')
			// add padding to header
			headerpd.classList.toggle('body-pd')
			})
		}
		}

		showNavbar('header-toggle','nav-bar','body-pd','header')

		const linkColor = document.querySelectorAll('.nav_link')

		function colorLink(){
			if(linkColor){
				linkColor.forEach(l=> l.classList.remove('active'))
				this.classList.add('active')
			}
		}
		
		linkColor.forEach(l=> l.addEventListener('click', colorLink))
	});

	/* 메뉴바 소메뉴  */
    $(document).ready(function(){
	    $("#header-toggle").click(function() {
	        var submenu = $(this).parents('.header').next(".menubar").find("#menu_submenu");
	
	        if(submenu.is(":visible")) {
	            submenu.slideUp();
	        }
	    });
	});

    $(document).ready(function(){
        $(".menu>a").click(function() {
            var submenu = $(this).next("#menu_submenu");

            if(submenu.is(":visible")) {
                submenu.slideUp();
            }else {
                submenu.slideDown();
            }
        });
        
        $(document).ready(function(){
		    $("#header-toggle").click(function() {
		        var submenu2 = $(this).parents('.header').next(".menubar").find("#menu_submenu2");
		
		        if(submenu2.is(":visible")) {
		            submenu2.slideUp();
		        }
		    });
		});

        $(document).ready(function(){
            $(".menu2>a").click(function() {
                var submenu2 = $(this).next("#menu_submenu2");

                if(submenu2.is(":visible")) {
                    submenu2.slideUp();
                }else {
                    submenu2.slideDown();
                }
            });
        });
        
    });

</script>

<c:set var="path" value="${pageContext.request.contextPath}/${role}" />
<c:set var="urlc" value="${requestScope['javax.servlet.forward.request_uri']}"/>
<!-- chatting -->
<script>    
console.log("${path}");
console.log("${map}");
console.log("${row}");
    //sessionScope 에 있는 유저정보
    var loginUser = '${loginUser}';
    console.log(loginUser.auth);
    var userName = '${loginUser.userName}';
    var userId = '${sessionScope.loginUser.userId}';
   // var userName = ${loginUser.userName};

    //웹소켓 = 전역변수 설정 -> 다른 곳에서도 알림기능 채팅기능 이용가능
    var socket = null;
    var stompClient = null;

    $(function(){
        initialize();
        });

    function initialize(){
        getUnreadMessageInfo();
        unReadAlertInfinite();
        }

    //async(비동기)방식으로 일정간격 업데이트 되어야 하는 정보들(메세지 알림기능)
     function getUnreadMessageInfo(){
        $.ajax({
            url : "${path}/chatUnreadMessageInfo/ajax"
           ,type : "POST"
           ,data : JSON.stringify({
        	    'userid' : userId
               })
           ,contentType : "application/json; charset=utf-8"
           ,succeess : function(e){
               var parsed = JSON.parse(e);
               var length = parsed.chatList.length;

               for(let i = 0; i < length; i++){
            	    $(".icon-"+parsed.chatList[i].c_idx).html("");
            	    messageUnreadCheck(
            	    		       parsed.chatList[i].messageUnread,
            	    		       parsed.chatList[i].c_idx);
                   }
               }
            });
        } 
     //1cho interval refresh 
     function unReadAlertInfinite(){
    	    setInterval(() => {
        	    getUnreadMessageInfo();
        	    }, 1000);
         } 
   //일정 간격으로 업데이트된 데이터를 화면에 출력하는 메서드 됨
     function messageUnreadCheck(messageUnread, c_idx) {     
         if(messageUnread == "new message"){
             var infoStr = "<span class='text-danger fw-bold'>"+ messageUnread + "</span>"
             $(".icon-" + c_idx).append(infoStr);
         } else if(messageUnread == "send complete") {
             var infoStr = "<span class='text-success fw-bold'>"+ messageUnread + "</span>"
             $(".icon-" + c_idx).append(infoStr);
         } else {
             var infoStr = "<span class='text-black-50 fw-bold'>"+ messageUnread + "</span>"
             $(".icon-" + c_idx).append(infoStr);
         }
     }
     
     //검색결과 폼 적용
     function searchChatList(f){
         f.sumbit();
     }
     
     //채팅방으로 이동하기
     function chatPopUp(room_idx,h_userid,userid){
         var left = $(document).width()-600; //문서 가로사이즈 - 600;
         window.open("${path}/chatroom/"+room_idx+"/"+h_userid+"/"+userid,"_blank","width=550, height=700, left=" + left + ", top=100, scrollbars=no, toollbars=no, location=no,");
     }
     
     //페이지네이션 이동
     function pagination(page){
         const nowUrl = location.href; //현재주소
         const isParam = location.search;
         const searchParams = new URL(nowUrl).searchParams; //파라미터값 담기
         const pageParam = searchParams.get("page");
         
         if(isParam == ""){ //만약 파라미터값이 없다면
             location.href = nowUrl + "?page=" + page;   
         } else if(pageParam == null) { //만약 파라미터에 page 값이 없다면..
             location.href = nowUrl + "&page=" + page;   
         } else { //page값이 있다면
             searchParams.set("page", page); //page 파라미터 값을 변경 
             const newParam = searchParams.toString(); //파라미터 값을 가져오고
             const url = location.href.split("?"); //현재 url에서 파라미터 값을 제외한 url을 가져온다.
             location.href = url[0] +"?"+newParam;
         }
     }
     
     

   </script>
    <!-- 실시간 채팅  -->
    
    <!-- Modal -->
<div class="modal fade" id="mySmallModal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

        <h6 class="modal-title" id="mySmallModalLabel">h6</h6>
          <ul style="margin:0" class="nav nav-pills nav-stacked">
            <li role="presentation" class="active"><a href="#" style="background-color:#573737;">
                채팅 리스트<span class="badge" style="background-color:red; color:#fff">new</span></a></li>
            <li role="presentation" class="disabled"><a href="#">프로필</a></li>
            <li role="presentation"><a href="#"> 설정</a></li>
          </ul>
        
      </div>
      <div class="modal-body" style="padding:10px;">
        <div class="table-responsive">
        <table align="center" class="table-bordered" style="border-left:none;border-right:none;width:100%; height:100%;">
          <tr style="background-color:#573737; color:#fff">
            <th>#</th>
            <th>방이름</th>
            <th>생성자</th>
            <th>createdate</th>
          </tr>
         
         <c:forEach var="room" items="${cList}">
            <a href="/chatting/room?roomId=${room.roomId}"></a>
          <tr>
            <td>${room.roomId}</td>
            <td>${room.rommName}</td>
            <td>${room.masterName}</td>
            <td>${room.date}</td>
          </tr>
            </c:forEach>
          
          <tr>
            <td>11</td>
            <td>22</td>
            <td>33</td>
            <td>44</td>
          </tr>
          
          <tr>
            <td>11</td>
            <td>22</td>
            <td>33</td>
            <td>44</td>
          </tr>
          
          <tr>
            <td>11</td>
            <td>22</td>
            <td>33</td>
            <td>44</td>
          </tr>
          
          <tr>
            <td>11</td>
            <td>22</td>
            <td>33</td>
            <td>44</td>
          </tr>
          
          
        </table>
        </div>
        </div>
        <!-- chatting-->

    <!-- 채팅방 목록 -->
 <!--    <button id="bubble" class="btn btn-outline success" value="말풍선">말풍선</button> -->

    <!-- <main id="plz">
        <h1>채팅방</h1>
        <button class="">새 채팅방 만들기</button>
        <nav>
            <span>방 제목</span>
            <span>인원</span>
        </nav>
        <hr>

            <ul>
                <li>
                    <span class="time_stamp"></span>
                    <span class="chat_title">채팅창 제목</span>
                    <span class="chat_count">8</span>

                </li>
            </ul>
        </main> -->
        <!-- 채팅방 목록 -->
        <script>
        $(document).ready(function(){
          
        
        </script>
        <div id="load">
        dd
</div>
<script>
//페이지 로딩완료시 로딩바 숨기기
$(window).one('load', function() {
    //console.log('로드완료...')
    $("#load").hide();
});
</script>
        
                <%-- <form action="/chatting/room" method="post">
                    
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <button type="submit" id="menubar_logout">LOGOUT</button>
                        </form> --%>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-info" id="new_chat">생성하기</button>
        
            <script>
            console.log('${roomName}');
            var roomName;
            
            $(function(){
                
                
                $("#new_chat").click(function(){

                    swal({
                        title: "채팅방을 생성합니다."
                        ,text: "."
                       ,icon: "info"     
                       ,content: "input"
                       ,buttons: ["취소","생성"]
                      ,closeOnClickOutside : false     
                        }).then((value) => {
                            

                            	  $.ajax({
                                      url : "chatRoomList.do"
                                     ,data : {roomName : roomName}
                                     ,type : "POST"
                                     ,beforeSend : function(xhr)
                                         {
                                             xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                                         }
                                     ,success : function(data){
                                         console.log(data);   
                                swal("채팅방개설","${value}","success");

                                         }
                                     ,error : function(e){
                                         console.log(e);
                                         
                                         cosnole.log('${loginUser}');
                                         cosnole.log('${loginUser.auth}');
                                         cosnole.log('${loginUser.userPwd}');
                                         cosnole.log('${loginUser.email}');
                                         cosnole.log('${loginUser.userId}');
                                         cosnole.log('${loginUser.userName}');
                                         }         
                                      })
                                
                            
                                })
                           });
                    });
            </script>
        
      </div>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>
<!-- /.modal -->



        <!-- 채팅방 입장 -->

         <div class="chat">
	          <div class="chat_head">
	           <div class="pannel-heading" id="accordion">
                    <div class="chat_title" style="margin:0px; width:100%;background-color: #573737; color: #ddd;">
                      &nbsp;<span class="glyphicon glyphicon-comment"></span>&nbsp; Chat 1번방${room.name}
                     <button id="chat_exit" class="btn-danger" onclick="exit_chat();" style="right:10px;">나가기</button>
                     <span style="left:50px;" class="glyphicon glyphicon-fullscreen" id="maxizing"></span>
                    <a style="right:20px; underline:none; color:#fff;" type="button" href="#collapseOne" data-parent="accordion" data-toggle="collapse">
                    <span id="minusIcon" class="glyphicon glyphicon-minus" style="margin-left:70px;"></span></a> 
                     
                    </div>
                    
                                      
                    <script>
                    $(function(){
                        $("#minusIcon").click(function(){

                        	$(this).toggleClass("glyphicon glyphicon-minus glyphicon glyphicon-plus");
                        	
                            });
                        $("#maxizing").click(function(){
                            $(".chat_body").toggleClass("maxing minimizing");
                            })
                        })
                    
                      function exit_chat(){
                        var cf = confirm("채팅방을 나갑니다.");
                        if(cf){
                          $(".chat").fadeOut(500);
                                               }
                      }
                    function toggle(){
                     
                      $(".chat_users").slideToggle(650);
                    }
                    </script>

                        </div>
                    </div>
                    <div id="msgStack"></div>
              <div class="panel-collapse collapse in" id="collapseOne">
                    <div class="panel-body" style="padding:0px;">
                          <div class="chat_body" style="margin-right:0px; min-width:300px; min-height:300px;">
                      <button class="btn btn-info" id="chat_back" onclick="toggle();">◀ 참가인원${room.users}<span class="badge">${room.users.length}3</span></button>
                  
                        <ul class="chat_list">
                          <li>
                            <div class="notification">
                              <span class="nowDate"></span>
                              <script>
                                var now = new Date();
                                moment.locale('ko');
                                var nowDate = moment(now).format('YYYY년-MM월-DD일 HH시:mm분:ss초');
                                $('.nowDate').text(nowDate);
                              </script>
                        </div> 
                      </li>
                    </ul>
                  </div>
                  <div class="panel-footer" style="padding:0px;">
                    <div class="chat_input">
                      <div class="dropup" id="chat_attach">
                        <button data-toggle="dropdown" type="button" id="menu3" class="btn btn-success dropdown-toggle" style="width:40px;height:100%;">
                        <span class="caret"></span></button>
                        <ul class="dropdown-menu" role="menu" aria-labelledby="menu3">
						      <li role="presentation"><a role="menuitem" tabindex="-1" href="#">HTML</a></li>
						     <li role="presentation" class="dropdown-header">Dropup header</li>
						      <li role="presentation"><a role="menuitem" tabindex="-1" href="#">JavaScript</a></li>
						      <li role="presentation" class="divider"></li>
						      <li role="presentation"><a role="menuitem" tabindex="-1" href="#">About Us</a></li>
					    </ul>
                      </div>
                      <div class="chat_input_area">
                        <textarea id="msgWriting" ></textarea>
                      </div>
                      
                      <div class="chat_button_area">
                        <button id="sendBtn" style="height:100%; width:100%; margin:0px;">전송</button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
                
                <div class="chat_users" style="padding:0px;">
                  <h2  style="margin:0px; background-color:#573737; color:#fff;">
                    참가인원
                    <span class="user">
                      <span class="badge" style="background-color:red; color:#fff;">3</span>                      
                        </span>
                    </h2>
                    <div style="background-color:#a1c0d6; padding:0px; opacity:0.8;" class="chat_nickname">
                      <ul style="padding:0px;">
                        <li><span class="glyphicon glyphicon-user"></span> user1</li>
                        <li><span class="glyphicon glyphicon-user"></span>user2</li>
                        <li><span class="glyphicon glyphicon-user"></span>user3</li>
                      </ul>
                    </div>
                  </div>
                </div>
              
              <!-- 채팅방 입장 -->
              
              
    
    
    <!--메세지 전송 영역  -->
      <!--   <script>
        $('#notifySendBtn').click(function(e){
            let modal = $('.modal-content').has(e.target);
            let type = '70';
            let target = modal.find('.modal-body input').val();
            let content = modal.find('.modal-body textarea').val();
            let url = '${contextPath}/member/notify.do';
            // 전송한 정보를 db에 저장   
            $.ajax({
                type: 'post',
                url: '${contextPath}/member/saveNotify.do',
                dataType: 'text',
                data: {
                    target: target,
                    content: content,
                    type: type,
                    url: url
                },
                success: function(){    // db전송 성공시 실시간 알림 전송
                    // 소켓에 전달되는 메시지
                    // 위에 기술한 EchoHandler에서 ,(comma)를 이용하여 분리시킨다.
                    socket.send("관리자,"+target+","+content+","+url); 
                }
            });
            modal.find('.modal-body textarea').val(''); // textarea 초기화
        });

        </script> -->
    
</body>
</html>