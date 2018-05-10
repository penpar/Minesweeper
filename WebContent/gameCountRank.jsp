<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<script src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
	<link rel= "stylesheet" type="text/css" href="./css/literacss.css">
	</head>
	<body>

	    
	     
      <table class="table table-hover">
         <tr class="table-danger" onmouseover='itemClick(event,"text2")' onmousemove='msgmove(event)' onmouseout='itemRemove()'>
           <th colspan = 4>명예 전당</th>
         </tr>
         <tbody>
             <tr class="table-active">
           <th>랭크</th><th>닉네임</th> <th>총 승리</th><td>승률</td>
         </tr>
         <c:forEach items="${crank}" var="rk" varStatus="status">
         <tr>
            <td>${status.count}</td><td onclick = 'profile(event,"text3","${rk.r_id}")'  onmouseout='itemRemove2()'>${rk.r_id}</td><td>${rk.count}</td><td>${rk.percentV}</td>
         </tr>
         </c:forEach>
         </tbody> 
      </table>
	</body>
	<script>

	
	</script>
	
	
</html>


