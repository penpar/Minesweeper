<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
   <head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <title>Insert title here</title>
   <script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
   <link rel= "stylesheet" type="text/css" href="./css/literacss.css">
   <style>
      body{
         margin-left: 50px;
         
      }
      #avataChoice{
      	position: absolute;
      	left: 44%;
      }
   </style>
   </head>
   <body ondragstart="return false">
      
            <label>
            <input type="radio" name="avata" value="avaOne"/>&nbsp;&nbsp;지뢰를 선물하네오<br/><img src="./avata/avataOne.png">
         </label>&nbsp;&nbsp;
         <label>
            <input type="radio" name="avata" value="avaTwo"/>&nbsp;&nbsp;지뢰를 품은 튜브<br/><img src="./avata/avataTwo.png">
         </label>&nbsp;&nbsp;
         <label>
            <input type="radio" name="avata" value="avaThree"/>&nbsp;&nbsp;폴짝폴짝 어피치<br/><img src="./avata/avataThree.png">
         </label>&nbsp;&nbsp;
         <label>
            <input type="radio" name="avata" value="avaFour"/>&nbsp;&nbsp;두둠칫 라이언<br/><img src="./avata/avataFour.png">
         </label><br/>
         <label>
            <input type="radio" name="avata" value="avaFive"/>&nbsp;&nbsp;덩실덩실 지뢰댄스<br/><img src="./avata/avataFive.png">
         </label>&nbsp;&nbsp;
         <label>
            <input type="radio" name="avata" value="avaSix"/>&nbsp;&nbsp;지뢰 무료나눔해요~<br/><img src="./avata/avataSix.png">
         </label>&nbsp;&nbsp;
         <label>
            <input type="radio" name="avata" value="avaSeven"/>&nbsp;&nbsp;삑-! 지뢰입니다<br/><img src="./avata/avataSeven.png">
         </label>&nbsp;&nbsp;
         <label>
            <input type="radio" name="avata" value="avaEight"/>&nbsp;&nbsp;지뢰를 받아라!<br/><img src="./avata/avataEight.png">
         </label><br/>
         
         
         <input class="btn btn-primary" type="button" id="avataChoice" value="아바타 선택">
         
      
   </body>
   <script>
      $("#avataChoice").click(function(){
         console.log($("input[name='avata']:checked").val());
         $.ajax({
            type:"post",
            url:"./avataChoice",
            data:{
               avataNum:$("input[name='avata']:checked").val()
               },
            dataType:"JSON",
            success:function(data){
               if(data.success==1){
                  
                  var avataNum = $("input[name='avata']:checked").val();
                  
                  switch(avataNum){
                  case"avaOne":
                     opener.$("#avata").html("<img src='./avata/avataOne.png' width='100%' height='100%'>");
                     break;
                  case"avaTwo":
                     opener.$("#avata").html("<img src='./avata/avataTwo.png' width='100%' height='100%'>");
                     break;
                  case"avaThree":
                     opener.$("#avata").html("<img src='./avata/avataThree.png' width='100%' height='100%'>");
                     break;
                  case"avaFour":
                     opener.$("#avata").html("<img src='./avata/avataFour.png' width='100%' height='100%'>");
                     break;
                  case"avaFive":
                     opener.$("#avata").html("<img src='./avata/avataFive.png' width='100%' height='100%'>");
                     break;
                  case"avaSix":
                     opener.$("#avata").html("<img src='./avata/avataSix.png' width='100%' height='100%'>");
                     break;
                  case"avaSeven":
                      opener.$("#avata").html("<img src='./avata/avataSeven.png' width='100%' height='100%'>");
                      break;
                  case"avaEight":
                      opener.$("#avata").html("<img src='./avata/avataEight.png' width='100%' height='100%'>");
                      break;
                  }
                  window.close();
               }
               console.log(data);
            },
            error:function(e){
               console.log(e);
            }
         });
      });
   </script>
</html>