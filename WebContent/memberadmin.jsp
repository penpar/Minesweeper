<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>Insert title here</title>
      <script src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
      <script src="./js/snow.js"></script>
      <link rel= "stylesheet" type="text/css" href="./css/literacss.css">
      <link rel= "stylesheet" type="text/css" href="./css/snow.css">
      <style>
         table,td{
            text-align: center;
            position: relative;
         }
         #aaa{
            position: absolute;
            left : 350px;
            height : 100%;
         }
         #relative{
            position: absolute;
               width: 100%;
               height: 100%;
            overflow: auto;
         }
      </style>
   </head>
   <body>
   <jsp:include page="./leftBar.jsp"/>
   <div id ="relative">
      <div id="aaa">
      <br>
      <h3 class="text-success">회원관리</h3>
      <table class="table table-hover">
         <tr  class="table-success">
            <th>아이디</th>
            <th>닉네임</th>
            <th>이메일</th>
            <th>생년월일</th>
            <th>정지</th>
            <th>정지 내역</th>
         </tr>
         <c:forEach items="${list}" var="user">
            <tr>
               <td>${user.userID}</td>
               <td>${user.userNickName}</td>
               <td>${user.userEmail}</td>
               <td>${user.userAge}</td>
               <c:choose>
                  <c:when test="${user.state==0}">
                     <td><button class="btn btn-outline-success" onclick="banForm('${user.userID}')">정지</button></td>
                  </c:when>
                  <c:when test="${user.state==1}">
                     <td><button class="btn btn-outline-warning" onclick="location.href='./cancel?id=${user.userID}'">해제</button></td>
                  </c:when>
                  <c:when test="${user.state==2}">
                     <td>관리자</td>
                  </c:when>
               </c:choose>
               <c:if test="${user.userID!='2jomoji'}">
               <td><button  class="btn btn-success" onclick="banexp('${user.userID}')">정지내역 조회</button></td>
               </c:if>
            </tr>   
         </c:forEach>   
      </table>
      </div>
      
            
      </div>
   </body>
   <script>
      function banForm(a){
         var url = "./banForm.jsp?id="+a;
         window.open(url , "pop1", "width=400, height=490, left=800, top=300, status=no"); 
      }
      function banexp(a){ //정지내역
         console.log(a);
         var url = "./banexp?id="+a;
         window.open(url , "pop1", "width=400, height=300, left=800, top=300, status=no");
      }
   </script>
</html>