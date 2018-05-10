<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="./css/lebar.css">
		
		<title>Insert title here</title>
		<script src = "https://code.jquery.com/jquery-3.2.1.min.js"></script>
		<style>
		body,h1,h2,h3,h4,h5 {font-family: "Poppins", sans-serif}
		body {font-size:16px;}
		.w3-half img{margin-bottom:-6px;margin-top:16px;opacity:0.8;cursor:pointer}
		.w3-half img:hover{opacity:1}
			.loginBoxNprop{
				margin-top:-60px;
			}
			.w3-bar-block{
				
			}
			#logo{
				width: 100%;
				cursor: pointer;
			}
		</style>
	</head>
	<body>
		<div class="leftbar">
			<nav class="w3-sidebar w3-blue w3-collapse w3-top w3-large w3-padding" style="z-index:3;width:320px;font-weight:bold; overflow: hidden;" id="mySidebar"><br>
		 		 <a href="javascript:void(0)" onclick="w3_close()" class="w3-button w3-hide-large w3-display-topleft" style="width:100%;font-size:22px">Close Menu</a>
		   		 		<img id="logo" alt="로고입니다" src="./common/logo.png">
						<%-- <c:if test="${sessionScope.loginId ==null}"> --%>
						<div class="loginBoxNprop">
		         		<%-- <jsp:include  page="./loginBox.jsp"/> --%>
		         		</div>
		        		<%-- </c:if> --%>
		  		
		  		<!-- 프로필박스 -->
		  		<%-- <div class="propile">
		          	&nbsp; ${sessionScope.loginId } &nbsp;&nbsp;<button onclick="location.href='./logout'">x</button>
		          	<button onclick = "showPopup()">친구 목록</button><br/>
		          	<div class="avata">avata</div><br/><br/><br/><br/>
	          	</div>  --%>
	          	<!-- 사이드메뉴바 -->
	          	
		  		<div class="w3-bar-block">
				    <a href="#" onclick='game()' class="w3-bar-item w3-button w3-hover-white">게임하기</a><br/><br/>
		          	<a href="#" onclick='rank()' class="w3-bar-item w3-button w3-hover-white">랭킹</a><br/><br/>
		          	<a href="#" onclick='free()' class="w3-bar-item w3-button w3-hover-white">자유게시판</a><br/><br/>
		          	<a href="#" onclick='tip()' class="w3-bar-item w3-button w3-hover-white">공략게시판</a><br/><br/>
		  		</div>
			</nav>
		</div>
	</body>
	<script src="siteSecurity.js"></script>
	<script>
	/*************
	name : siteSecurity.js
	************/
	$(function(){

		$('body').siteSecurity({

			f12:'y', //f12키 막기

			rightclick: 'y', //우클릭 막기

			select:'y', //선택 막기

			drag:'y', //드래그 막기

			execptionip:'192.168.0.145' //예외 아이피
		});
	});
	</script>
	<script>
		var session = "${sessionScope.loginId}"
		$("#logo").click(function(){
			location.href="./index.jsp";
		});
		
		$(document).ready(function(){
			$.ajax({
				type:"get",
				url:"./profile",
				dataType:"JSON",
				success:function(data){
					console.log(data);
					console.log(data.status);
					if(data.status == 0){
						$(".loginBoxNprop").load("./loginBox.jsp",
						function(res,stat){						
						});
					}else{
						$(".loginBoxNprop").load("./profilebox.jsp",
						function(res,stat){							
							$("#nickname").html(data.dto.userNickName);
							console.log("쪽지함 : "+data.newmsg);
							$("#messagebox").html("쪽지함("+data.newmsg+")");
		                     if(data.dto.allCount==0){
		                    	 $("#allCount").html("게임횟수: --");
		                     }else{
		                    	 $("#allCount").html("게임횟수: "+data.dto.allCount);
		                     }
		                     
		                     if(data.dto.winCount==0){
		                    	 $("#winCount").html("승리횟수: --");
		                     }else{
		                    	 $("#winCount").html("승리횟수: "+data.dto.winCount);
		                     }
		                     
		                     var winPercent = ((data.dto.winCount/data.dto.allCount)*100).toFixed(2);
		                     if(winPercent=="NaN"){
		                    	 $("#winPercent").html("승률: --%");
		                     }else{
		                    	 $("#winPercent").html("승률: "+winPercent+"%");
		                     }
		                     
		                     if(data.dto.maxTime==0){
		                    	 $("#maxTime").html("최고기록: --초");
		                     }else{
		                    	 $("#maxTime").html("최고기록: "+data.dto.maxTime+"초");
		                     }
		                     
							if(data.dto.avataPhoto !=null){
								switch(data.dto.avataPhoto){
								case"avaOne":
										$("#avata").html("<img src='./avata/avataOne.png' width='100%' height='100%'>");
									break
								case"avaTwo":
										$("#avata").html("<img src='./avata/avataTwo.png' width='100%' height='100%'>");
									break
								case"avaThree":
										$("#avata").html("<img src='./avata/avataThree.png' width='100%' height='100%'>");
									break
								case"avaFour":
										$("#avata").html("<img src='./avata/avataFour.png' width='100%' height='100%'>");
									break
								case"avaFive":
										$("#avata").html("<img src='./avata/avataFive.png' width='100%' height='100%'>");
									break
								case"avaSix":
		                              $("#avata").html("<img src='./avata/avataSix.png' width='100%' height='100%'>");
		                           break
		                        case"avaSeven":
		                              $("#avata").html("<img src='./avata/avataSeven.png' width='100%' height='100%'>");
		                           break
		                        case"avaEight":
		                              $("#avata").html("<img src='./avata/avataEight.png' width='100%' height='100%'>");
		                           break
								}
							}else{
								$("#avata").html("<img src='./common/default.png' width='100%' height='100%'>");
							}
						});	
					}					
				},
				error:function(error){
					console.log(error)
				}
			});
			
			//관리자모드 메뉴 만들어주기
			var state= "${sessionScope.state}";
			console.log("상태"+state);
			if(state==2){
				var context = "<a href='./memberList' class='w3-bar-item w3-button w3-hover-white'>회원관리<a/>"
				$(".w3-bar-block").append(context);
			}
		});

		function game(){//게임하기 클릭
			if(session==""){
				alert("로그인이 필요한 서비스입니다.")
			}else{
				location.href="./mine.jsp";
			}
		}
		
		function rank(){//랭킹 보기 클릭
			if(session==""){
				alert("로그인이 필요한 서비스입니다.")
			}else{
				location.href="./gameRank";
			}
		}
		
		function free(){//자유게시판 클릭
			if(session==""){
				alert("로그인이 필요한 서비스입니다.")
			}else{
				location.href="./boardList?ca_num=0";
			}
		}
		
		function tip(){//공략 게시판 클릭
			if(session==""){
				alert("로그인이 필요한 서비스입니다.")
			}else{
				location.href="./boardList?ca_num=1";
			}
		}
		
		
		function showPopup(){ // 친구목록 팝업창
			  window.open("./friendList", "pop1", "width=330, height=350, left=10, top=50, status=no"); 
		}
		/* if(session !=""){
			$(".propile").css("display","block");
		} */
	</script>
</html>