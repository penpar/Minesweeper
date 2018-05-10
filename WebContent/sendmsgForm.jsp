<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel= "stylesheet" type="text/css" href="./css/literacss.css">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<form action="./sendmsg" method="post">
		<table  class="table table-hover">
			<tr>
				<td>To. ${param.id}</td>
				<input type="hidden" name="to" value="${param.id}">
			</tr>
			<tr>
				<td>From. ${sessionScope.loginId}</td>
				<input type="hidden" name="from" value="${sessionScope.loginId}">
			</tr>
			<tr>
				<td><textarea class="form-control"  row="30" col="100" name="content"></textarea></td>
			</tr>
			<br>
			<tr>
				<td>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input class="btn btn-primary" type="submit" value="보내기">
					<input class="btn btn-primary" type="button" value="취소" onclick="location.href='friendList'">
				</td>
			</tr>
		</table>
		</form>
	</body>
</html>