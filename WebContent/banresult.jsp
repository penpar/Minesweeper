<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel= "stylesheet" type="text/css" href="./css/literacss.css">
		<title>Insert title here</title>
	</head>
	<style>
		#gggg{
			text-align: center;
		}
	</style>
	<body>
	<div id="gggg">
	<br><br><br><br><br><br>
		<h3 class="text-success">${msg}</h3>
		<br>
		<button onclick="confirm()" class="btn btn-success">확인</button>
		</div>
	</body>
	<script>
		function confirm(){
			opener.parent.location="./memberList";
			window.close();
		}
	</script>
</html>