<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
		<style>
			#login{
				margin: 10px 0;
				width: 100%;
				text-align: right;
			}
		</style>
	</head>
	<body onload="loginChk()">
		<div id="login"></div>
	</body>
	<script>
		function loginChk(){
			var loginId = "${sessionScope.loginId}";
			
			if(loginId == ""){
				alert("로그인이 필요한 서비스 입니다.");
				location.href="./index.jsp";
			}else{
				var content = loginId +" 님, 반갑습니다.";
				content += "<button onclick='logout()'>로그아웃</button>"
				$("#login").html(content);
			}
		}
		
		function logout(){
			location.href="./logout";
		}
	</script>
</html>