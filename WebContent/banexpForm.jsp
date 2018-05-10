<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel= "stylesheet" type="text/css" href="./css/literacss.css">
		<title>Insert title here</title>
	</head>
	<style>
		table{
			text-align: center;
		}
		#oo{
			position: absolute;
			left:165px;
		}
	</style>
	<body>
		<table class="table table-hover">
			<tr class="table-warning">
				<td>사유</td>
				<td>정지날짜</td>
			</tr>
			<c:forEach items="${list}" var="exp">
				<tr>
					<td>${exp.reason}</td>
					<td>${exp.ban_date}</td>
				</tr>
			</c:forEach>
		</table>
		<button  id="oo" onclick="confirm()" class="btn btn-warning">확인</button>		
	</body>
	<script>
		function confirm(){
			window.close();
		}
	</script>
</html>