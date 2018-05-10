<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
   <head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
   <script src="./js/snow.js"></script>
   <link rel= "stylesheet" type="text/css" href="./css/snow.css">
   <style>
   #includeJsp{
      width: 320px;
      height: 974px;
   }
   #lionSnow{
   background-image: url("./common/lion.png");  
   background-size : 1600px 974px; 
   /* width: 1182px; */
   width: 1600px;
   height: 974px;
   position: absolute;
   right: 0px;
}
   #gameHow{
      position: absolute;
      left: 968px;
      top: 530px;
      width: 410px;
      cursor: pointer;
   }
   #gameStart{
      position: absolute;
      left: 968px;
      top: 420px;
      width: 410px;
      cursor: pointer;
   }

   }
   </style>
   </head>
   <body bgcolor="#1A1A1E"  style="overflow:hidden;"/>
         <jsp:include page="./leftBar.jsp"/>

      
      <div id="lionSnow">
         <img  id="gameHow" src="./common/gameHow1.png">
         <img id="gameStart"  src="./common/gameStart1.png">
       </div>
   </body>
   <script>
   		
   		var session = "${sessionScope.loginId}";
   		$("#gameStart").click(function(){
   			if(session==""){
   				alert("로그인이 필요한 서비스 입니다.");
   			}else{
   				location.href="./mine.jsp";
   			}
   		});
   		
   		$("#gameHow").click(function(){
   			if(session==""){
   				alert("로그인이 필요한 서비스 입니다.");
   			}else{
   				location.href="./boardDetail?nickName=운영자&b_key=1&id=&ca_num=1";
   			}
   		});
   		
   		$("#gameHow").mouseover(function(){
   			$("#gameHow").attr("src","./common/gameHow2.png");
   		})
   		$("#gameHow").mouseleave(function(){
   			$("#gameHow").attr("src","./common/gameHow1.png");
   		})
   		$("#gameStart").mouseover(function(){
   			$("#gameStart").attr("src","./common/gameStart2.png");
   		})
   		$("#gameStart").mouseleave(function(){
   			$("#gameStart").attr("src","./common/gameStart1.png");
   		})
   		var msg = "${msg}";
		var reason = "${reason}";
		if(reason!=""){
			alert(msg+"\n\n사유 : "+reason+"\n문의는 2jomoji@naver.com로 보내세요");
		}

   </script>
</html>