<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel= "stylesheet" type="text/css" href="./css/literacss.css">
<script src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
<title>Insert title here</title>
<style>
#search{
 	width:330px;
 }
 #navbarColor01{
 	width:330px;
 }
 #a{
 	width : 230px;
 }
</style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary" id="search">
  <div class="collapse navbar-collapse" id="navbarColor01">
    <form id="friendForm" class="form-inline my-2 my-lg-0" action = "/Minesweeper/friendSearch" method = "post">
      <input  id="a"class="form-control mr-sm-2" type="text" name="id" placeholder="닉네임을 입력해주세요">
      &nbsp;<button class="btn btn-secondary my-2 my-sm-0" id = "searchNBtn" type="submit">검색</button>
    </form>
  </div>
</nav>
<div>
		<form action = "./friendUpdate" method = "post">
		      <table>
		         <tr>
		           <c:if test="${s_friend == null}">
		         <tr>
		            <td id = "friendName" colspan=5> 친구를 검색해 주세요.</td> 
		         </tr>
		         </c:if>
		         <c:forEach items="${s_friend}" var="fr">
		         <tr>
		            <td id="frinedSer">${fr.f_id}</td>
		            <td>&nbsp;&nbsp;<button id="lonely" type="submit" class="btn btn-outline-primary" onclick = "showPopup()">추가</button></td>
		           </tr>
		         </c:forEach> 
		      </table>      
		   </form>
   </div>
</body>
   <script>  
   
   var fId = "${s_friend[0].id}"
   var session = "${sessionScope.loginId}"
   
   if(fId==session){
	   $("#frinedSer").html("본인은 친구가 될 수 없습니다.");
	   $("#lonely").css("display","none");
	 }
   
   function showPopup(){ // 팝업창  
        window.open("./friendList", "pop1", "width=330, height=330, left=100, top=50, status=no"); 
      
   }
	
   </script>
</html>