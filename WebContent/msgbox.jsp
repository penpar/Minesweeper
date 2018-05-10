<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <link rel= "stylesheet" type="text/css" href="./css/literacss.css">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<style>
/* 			table, tr, td, th{
				border: 1px solid black;
				border-collapse: collapse;
				text-align: center;
			} */
			.newmsg{
				font-weight: 900;
			}
			.oldMsg{
				opacity: 0.7;
				color: gray;
			}
		</style>
	</head>
	<body>
		<table class="table table-hover">
			<tr class="table-primary">
				<th>보낸사람</th>
				<th>내용</th>
				<th>보낸시간</th>
			</tr>
			<c:forEach items="${list}" var="msg">
					<c:choose>
						<c:when test="${msg.state == 0}">
						<tr class="newMsg">
						<td>${msg.from}</td>
						<td>${msg.content}</td>
						<td>${msg.date}</td>
						</tr>	
						</c:when>
						<c:when test="${msg.state == 1}">
						<tr class="oldMsg">
						<td>${msg.from}</td>
						<td>${msg.content}</td>
						<td>${msg.date}</td>
						</tr>
						</c:when>
					</c:choose>					
					
			</c:forEach>	
		</table>
	</body>
	<script>
		$(window).bind("beforeunload", function (e){			
			
			opener.parent.console.log("qqqq");
			opener.parent.location.reload();
			return "창을 닫으실래요?";
	
		});
	</script>
</html>