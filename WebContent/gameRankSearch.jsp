<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel= "stylesheet" type="text/css" href="./css/literacss.css">
<title>Insert title here</title>
<style>
</style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <a class="navbar-brand">전적 검색</a>
  <div class="collapse navbar-collapse" id="navbarColor02">
      <input class="form-control mr-sm-2" type="text" id="nick"  placeholder="닉네임을 입력해주세요">
      <button class="btn btn-secondary my-2 my-sm-0" onclick = "next()">찾기</button>
  </div>
</nav>
<br>
  <table class="table table-hover" id = "listTable" >
      	</table>
</body>
<script>

	function next(){
	$( '#listTable').empty();
	$.ajax({
		type:"post",
		url:"./rankSearch",
		data:{
			nickname : $("#nick").val()
		},
		dataType:"json",
		success:function(data){
			console.log(data);
			console.log(data.rankInfo);
			if(data.rankInfo[0].count==0){
				var content="";
				content+= "<tr>"
				content+= "<th>닉네임</th>"  ;
				content+= "<th>오늘 랭킹</th>";
				content+= "<th>주간 랭킹</th>";
				content+= "<th>승리 횟수 </th>";
				content+= "<th>성공률</th>";
				content+= "</tr>";

				content+="<tr><td colspan='5'>기록이 존재하지 않습니다.</td></tr>";
				
				$("#listTable").append(content);
			}else{
				searchPrint(data.rankInfo);
			}
		},
		error:function(error){console.log(error)
			alert("fail");}
	});
	}

	function searchPrint(search){
		console.log(search);
		//{idx, user_name, subject, reg_date, bHit}
		var content="";
		search.forEach(function(item, index){
			
			content+= "<tr>";
			content+= "<th>닉네임</th>"  ;
			content+= "<th>오늘 랭킹</th>";
			content+= "<th>주간 랭킹</th>";
			content+= "<th>승리 횟수 </th>";
			content+= "<th>성공률</th>";
			content+= "</tr>";
			
			
			content+="<tr>";
			content+="<td >"+item.nickname+"</td>";
		//	content+="<td onclick ="+" 'profile(event,"text3","${rk.r_id}")'"+" onmouseout='itemRemove2()'>"+item.nickname+"</td>";
			content+="<td>"+item.rankToday+"</td>";
			content+="<td>"+item.rankWeek+"</td>";
			content+="<td>"+item.count+"</td>";
			content+="<td>"+item.percentV+"</td>";
			content+="</tr>";
		});
		$("#listTable").append(content);
	}
	//<td onclick = 'profile(event,"text3","${rk.r_id}")'  onmouseout='itemRemove2()'>
</script>
</html>