<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
	<script src="./js/snow.js"></script>
	<link rel= "stylesheet" type="text/css" href="./css/literacss.css">
	<style>
		body{
			overflow: hidden;
			width : 900px;
			/* background-color: #1A1A1E; */
		}
		.type{
			background-color: #0080ff;
			color : white;
		}
		.board{
			width : 300px;
		}
		#writeBtn{
			position: absolute;
				left: 1120px;
		}
		.tablediv{
			width : 1200px;
			height : 900px;
			position: absolute;
			left :  350px;
		}
		td{
			text-align: center;
		}
	</style>
<body>
	<jsp:include page="./leftBar.jsp"/>
	<div class="tablediv">
	<br>
	<c:if test="${ca_num == 0}">
	<h3 class="text-primary">자유 게시판</h3>
	</c:if>
	<c:if test="${ca_num == 1}">
	<h3 class="text-primary">공략 게시판</h3>
	</c:if>
<table class="table table-hover">
  <thead>
    <tr class="type">
      <th scope="col">글 번호</th>
      <th scope="col">글 제목</th>
      <th scope="col">닉네임</th>
      <th scope="col">작성날짜</th>
      <th scope="col">조회수</th>
    </tr>
  </thead>
  <tbody>
  	<c:if test="${list ==null}">
	<tr>
		<td colspan="5">보여줄 내용이 없습니다.</td>
	</tr>
	</c:if>
    <tr class="table-light">
      <c:forEach items="${list}" var="board">
			<tr>
				<td class="idx${board.b_order}">${board.b_idx}</td>
				<c:choose>
				<c:when test="${board.state != 1}">
				<td class="${board.b_order}"> <!-- 공지사항부분 -->
					<a href="./boardDetail?nickName=${board.nickName}&b_key=${board.b_key}&id=${id}&ca_num=${ca_num}">
						${board.b_subject}
					</a>
					<c:if test="${board.c_count != 0}">
						[${board.c_count}]
					</c:if>
					
				</td>
				</c:when>
				<c:when test="${board.state == 1}">
					<td>
						이 글은 운영자에 의해 블라인드 처리 되었습니다.
						<c:if test="${sessionScope.state == 2}">
							&nbsp;&nbsp;&nbsp;
							<a href="./blindcancel?b_key=${board.b_key}&ca_num=${ca_num}">해제</a>
						</c:if>
					</td>					
				</c:when>
				</c:choose>
				<td>${board.nickName}</td>
				<td>${board.b_date}</td>
				<td>${board.bHit}</td>
			</tr>	
			</c:forEach>
    </tr>
    
  </tbody>
</table>
<button onclick="writeGo()" class="btn btn-outline-primary" id="writeBtn">글쓰기</button>
</div>
<!-- 페이지 넘버 부분 -->
    <br>
    <div id="downdown">
    <div id="pageForm" align="center">
        <c:if test="${startPage != 1}">
            <a href='./boardList?page=${startPage-1}&ca_num=${ca_num}&opt=${opt}&condition=${condition}'>[ 이전 ]</a>
        </c:if>
        
        <c:forEach var="pageNum" begin="${startPage}" end="${endPage}">
            <c:if test="${pageNum == spage}">
                ${pageNum}&nbsp;
            </c:if>
            <c:if test="${pageNum != spage}">
                <a href='./boardList?page=${pageNum}&ca_num=${ca_num}&opt=${opt}&condition=${condition}'>${pageNum}&nbsp;</a>
            </c:if>
        </c:forEach>
        
        <c:if test="${endPage != maxPage }">
            <a href='./boardList?page=${endPage+1 }&ca_num=${ca_num}&opt=${opt}&condition=${condition}'>[다음]</a>
        </c:if>
    </div>
    
    <!--  검색 부분 -->
    <br>
    <div align="center">
            <select id="opt" name="opt">
                <option value="0">제목</option>
                <option value="1">내용</option>
                <option value="2">제목+내용</option>
                <option value="3">글쓴이</option>
            </select>
            <input type="text" size="20" name="condition"/>&nbsp;
            <input id="boardSearch" class="btn btn-primary" type="button" value="검색"/>    
    </div>
</div>    
</body>
<script>
$(".tablediv").append($("#downdown"));
	var session = "${sessionScope.loginId}"
		function writeGo(){
			if(session ==""){
				alert("로그인이 필요한 서비스 입니다.");
			}else{
				location.href='./boardWriteForm?ca_num=${ca_num}'
			}
		}
	$(".2").css('font-size','20');
	$(".2").css('font-weight','bold');
	$(".idx2").html("공지");
	
	$("#boardSearch").click(function(){
		if($("input[name='condition']").val()!=""){
			var optValue = $("#opt").val();
			var condition = $("input[name='condition']").val();
			var caNum = "${ca_num}";
			location.href='./boardList?ca_num='+caNum+'&condition='+condition+'&opt='+optValue;
		}
	});
	
	</script>
