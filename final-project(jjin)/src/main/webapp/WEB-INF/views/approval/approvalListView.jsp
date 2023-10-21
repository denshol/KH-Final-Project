<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결재함</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="/final3/resources/css/Approval_List.css" >
</head>
<body id="body-pd">
	<%@ include file="../common/menubar.jsp" %>

        <div class="approval">
            <h1 style="padding-top: 20px;">결재함</h1>
            <br><br><br><br><br><br>
            <div id="approval-tap-area">
                <ul class="nav-tabs">
                	<li class="nav-item">
                      <a class="nav-link" href="list.ap">전체</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link" href="list.ap?status=N">예고함</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link" href="list.ap?status=P">진행함</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link" href="list.ap?status=Y">완료함</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link" href="list.ap?status=R">반려함</a>
                    </li>
                    <li class="nav-item" style="width:400px;float:right">
	                    <form action="search.ap" method="post" style="display:flex;">
	                    	<input type="hidden" name="status" value="${status }"/>
	                    	<select class="form-control" name="option" style="width:100px;">
	                    		<option value="">선택</option>
	                    		<option value="1">부서</option>
	                    		<option value="2">문서</option>
	                    		<option value="3">제목</option>
	                    	</select>
	                    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		                   	<input type="search" class="form-control" name="keyword" placeholder="Search">
							<button class="btn btn-primary" type="submit">검색</button>
						</form>
					</li>
                </ul>
            </div>
            <div id="approval-list-area">
                <table id="approval-list" class="table table-hover" align="center">
                    <thead style="font-weight: bold">
                        <tr>
                            <td>문서번호</td>
                            <td>부서</td>
                            <td>문서종류</td>
                            <td>제목</td>
                            <td>작성일</td>
                            <c:if test="${!empty 'a.secondDate' ||!empty 'a.lastDate'}">
                            <td>승인/반려날짜 </td>
                            </c:if>
                        </tr>
                    </thead>
                    <tbody>
                    <c:set var="length" value="${fn:length(list)}"/>
                        <c:forEach var="i" begin="1" end="${length}" >
	                    	<c:choose>
	                    		<c:when test="${loginUser.auth eq 'ROLE_MEMBER'}">
	                    			<c:if test="${(loginUser.userNo eq list[i-1].docWriter)||(loginUser.userNo eq list[i-1].secondApproverNo)||(loginUser.userNo eq list[i-1].lastApproverNo) }">
				                        <tr>
				                        	<td width="10%">${list[i-1].docNo}</td>
				                        	<td width="10%">${list[i-1].deptCode}</td>
				                        	<td width="10%" id="docType">${list[i-1].docType }</td>
				                        	<td width="40%">
				                        		<c:if test="${list[i-1].emergency eq 'Y' && list[i-1].status eq 'P'}">
					                            	<button type="button" class="btn btn-danger btn-sm" disabled style="background-color: #c42d2d">긴급</button>
					                            </c:if>
				                        		${list[i-1].docTitle }
				                        	</td>
				                        	<td width="10%">${list[i-1].createDate}</td>
				                        	<c:choose>
			                        		<c:when test="${empty list[i-1].lastDate }">
			                        			<td>${list[i-1].secondDate}</td>
			                        		</c:when>
			                        		<c:otherwise>
			                        			<td>${list[i-1].lastDate}</td>
			                        		</c:otherwise>
			                        	</c:choose>
				                        </tr>
				                    </c:if>
	                    		</c:when>
		                    	<c:otherwise>
			                        <tr>
			                        	<td width="10%">${list[i-1].docNo}</td>
			                        	<td width="10%">${list[i-1].deptCode}</td>
			                        	<td width="10%" id="docType">${list[i-1].docType }</td>
			                        	<td width="40%">
			                        		<c:if test="${list[i-1].emergency eq 'Y' && list[i-1].status eq 'P'}">
				                            	<button type="button" class="btn btn-danger btn-sm" disabled style="background-color: #c42d2d">긴급</button>
				                            </c:if>
			                        		${list[i-1].docTitle }
			                        	</td>
			                        	<td width="10%">${list[i-1].createDate}</td>
			                        	<c:choose>
			                        		<c:when test="${empty 'a.lastDate' && empty 'a.returnDate' }">
			                        			<td>${list[i-1].secondDate}</td>
			                        		</c:when>
			                        		<c:when test="${empty 'a.lastDate' && empty 'a.secondDate' }">
			                        			<td>${list[i-1].returnDate }</td>
			                        		</c:when>
			                        		<c:otherwise>
			                        			<td>${list[i-1].lastDate}</td>
			                        		</c:otherwise>
			                        	</c:choose>
			                        </tr>
		                    	</c:otherwise>
	                    	</c:choose>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <br><br>
            <div id="approval-pagebar-area">
                <div id="pagingArea">
                    <ul class="pagination">
                    	<c:choose>
                    		<c:when test="${pi.currentPage eq 1 }">
		                        <li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
                    		</c:when>
                    		<c:when test="${!empty status}">
                    			<li class="page-item"><a class="page-link" href="list.ap?currentPage=${pi.currentPage-1}&status=${status}">Previous</a></li>
                    		</c:when>
                    		<c:when test="${!empty status and !empty keyword  }">
                    			<li class="page-item"><a class="page-link" href="list.ap?currentPage=${pi.currentPage-1}&status=${status}&keyword=${keyword}&option=${option}">Previous</a></li>
                    		</c:when>
                    		<c:otherwise>
                    			<li class="page-item"><a class="page-link" href="list.ap?currentPage=${pi.currentPage-1}">Previous</a></li>
                    		</c:otherwise>
                    	</c:choose>
                    	<c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}" step="1"> 
                    		<c:if test="${!empty status}">
		                        <li class="page-item"><a class="page-link" href="list.ap?currentPage=${p}&status=${status}">${p}</a></li>
                    		</c:if>
                    		<c:if test="${empty status}">
		                        <li class="page-item"><a class="page-link" href="list.ap?currentPage=${p}">${p}</a></li>
                    		</c:if>
                    		<c:if test="${!empty status and !empty keyword  }">
                    			<li class="page-item"><a class="page-link" href="list.ap?currentPage=${p}&status=${status}&keyword=${keyword}&option=${option}">${p}</a></li>
                    		</c:if>
                    	</c:forEach>
                    	
                       <c:choose>
                			<c:when test="${pi.currentPage eq pi.maxPage}">
								<li class="page-item disabled"><a class="page-link" href="#">Next</a></li>                		
							</c:when>
							<c:when test="${!empty status}">
								<li class="page-item"><a class="page-link" href="list.ap?currentPage=${pi.currentPage+1}&status=${status}">Next</a></li>                		
                    		</c:when>
                    		<c:when test="${!empty status and !empty keyword  }">
                    			<li class="page-item"><a class="page-link" href="list.ap?currentPage=${pi.currentPage+1}&status=${status}&keyword=${keyword}&option=${option}">Next</a></li>
                    		</c:when>
                			<c:otherwise>
                    			<li class="page-item"><a class="page-link" href="list.ap?currentPage=${pi.currentPage+1}">Previous</a></li>
							</c:otherwise>
                		</c:choose>
                    </ul>
                </div>
            </div>
        </div>
        <br><br><br>

	<script>
	$(function(){
		$("#approval-list>tbody>tr").click(function(){
			var docNo = $(this).children().eq(0).text();
			var docType = $(this).children().eq(2).text();
			location.href = "detail.ap?docNo="+docNo+"&docType="+docType;
		});
	});
	</script>
</body>
</html>
