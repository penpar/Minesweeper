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
            
          #memberUpdate {
           padding: 2;
            position: absolute;
            top: 135px;
            width: 110px;
            left: 100px;
         }
            
        #LogOff {
            left: 150px;
            position: absolute;
            top:14px;
            botton: 100px;
        }
	
	
	
 	</style>
	</head>
	<body>  
	
      <table class="table table-hover">
         <tr class="table-warning" onmouseover='itemClick(event,"text1")' onmousemove='msgmove(event)' onmouseout='itemRemove()'>
           <th colspan = 3>주간 랭킹</th>
         </tr>
         <tbody>
             <tr class="table-active">
          <th>랭크</th><th>닉네임</th> <th>시간</th>
         </tr>
  		
  		
         <c:forEach items="${wrank}" var="rk" varStatus="status">
         <tr>
            <td>${status.count}</td><td onclick = 'profile(event,"text3","${rk.r_id}")'  onmouseout='itemRemove2()'>${rk.r_id}</td><td>${rk.p_time}</td>
         </tr>
         </c:forEach> 
         </tbody>
      </table>
      

 	<div  id="lay2"  style="position:absolute;display:none;float: left; ">


		</div>
		
 	
	</body>
	
	
	<script>

	
	var a1,a2,a3,a4,a5;
	 function profile(event,text,id){	
	 		$.ajax({
	 			type:"get",
	 			url:"./profile",
	 			data:{
	 				nickname : id
	 			},
	 			dataType:"JSON", 			
	 			success:function(data){
	 				console.log(data);
	 				console.log(data.status);
	 				console.log(event.target.innerHTML);
	 				
	 				a1 = data.dto.userNickName;
	 				a2 = data.dto.allCount;
	 				a3 = data.dto.winCount;
	 				a4 = ((data.dto.winCount/data.dto.allCount)*100).toFixed(2);
	 				a5 = data.dto.maxTime
	 				a6 = data.dto.avataPhoto
	 				itemClick2(event,text);
	 				
	 				if(data.status == 0){
	 					$("#loginBoxNprop").load("./loginBox.jsp",
	 					function(res,stat){						
	 					});
	 				}else{
	 					$("#loginBoxNprop").load("./profilebox.jsp",
	 							
	 					function(res,stat){							
	 						$("#nickname").html(data.dto.userNickName);
	 						console.log(data.dto.userNickName)
	 	                     if(data.dto.allCount==0){
	 	                    	 $("#allCount").html("게임횟수: --");
	 	                     }else{
	 	                    	 $("#allCount").html("게임횟수: "+data.dto.allCount);
	 	                    	 console.log(data.dto.allCount);
	 	                    	 
	 	                     }
	 	                     
	 	                     if(data.dto.winCount==0){
	 	                    	 $("#winCount").html("승리횟수: --");
	 	                     }else{
	 	                    	 $("#winCount").html("승리횟수: "+data.dto.winCount);
	 	                    	 console.log(data.dto.winCount);
	 	                    	
	 	                     }
	 	                     
	 	                     var winPercent = ((data.dto.winCount/data.dto.allCount)*100).toFixed(2);
	 	                     if(winPercent==0){
	 	                    	 $("#winPercent").html("승률: --%");
	 	                     }else{
	 	                    	 $("#winPercent").html("승률: "+winPercent+"%");
	 	                    	 console.log(winPercent);
	 	                     }
	 	                     
	 	                     if(data.dto.maxTime==0){
	 	                    	 $("#maxTime").html("최고기록: --초");
	 	                     }else{
	 	                    	 $("#maxTime").html("최고기록: "+data.dto.maxTime+"초");
	 	                    	 console.log(data.dto.maxTime);
	 	                     }

	 						if(data.dto.avataPhoto !=null){
	 							switch(data.dto.avataPhoto){
	 							case"avaOne":
	 									$("#avata").html("<img src='./avata/avataOne.png' width='100%' height='100%'>");
	 								break;
	 							case"avaTwo":
	 									$("#avata").html("<img src='./avata/avataTwo.png' width='100%' height='100%'>");
	 								break;
	 							case"avaThree":
	 									$("#avata").html("<img src='./avata/avataThree.png' width='100%' height='100%'>");
	 								break;
	 							case"avaFour":
	 									$("#avata").html("<img src='./avata/avataFour.png' width='100%' height='100%'>");
	 								break;
	 							case"avaFive":
	 									$("#avata").html("<img src='./avata/avataFive.png' width='100%' height='100%'>");
	 								break;
	 							case"avaSix":
	 	                              $("#avata").html("<img src='./avata/avataSix.png' width='100%' height='100%'>");
	 	                           break;
	 	                        case"avaSeven":
	 	                              $("#avata").html("<img src='./avata/avataSeven.png' width='100%' height='100%'>");
	 	                           break;
	 	                        case"avaEight":
	 	                              $("#avata").html("<img src='./avata/avataEight.png' width='100%' height='100%'>");
	 	                           break;
	 							}
	 						}else{
	 							$("#avata").html("<img src='./common/default.png' width='100%' height='100%'>");
	 						}
	 						
	 					
	 					});
	 					
	 				}					
	 			},
	 			error:function(error){
	 				console.log(error)
	 			}
	 		});
	 		
	 		 
	 	}
	
	 	var d = new Date();

	 	function abspos(e){
	 	    this.x = e.clientX + (document.documentElement.scrollLeft?document.documentElement.scrollLeft:document.body.scrollLeft) ;
	 	    this.y = e.clientY + (document.documentElement.scrollTop?document.documentElement.scrollTop:document.body.scrollTop);
	 	    return this;
	 	}

	 	function itemClick2(e,text){
	 		if(text == "text3"){ // all day victory
	 	
	 		console.log(a1);
	 	//	console.log(a0 + " "+a1 + " "+ a2 + " "+a3 + " "+a4 + " "+a5);
	 	
	 		//var aaa = "<img src='./avata/avataOne.png' width='100%' height='100%'>";
	 		
	 		if(a6 !=null){
					switch(a6){
					case"avaOne":
							a6="<img src='./avata/avataOne.png' width='100%' height='100%'>";
						break;
					case"avaTwo":
						a6="<img src='./avata/avataTwo.png' width='100%' height='100%'>";
						break;
					case"avaThree":
						a6="<img src='./avata/avataThree.png' width='100%' height='100%'>";
						break;
					case"avaFour":
						a6="<img src='./avata/avataFour.png' width='100%' height='100%'>";
						break;
					case"avaFive":
						a6="<img src='./avata/avataFive.png' width='100%' height='100%'>";
						break;
					case"avaSix":
						a6="<img src='./avata/avataSix.png' width='100%' height='100%'>";
                    break;
                 case"avaSeven":
                		 a6="<img src='./avata/avataSeven.png' width='100%' height='100%'>";
                    break;
                 case"avaEight":
                       a6="<img src='./avata/avataEight.png' width='100%' height='100%'>";
                    break;
                    
					}
				}else{
					a6="<img src='./common/default.png' width='100%' height='100%'>";
				}
	 		
	 		

	
	 		
	 		
	 		text = a1+'<br/>'+a2+'<br/>'+a3+'<br/>'+a4+'<br/>'+a5 +'<br/>' + a6;
	 		console.log(text);	
	 		}
	 	
	 	    var ex_obj = document.getElementById('lay2');
	 	     
	 	    //var src ='<div style="border:1px solid#b1b1b1;margin-bottom:1px;color:white;background-color:black;text-align:left;height:500px;padding-right:5px;padding-left:5px;padding-top:5px;">'+text+'<br/>'+'</div>';
	 	 
	 	   // var src ='<div style="border:1px solid#b1b1b1;margin-bottom:1px;color:white;background-color:black;text-align:left;height:200px;width:300px;padding-right:5px;padding-left:5px;padding-top:5px;">'+text+'<br/>'+'</div>';

	 	    
	 	 var src=  
	 		'<div style="margin-bottom:1px;color:white;text-align:left;height:175px;width:300px;padding-right:5px;padding-left:5px;padding-top:5px;">'+
	 		 
	 		 
	 		 
	 		 '<div class ="card border-primary mb-3"  style="max-width: 20rem;">'+
	         '<div class ="card-header">'+
	         '<div class="text-primary" id = "nickname">'+a1+'</div>'+
	         '</div>'+
	         '<div id = "avata">'+a6+'</div> '+
	 
	         '<h3 id = "allCount"> 게임횟수: '+a2+'</h3>'+
	         '<h3 id = "winCount"> 승리횟수: '+a3+'</h3>'+
	         '<h3 id="winPercent">승률: '+a4+'%</h3>'+
	         '<h3 id="maxTime">최고기록:'+a5+'초</h3>'+
	         
			 '</div>'
	 	   
+'</div>'
	 	    
	 	    
	 	    
	 	    
	 	    
	 	    
	 	    
	 	    
	 	     ex_obj.innerHTML = src;
	 	 
	 	     if(!e) e = window.Event;
	 	     
	 	    pos = abspos(e);
	 	    ex_obj.style.left = pos.x+(-350)+"px";
	 	    ex_obj.style.top = (pos.y+10)+"px";
	 	    ex_obj.style.display = ex_obj.style.display=='none'?'block':'none';
	 	}
	 	 
	 	function itemRemove2(){
	 	 var ex_obj = document.getElementById('lay2');
	 	     ex_obj.style.display = 'none';
	 	}
	 	 
	 	function msgmove2(e){
	 	    var obj = document.getElementById("lay2");
	 	    var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
	 	    var scrollLeft = document.documentElement.scrollLeft || document.body.scrollLeft;
	 	 
	 	    obj.style.top = scrollTop + e.clientY + 10 + "px";
	 	    obj.style.left = scrollLeft + e.clientX  +(-350)+ "px";
	    }


	</script>
</html>


