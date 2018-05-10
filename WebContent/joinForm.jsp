<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins">
      <link rel = "stylesheet" href="./css/bootstrap.css">
      <link rel = "stylesheet" href="./css/custom.css">
      <script src="./js/snow.js"></script>
      <link rel= "stylesheet" type="text/css" href="./css/snow.css">
      <title>회원가입</title>
      <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
      <script src="./js/bootstrap.js"></script>
      <script type="text/javascript">
       
          var chkD = false;
      var chkN = false;
      function overId(){
         chkD = false;
      }
      
      function overNick(){
         chkN = false;
      }
      function send(){
         
            $.ajax({
               type: 'POST',
               url: './join',
               data: {
                  userID : $("#userID").val(),
                  userPassword1 : $("#userPassword1").val(),
                  userPassword2 : $("#userPassword2").val(),
                  userName : $("#userName").val(),
                  birthyy : $("#birthyy").val(),
                  birthmm : $("#birthmm").val(),
                  birthdd : $("#birthdd").val(),
                  userGender : $("input[name='userGender']:checked").val(),
                  userEmail : $("#userEmail").val(),
                  userNickName : $("#userNickName").val(),
                  overlayD : chkD,
                  overlayN : chkN
                  },
               success: function(result) {
                  console.log(result);

                  if(result == -2) {
                     $("#checkMessage").html("모든 내용을 입력하세요.");
                     $("#checkType").attr("class", "modal-content panel-warning");
                  }else if(result == -1) {
                     $("#checkMessage").html("비밀번호를 동일하게 입력해주세요.");
                     $("#checkType").attr("class", "modal-content panel-warning");
                  }else if(result == -3) {
                     $("#checkMessage").html("아이디 중복체크 해주세요.");
                     $("#checkType").attr("class", "modal-content panel-warning");
                  }else if(result == -4) {
                     $("#checkMessage").html("닉네임 중복체크 해주세요.");
                     $("#checkType").attr("class", "modal-content panel-warning");
                  }else if(result == 0) {
                     $("#checkMessage").html("회원가입에 실패하셨습니다.");
                     $("#checkType").attr("class", "modal-content panel-warning");
                  }else{
                     $("#checkMessage").html("회원가입을 축하드립니다!!");
                     $("#checkType").attr("class", "modal-content panel-success");
                     setTimeout(function(){ move() }, 1000);
                  }
                  $("#checkModal").modal("show");
               }
            })
         }
      
      //아이디 중복체크
      function idChk() {
            var userID = $("#userID").val();
            $.ajax({
               type: 'POST',
               url: './overlay',
               data: {userID : userID},
               success: function(result) {
                  if(result == 1) {
                     $("#checkMessage").html("사용할 수 있는 아이디입니다.");
                     $("#checkType").attr("class", "modal-content panel-success");
                     var oriId = userID;
                     chkD = true;
                  }else {
                     $("#checkMessage").html("사용할 수 없는 아이디입니다.");
                     $("#checkType").attr("class", "modal-content panel-warning");
                  }
                  $("#checkModal").modal("show");
               }
            })
         }
      
      //닉네임 중복확인
      function nickChk() {
         var userNickName = $("#userNickName").val();
         $.ajax({
            type: 'POST',
            url: './nickoverlay',
            data: {userNickName : userNickName},
            success: function(result) {
               if(result == 1) {
                  var oriNick = userNickName;
                  $("#checkMessage").html("사용할 수 있는 닉네임입니다.");
                  $("#checkType").attr("class", "modal-content panel-success");
                  chkN = true;
               }else {
                  $("#checkMessage").html("이미 존재하는 닉네임입니다!");
                  $("#checkType").attr("class", "modal-content panel-warning");
               }
               $("#checkModal").modal("show");
            }
         })
      }
         
         //비밀번호 확인
         function pwChk() {
            console.log("비번1 " +$("#userPassword1").val());
            console.log("비번2 " +$("#userPassword2").val());
            var userPassword1 = $("#userPassword1").val();
            var userPassword2 = $("#userPassword2").val();
            
            if(userPassword1 != userPassword2) {
               $('#passwordCheckMessage').css("color","red");
               $('#passwordCheckMessage').html('비밀번호를 동일하게 입력해주세요.');
            } else{
               $('#passwordCheckMessage').css("color","green");
               $('#passwordCheckMessage').html('비밀번호가 일치합니다.');
            }
         }
         
         //취소버튼 클릭시
         function move() {
            window.close();
         }
      </script>
      <style>
         td {
            font-family : 'Hanna';"
         }
      </style>
   </head>
   
   <body>
      <div class = "container">
         <!-- <form method="post" action="./join"> -->
            <table class = "table table-bordered table-hover" style="text-align: center; border: 1px solid black;">
               <thead>
                  <tr>
                     <th colspan="3"><h4 style="font-family : 'Noto Sans KR';">회원가입</h4></th>
                  </tr>
               </thead>
               <tbody>   
                  <tr>
                     <td style = "width : 110px;"><h5>아이디</h5></td>
                     <td style="font-family : 'Noto Sans KR';">
                        <input class = "form-control" type="text" id="userID" name="userID" 
                           maxLength="20" onkeydown="overId()" placeholder="아이디를 입력하세요.">
                     </td>
                     <td style = "width: 110px; font-family : 'Hanna';" >
                        <button class="btn btn-primary" type="button" onclick="idChk()">중복 확인</button>
                     </td>
                  </tr>
                  <tr>
                     <td style = "width : 110px;"><h5>비밀번호</h5></td>
                     <td colspan="2" style="font-family : 'Noto Sans KR';"> 
                        <input class = "form-control" type="password" id="userPassword1" name="userPassword1" 
                           onkeyup="pwChk()" maxLength="20" placeholder="비밀번호를 입력하세요.">
                     </td>
                  </tr>
                  <tr>
                     <td style = "width : 110px;"><h5>비밀번호 확인</h5></td>
                     <td colspan="2" style="font-family : 'Noto Sans KR';">
                        <input class = "form-control" type="password" id="userPassword2" name="userPassword2" 
                           onkeyup="pwChk()" maxLength="20" placeholder="비밀번호 확인을 입력하세요.">
                     </td>
                  </tr>
                  <tr>
                     <td style = "width : 110px;"><h5>이름</h5></td>
                     <td colspan="2" style="font-family : 'Noto Sans KR';">
                        <input class = "form-control" type="text" id="userName" name="userName"
                            maxLength="20" placeholder="이름을 입력하세요.">
                     </td>
                  </tr>
                  <tr>
                     <td style = "width : 110px;"><h5>닉네임</h5></td>
                     <td style="font-family : 'Noto Sans KR';">
                        <input class = "form-control" onkeydown="overNick()" type="text" id="userNickName" name="userNickName" 
                           maxLength="20" placeholder="닉네임을 입력하세요.">      
                     </td>
                     <td style = "width: 110px; font-family : 'Hanna';">
                        <button class="btn btn-primary" type="button" onclick="nickChk()">중복 확인</button>
                     </td>
                  </tr>
                  <tr>
                     <td style = "width : 110px;"><h5>생년월일</h5></td>
                     <td colspan="2" style="font-family : 'Noto Sans KR';">
                              <select id="birthyy" name="birthyy">
                                     <%for(int i=2012; i>=1950; i--){ %>
                                        <option value="<%=i %>"><%=i %></option>
                                     <%} %>
                                </select>년&nbsp;
                       
                                <select id="birthmm" name="birthmm">
                                     <%for(int i=1; i<=12; i++){ %>
                                        <option value="<%=i %>"><%=i %></option>
                                     <%} %>
                                </select>월
        
                                <select id="birthdd"name="birthdd">
                                     <%for(int i=1; i<=31; i++){ %>
                                        <option value="<%=i %>"><%=i %></option>
                                     <%} %>
                                </select>일
                    
                        </td>
                     </tr>
                  <tr>
                     <td style = "width : 110px;"><h5>성별</h5></td>
                     <td colspan="2" style="font-family : 'Hanna';">
                        <div class ="form-group" style="text-align: center; margin: 0 auto;">
                           <div class="btn-group" data-toggle="buttons">
                              <label class= "btn btn-primary active">
                                 <input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자
                              </label>
                              <label class= "btn btn-primary">
                                 <input type="radio" name="userGender" autocomplete="off" value="여자">여자
                              </label>
                           </div>
                        </div>
                     </td>   
                  <tr>
                     <td style = "width : 110px;"><h5>이메일</h5></td>
                     <td colspan="2" style="font-family : 'Noto Sans KR';">
                        <input class = "form-control" type="text" id="userEmail" name="userEmail" 
                           maxLength="20" placeholder="이메일을 입력하세요.">
                     </td>
                  </tr>
                  <tr>
                     <td style="text-align: left" colspan="3">
                        <h5 style="color: red;" id="passwordCheckMessage"></h5>
                        <input class = "btn btn-primary pull-right" type="button" onclick="move()" value="취소">
                        <input id = "send" onclick ="send()" class = "btn btn-primary pull-right" type="button" value="회원가입">      
                     </td>
                  </tr>
                  
               </tbody>
            </table>
         <!-- </form> -->
      </div>
      <%
         String messageContent = null;
         if(session.getAttribute("messageContent") != null) {
            messageContent = (String) session.getAttribute("messageContent");
         }
         
         String messageType = null;
         if(session.getAttribute("messageType") != null) {
            messageType = (String) session.getAttribute("messageType");
         }
         
         if(messageContent != null) {
            
         
      %>
         <div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class = "vertical-aligment-helper">
               <div class="modal-dialog vertical-aligment-center">
                  <div class="modal-content  <% if(messageType.equals("오류 메세지")) out.println("panel-warning"); else out.println("panel-success"); %>">
                     <div class="modal-header panel-heading">
                        <button type="button" class="close" data-dismiss="modal">
                           <span aria-hidden="true">&times;</span>
                           <span class = "sr-only">Close</span>
                        </button>
                        <h4 class="modal-title">
                           <%= messageType %>
                        </h4>
                     </div>
                     <div class="modal-body">
                        <%= messageContent %>
                     </div>
                     <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         <script>
            $("#messageModal").modal("show");
         </script>
      <%
         session.removeAttribute("messageContent");
         session.removeAttribute("messageType");
         }
      %>
      <div class="modal fade" id="checkModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class = "vertical-aligment-helper">
               <div class="modal-dialog vertical-aligment-center">
                  <div id="checkType" class="modal-content  panal-info">
                     <div class="modal-header panel-heading">
                        <button type="button" class="close" data-dismiss="modal">
                           <span aria-hidden="true">&times;</span>
                           <span class = "sr-only">Close</span>
                        </button>
                        <h4  style="font-family : 'Noto Sans KR';" class="modal-title">
                           확인 메세지
                        </h4>
                     </div>
                     <div  style="font-family : 'Noto Sans KR';" class="modal-body" id="checkMessage">
                     </div>
                     <div  style="font-family : 'Noto Sans KR';" class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
                     </div>
                  </div>
               </div>
            </div>
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
</html>