<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<link rel= "stylesheet" type="text/css" href="./css/literacss.css">
<title>Insert title here</title>
<style>
#search{
    width:330px;
 }
 #navbarColor01{
    width:330px;
 }

 a:link{text-decoration: none;}
 a:visited{text-decoration: none;}
 a:hover{text-decoration: none;}
 
 .nn{
    visibility: hidden;
 }
 #friend{
    text-align: center;
 }
 .friendDel{
    visibility: hidden;
 }
  #custom-menu {
    z-index:1000;
    position: absolute;
    background-color : #e2e4e7;
	width : 110px;
	text-align: center;
</style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary" id="search">
  <div class="collapse navbar-collapse" id="navbarColor01">
    &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;
    <button class="btn btn-secondary" onclick = "showPopup1()">친구 검색</button>
     &nbsp; &nbsp; &nbsp;
    <button class="btn btn-secondary" onclick = "showDelList()">친구 삭제</button>
  </div>
</nav>
      <br><h5>친구목록</h5>
      <table class="table table-hover">
         <c:forEach items="${friend}" var="fr">
         <tr>
            <td class="frid">${fr.f_id}</td><td width=180px;>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <button  onclick="friendDel('${fr.f_id }')" class="btn btn-outline-primary friendDel">삭제</button>
            </td>
         </tr>
         </c:forEach> 
      </table>
     <!-- <div id="lay2" style="position:absolute;display:none;float: left; "></div>
     <div id="aa" style="position:fixed;border:1px solid black;"></div> -->
</body>
   <script  type="text/javascript">
   
   function friendDel(f_id){
      location.href="./friendDel?f_id="+f_id;
   }
   
   
   function showPopup1(){ 
        window.open("./friendSearch.jsp", "pop2", 
              "width=330, height=330, left=430, top=50, menubar=no, status=no, toolbar=no");
   };

    function showDelList(){
         if($(".friendDel").css("visibility")=='hidden'){
            $(".friendDel").css("visibility","inherit");
         }else{
            $(".friendDel").css("visibility","hidden");
         }
      }
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
   var flag = false;
    var receiver;
    $(".frid").bind("contextmenu", function(event) { 
          event.preventDefault();       
          receiver = event.target.innerHTML;
          console.log(receiver);
          if(!flag){
             $("<div id='custom-menu'><a href='./sendmsgForm.jsp?id="+receiver+"'>쪽지 보내기</a><br/><a href='#' onclick='watchPro()'>프로필 보기</a></div>")
              .appendTo("body")
              .css({top: event.pageY + "px", left: event.pageX + "px"});
             flag=true;
             console.log(flag);
          }else{
             var element = document.getElementById("custom-menu");
             element.parentNode.removeChild(element);
              $("<div id='custom-menu'><a href='./sendmsgForm.jsp?id="+receiver+"'>쪽지 보내기</a><br/><a href='#' onclick='watchPro()'>프로필 보기</a></div>")
                 .appendTo("body")
                 .css({top: event.pageY + "px", left: event.pageX + "px"});
          }
      });
      $(document).bind("click", function(event) {
         if(flag){
             var element = document.getElementById("custom-menu");
            element.parentNode.removeChild(element);
             flag=false;
         }
      });
      
      //////////////////////////////////////////////////////////////
      function watchPro(){  
               window.open("./watchFriend.jsp?nickName="+receiver, "pop77", "width=280, height=185, left=600, top=50, status=no"); 
      }
      
       //////////////////////////////////////////////////////////////////////////////////   
        /*   $(function(){
             $(document).mousemove(function(e) {
                 mouseX = e.pageX;
                 mouseY = e.pageY;
                 $('#aa').css("left", mouseX+15).css("top", mouseY+15).html("x:"+mouseX+" y:"+mouseY);
            });
           }); */
          
      </script>
</html>