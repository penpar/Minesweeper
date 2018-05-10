<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<script src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
	<link rel= "stylesheet" type="text/css" href="./css/literacss.css">

	<style type="text/css">
 	table{
 		width : 400px;
 	}
 	</style>
	</head>
	<body>      
      <table class="table table-hover"> 
      
         <tr class="table-info" onmouseover='itemClick(event,"text")' onmousemove='msgmove(event)' onmouseout='itemRemove()'>
          
           <th colspan = 3 >오늘 랭킹</th>
         </tr>
         <tbody>
             <tr class="table-active">
           <th>랭크</th><th>닉네임</th> <th>시간</th>
         </tr>
         <c:forEach items="${rank}" var="rk" varStatus="status">
         <tr >
            <td>${status.count}</td><td onclick = 'profile(event,"text3","${rk.r_id}")'  onmouseout='itemRemove2()'>${rk.r_id}</td><td>${rk.p_time}</td>
         </tr>
         </c:forEach> 
         </tbody>
      </table>
      <div id="lay" style="position:absolute;display:none;"></div>
 	      
	</body>

	<script type="text/javascript">

	var d = new Date();
   

	function abspos(e){
	    this.x = e.clientX + (document.documentElement.scrollLeft?document.documentElement.scrollLeft:document.body.scrollLeft) ;
	    this.y = e.clientY + (document.documentElement.scrollTop?document.documentElement.scrollTop:document.body.scrollTop);
	    return this;
	}

	function itemClick(e,text){
		if(text == "text"){ // today rank
		var text = '기준 날짜: ' + d.getFullYear() + "-"+(d.getMonth() + 1) +"-"+ (d.getDate()-1)+"-"+'00시~24시';
		}
		
		if(text == "text1"){ // week rank
			if(week_no(dt)==1){ // 해를 넘겨 첫째주 기준이 되면 마지막주차 날짜를 구한다. 
				var text = "기준 날짜 "+(year-1)+"-12-23일 ~"+(year-1)+"-12-31일";
			}else{
			var text = "기준 날짜 " + week_no(dt) + "주차 ~ " + (week_no(dt)+1) + "주차" ;
			}
		}

		if(text == "text2"){ // all day victory
			var text ="성공 횟수가 높은 순서";
		}
		

	    var ex_obj = document.getElementById('lay');
	     var src ='<div style="border:1px solid#b1b1b1;margin-bottom:1px;color:white;background-color:black;text-align:left;height:40px;padding-right:5px;padding-left:5px;padding-top:5px;">'+text+'<br/>'+'</div>';
	     ex_obj.innerHTML = src;
	 
	     if(!e) e = window.Event;
	     
	    pos = abspos(e);
	    ex_obj.style.left = pos.x+"px";
	    ex_obj.style.top = (pos.y+10)+"px";
	    ex_obj.style.display = ex_obj.style.display=='none'?'block':'none';
	 
	}
	 
	function itemRemove(){
	 var ex_obj = document.getElementById('lay');
	     ex_obj.style.display = 'none';
	}
	 
	function msgmove(e){
	    var obj = document.getElementById("lay");
	    var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
	    var scrollLeft = document.documentElement.scrollLeft || document.body.scrollLeft;
	 
	    obj.style.top = scrollTop + e.clientY + 10 + "px";
	    obj.style.left = scrollLeft + e.clientX + (-350) + "px";
   }


	function week_no(dt) { 
		var tdt = new Date(dt.valueOf()); 
		var dayn = (dt.getDay() + 6) % 7; 
		tdt.setDate(tdt.getDate() - dayn + 3); 
		var firstThursday = tdt.valueOf(); 
		tdt.setMonth(0, 1); 
		if (tdt.getDay() !== 4) { 
		tdt.setMonth(0, 1 + ((4 - tdt.getDay()) + 7) % 7); 
		} 
		return 1 + Math.ceil((firstThursday - tdt) / 604800000); 
		}
		

	dt = new Date(); 
	var year = dt.getFullYear();
	
	
	console.log(week_no(dt)); 
	
	
	
		
		
		
		
	</script>

	
	
</html>


