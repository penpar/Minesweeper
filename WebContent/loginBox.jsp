<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
 
    <link href="./css/logbox.css" rel="stylesheet">
     <link href="css/font-awesome.min.css" rel="stylesheet">
     <link href="css/style.css" rel="stylesheet">
 	<style type="text/css">
 	</style>

  </head>
  <body>
    <div class="container">
      <div class="row">
        <div class="page-header">
        </div>
        <div class="col-md-3">
          <div class="login-box well">
        <form accept-charset="UTF-8" role="form" method="post" action="login">
        <legend>로그인</legend>
            <div class="form-group">
                <input name="id" value='' id="username-email" placeholder="아이디를 입력해주세요" type="text" class="form-control" />
            </div>
            <div class="form-group">
                <input name="pw" id="password" value='' placeholder="비밀번호를 입력해주세요" type="password" class="form-control" />
            </div>
            <div class="form-group">
                <input type="submit" class="btn btn-default btn-login-submit btn-block m-t-md" value="login" />
            </div>
            <div class="form-group">
                <a value="join" onclick="joinPop()" class="btn btn-default btn-block m-t-md"> 회원가입</a>
            </div>
        </form>
          </div>
        </div>
      </div>
    </div>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  </body>
  		<script>
		function joinPop(){
			window.open("./joinForm.jsp", "pop3", width = "500px" , height ="200px", left="100", top = "50");
			
		}
		</script>
  </html>