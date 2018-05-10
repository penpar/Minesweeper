<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>Insert title here</title>
      <script src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
      <link rel= "stylesheet" type="text/css" href="./css/literacss.css">
      <link rel = "stylesheet" href="./css/custom.css">
      <style>        
         .card border-primary mb-3 {
            margin-top: 33px;
               margin-bottom: 33px; 
         } 
         
         .card-header {
            color: 3399ff ;
         }
           
         #avata {

            width:98.18px;
            height: 113.64px; 
           padding: 5;
            position: relative;
         }
            
        #allCount {
             font-size: 16px;
            color: #666666;
            position: absolute;
            width: 110px;
            top: 50px;
            left: 100px;
            font-family: 'Noto Sans KR';
        }
               
          #winCount {
             font-size: 16px;
           color: #666666;
            position: absolute;
            width: 100px;
            top: 70px;
            left: 100px;
            font-family: 'Noto Sans KR';
        }
            
       #winPercent {
           font-size: 16px;
              color: #666666;
            position: absolute;
             width: 130px;
            top: 90px;
              left: 100px;
              font-family: 'Noto Sans KR';       
         }
            
        #maxTime {
             font-size: 16px;
            color: #666666;
            position: absolute;
            width: 130px;
            top: 110px;
            left: 100px;
           font-family: 'Noto Sans KR';       
        }
            
          #memberUpdate {
           padding: 2;
            position: absolute;
            top: 135px;
            width: 110px;
            left: 100px;
         }
            
        #LogOff {
            left: 125px;
            position: absolute;
            top:8px;
            botton: 100px;
            width: 160px;
        }
        
        #messagebox {
           padding: 2;
            position: absolute;
            top: 135px;
            width: 68px;
            left: 220px;
         }
      </style>
   </head>
   <body>  
   <br/>
      <div class ="card border-primary mb-3" style="max-width: 20rem;">
         <div class ="card-header">
            <div class="text-primary" id = "nickname">닉네임</div>
        </div> 
        
        <div id = "avata">아바타</div> 
        <div id = "LogOff">
           <button onclick = "showPopup()" class="btn btn-primary btn-sm">FRIEND</button>
            <button onclick="location.href='./logout'" class="btn btn-primary btn-sm">LOGOUT</button>
        </div>
            <h3 id = "allCount">게임횟수</h3>
            
            <h3 id = "winCount">승리횟수</h3>
            <h3 id="winPercent">승률</h3>
            <h3 id="maxTime">최고기록</h3>
            <button type="button" id="memberUpdate"class="btn btn-primary btn-sm">회원정보 수정</button>
            <button type="button" id="messagebox"class="btn btn-primary btn-sm">쪽지함</button>
      </div>
   </body>
   <script>
         $("#avata").click(function(){
            window.open("./avataList.jsp", "pop22", "width=935px, height=530px, left=50%, top=50%, status=no"); 
         });         
         $("#memberUpdate").click(function(){
            window.open("./memberUpdate.jsp", "pop33", "width=500px, height=589px, left=50%, top=50%, status=no");
         });
         
         $("#messagebox").click(function(){
             window.open("./receivemsg", "pop1", "width=500px, height=589px, left=50%, top=50%, status=no");
          });
   </script>
</html>