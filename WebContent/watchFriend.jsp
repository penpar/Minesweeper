<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<script src = "https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<link rel= "stylesheet" type="text/css" href="./css/literacss.css">
      <link rel = "stylesheet" href="./css/custom.css">
      <style>        
         .card border-primary mb-3 {
            margin-top: 33px;
               margin-bottom: 33px; 
         } 
         
         .card-header {
            color: 3399ff ;
         }
           
         #avata {

            width:98.18px;
            height: 113.64px; 
           padding: 5;
            position: relative;
         }
            
        #allCount {
             font-size: 16px;
            color: #666666;
            position: absolute;
            width: 110px;
            top: 50px;
            left: 100px;
            font-family: 'Noto Sans KR';
        }
               
          #winCount {
             font-size: 16px;
           color: #666666;
            position: absolute;
            width: 100px;
            top: 70px;
            left: 100px;
            font-family: 'Noto Sans KR';
        }
            
       #winPercent {
           font-size: 16px;
              color: #666666;
            position: absolute;
             width: 130px;
            top: 90px;
              left: 100px;
              font-family: 'Noto Sans KR';       
         }
            
        #maxTime {
             font-size: 16px;
            color: #666666;
            position: absolute;
            width: 130px;
            top: 110px;
            left: 100px;
           font-family: 'Noto Sans KR';       
        }
        h1{
        	margin-top: 15px;
        	margin-left: 10px;
        }
      </style>
   </head>
   <body>  
      <div class ="card border-primary mb-3" style="max-width: 20rem;">
         <div class ="card-header">
            <div class="text-primary" id = "nickname">닉네임</div>
        </div> 
        <div id = "avata">아바타</div>   
        <div id = "LogOff">
        </div>
            <h1 id = "allCount">게임횟수</h1>
            <h1 id = "winCount">승리횟수</h1>
            <h1 id="winPercent">승률</h1>
            <h1 id="maxTime">최고기록</h1>
      </div>
   </body>
	<script>
		$(document).ready(function(){
			var nick = "${param.nickName}";
			console.log("닉네임 : "+nick);	
			
			$.ajax({
				type:"post",
				url:"./friendProfile",
				data:{
					nickName : nick
				},
				dataType:"JSON",
				success:function(data){
					console.log(data);
					$("#nickname").html(data.dto.userNickName);
					
                    if(data.dto.allCount==0){
                   	 $("#allCount").html("게임횟수: --");
                    }else{
                   	 $("#allCount").html("게임횟수: "+data.dto.allCount);
                    }
                    
                    if(data.dto.winCount==0){
                   	 $("#winCount").html("승리횟수: --");
                    }else{
                   	 $("#winCount").html("승리횟수: "+data.dto.winCount);
                    }
                    
                    var winPercent = ((data.dto.winCount/data.dto.allCount)*100).toFixed(2);
                    if(winPercent=="NaN"){
                   	 $("#winPercent").html("승률: --%");
                    }else{
                   	 $("#winPercent").html("승률: "+winPercent+"%");
                    }
                    
                    if(data.dto.maxTime==0){
                   	 $("#maxTime").html("최고기록: --초");
                    }else{
                   	 $("#maxTime").html("최고기록: "+data.dto.maxTime+"초");
                    }
                    
					if(data.dto.avataPhoto !=null){
						switch(data.dto.avataPhoto){
						case"avaOne":
								$("#avata").html("<img src='./avata/avataOne.png' width='100%' height='100%'>");
							break
						case"avaTwo":
								$("#avata").html("<img src='./avata/avataTwo.png' width='100%' height='100%'>");
							break
						case"avaThree":
								$("#avata").html("<img src='./avata/avataThree.png' width='100%' height='100%'>");
							break
						case"avaFour":
								$("#avata").html("<img src='./avata/avataFour.png' width='100%' height='100%'>");
							break
						case"avaFive":
								$("#avata").html("<img src='./avata/avataFive.png' width='100%' height='100%'>");
							break
						case"avaSix":
                             $("#avata").html("<img src='./avata/avataSix.png' width='100%' height='100%'>");
                          break
                       case"avaSeven":
                             $("#avata").html("<img src='./avata/avataSeven.png' width='100%' height='100%'>");
                          break
                       case"avaEight":
                             $("#avata").html("<img src='./avata/avataEight.png' width='100%' height='100%'>");
                          break
						}
					}else{
						$("#avata").html("<img src='./common/default.png' width='100%' height='100%'>");
					}
				},
				error:function(e){
					console.log(e);
				}
			});
			
		});
		
	</script>
</html>