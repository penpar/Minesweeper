<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<script src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
	<style>
			td,tr{
				text-align: center;
			}
			#div1{
				position: absolute;
				left : 350px;
				height : 100%
			}
			
      
            
      </style>
			
			

</head>
<body>

<jsp:include page="./leftBar.jsp"/>

<div id="div1">
<div style="float: left; width: 500px;">
<br>
<h3 class="text-info">랭킹</h3>
<jsp:include page="./gameTodayRank.jsp"/>
</div>
<div style="float: left; width: 500px;">
<br>
<h3 class="text-info"> &nbsp;</h3>
<jsp:include page="./gameWeekRank.jsp"/>
</div>
<div style="float: left; width: 500px;">
<br>
<h3 class="text-info">&nbsp;</h3>
<jsp:include page="./gameCountRank.jsp"/>
</div>
<div style="float: left; width: 100%; height : 100px">
</div>
<div style="float: left; width: 500px; ">
	<jsp:include page="./gameRankSearch.jsp"/>
</div>

	   

</body>



</html>