<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel= "stylesheet" type="text/css" href="./css/literacss.css">
<title>Insert title here</title>
<style type="text/css">
 	table, tr, td{

		text-align: center;
	}
</style>
</head>
<body>
	<form action="./ban" method="post">
	<table  class="table table-hover">
		<tr>
			<td>ID</td>
			<td>${param.id}<input type="hidden" name="id" value="${param.id}"></td>			
		</tr>
		<tr>
			<td>사유</td>
			<td><textarea name="reason" rows="15" cols="40"></textarea></td>
		</tr>		
		<tr>
			<td colspan="2"><input type="submit" class="btn btn-success" value="정지"></td>
		</tr>
	</table>
	</form>
</body>
</html>