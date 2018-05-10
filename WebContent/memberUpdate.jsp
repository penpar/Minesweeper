<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
   <head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <title>회원 정보 수정</title>
   <script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
   <link rel= "stylesheet" type="text/css" href="./css/literacss.css">
   <style>
      td,th,tr{
         padding: 5px;
      }
      input[type='text']{
         text-align: center;
      }
      #userName{
         text-align: center;
         border: 0;
      }
      #userID{
         text-align: center;
         border: 0;
      }
      #userAge{
         text-align: center;
         border: 0;
      }
      
      thead th {
         background-color: #1863e6;
         color: white;
         text-align: center;
      }

   </style>
   </head>
   <body>
      <table class="table table-hover" style="text-align: center; border: 1px solid black;width: 100%;">
               <thead>
                  <tr>
                     <th colspan="3"><h5>회원 정보 수정하기</h5></th>
                  </tr>
               </thead>
               <tbody>   
                  <tr>
                     <th style = "width : 110px;" align="center">아이디</th>
                     <td colspan="2">
                        <input class="control-label" type="text" id="userID" name="userID" width='100%' maxLength="20" readonly>
                     </td>
                  </tr>
                  <tr>
                     <th style = "width : 130px;" align="center">비밀번호</th>
                     <td colspan="2">
                        <input class="control-label" type="password" id="userPassword1" name="userPassword1" 
                             onkeyup="pwChk()" maxLength="20" placeholder="비밀번호를 입력하세요">
                     </td>
                  </tr>
                  <tr>
                     <th style = "width : 130px;" align="center">비밀번호 확인</th>
                     <td colspan="2">
                        <input class="control-label" type="password" id="userPassword2" name="userPassword2" 
                           onkeyup="pwChk()" maxLength="20" placeholder="비밀번호를 확인해주세요">
                     </td>
                  </tr>
                  <tr>
                     <th style = "width : 110px;" align="center">이름</th>
                     <td colspan="2">
                        <input class="control-label" type="text" id="userName" name="userName" maxLength="20" readonly>
                     </td>
                  </tr>
                  <tr>
                     <th style = "width : 110px;" align="center">닉네임</th>
                     <td colspan="2">
                        <input class="control-label" type="text" id="userNickName" name="userNickName" >      
                     </td>      
                  </tr>
                  <tr>
                     <th style = "width : 110px;" align="center">생년월일</th>
                        <td colspan="2">
                           <input class="control-label" type="text" id="userAge" name="userAge" width='100%' maxLength="20"  readonly>
                        </td>
                 </tr>
                  <tr>
                      <th style = "width : 110px;" align="center">성별</th>
                       <td colspan="2">
                     <div class="form-group">
                        <label class="custom-control custom-radio">
                            <input type="radio" name="userGender" autocomplete="off" value="남자" class="custom-control-input" checked="">
                            <span class="custom-control-indicator"></span>
                            <span class="custom-control-description">남자</span>
                         </label>
                         <label class="custom-control custom-radio">
                            <input type="radio" name="userGender" autocomplete="off" value="여자" class="custom-control-input">
                            <span class="custom-control-indicator"></span>
                            <span class="custom-control-description">여자</span>
                         </label>
                     </div>
                  </td>
               </tr> 
                  <tr>
                     <th style = "width : 110px;" align="center">이메일</th>
                     <td colspan="2">
                        <input class="control-label" type="text" id="userEmail" name="userEmail" 
                           maxLength="20" placeholder="이메일을 입력하세요.">
                     </td>
                  </tr>
                  <tr>
                     <td style = "height : 95px; text-align: center" colspan="3">
                        <h5 style="color: red;" id="passwordCheckMessage" align="center"></h5>
                        <input class="btn btn-primary" type="button" onclick="move()" value="취소">
                        <input class="btn btn-primary" id = "send" type="button" value="수정">      
                     </td>
                  </tr>
               </tbody>
            </table>
   </body>
   <script>
         
   $(document).ready(function(){
         $.ajax({
            type:"get",
            url:"./memUpdateForm",
            dataType:"JSON",
            success:function(data){
               console.log(data.dto);
               $("#userID").val(data.dto.id);
               $("#userName").val(data.dto.userName);
               $("#userAge").val(data.dto.userAge);
               $("#userNickName").val(data.dto.userNickName);
               $("#userEmail").val(data.dto.userEmail);
            },
            error:function(error){
               console.log(error)
            }
         });
      });
   
         //비번체크
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
         
         //수정 체크
          $("#send").click(function(){
             if($("#userPassword1").val()==""){
                alert("비밀번호 입력해주세요");
             }else if($("#userPassword2").val()==""){
                alert("비밀번호 확인 입력해주세요");
             }else if($("#userPassword1").val() != $("#userPassword2").val()){
                alert("비밀번호 체크 해주세요");
             }else if($("#userNickName").val()==""){
                alert("닉네임 입력해주세요");
             }else if($("#userEmail").val()==""){
                alert("이메일 입력해주세요");
             }else{
                $.ajax({
                        type: 'POST',
                        url: './memberUpdate',
                        data: {
                          id : $("#userID").val(),
                           pw : $("#userPassword1").val(),
                           userGender : $("input[name='userGender']:checked").val(),
                           userEmail : $("#userEmail").val(),
                           userNickName : $("#userNickName").val()
                           },
                        dataType:"JSON",
                        success: function(data) {
                           console.log(data);
                           console.log(data.success);
                        if(data.success==1){
                           alert("수정이 완료되었습니다.");
                                 setTimeout(function(){ move() }, 300);
                        }else{
                           alert("수정이 실패했습니다.");
                        }
                           },
                           error:function(e){
                              console.log(e);
                           }
                        });
                     }
                });
         //취소버튼 클릭시
         function move() {
            window.close();
         }
   </script>
</html>