<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>모두의 지뢰</title>
		<link rel= "stylesheet" type="text/css" href="./css/popup.css">
		<script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
		<link rel= "stylesheet" type="text/css" href="./css/literacss.css">
		<style type="text/css">
 			#minelist{
				border: 1px solid white;
				border-collapse: collapse;
			}
			td{
				width: 40px;
				height: 43px;
				text-align: center;
				/* background-image: url('./real/basic.png'); */
				/* background-size: 39px 39px; */
				-ms-user-select: none; 
				-moz-user-select: -moz-none;
				-webkit-user-select: none; 
				-khtml-user-select: none; 
				user-select:none;
			}
			td:hover {
				background-color: white;
				opacity: 0.5;				
			}
			.mineF{
				position: absolute;
				left: 350px;
			}
			#div1{
			width : 100%;
			height : 100%;
			background-color: rgba(0,0,0,0.075);
			}

		</style>
	</head>
	<body ondragstart='return false'>
		<jsp:include page="./leftBar.jsp"/>
		<div class="mineF">
			<br>
			<h3 class="text-primary">지뢰찾기</h3>
			<div id="div1">
			  <div class="form-group">
   			 	<label class="custom-control custom-radio">
			      <input type="radio" class="custom-control-input"name="mine" value="easy"  checked>
			      <span class="custom-control-indicator"></span>
			      <span class="custom-control-description">초급</span>
		    	</label>
		    	<label class="custom-control custom-radio">
			      <input type="radio" class="custom-control-input"name="mine" value="normal">
			      <span class="custom-control-indicator"></span>
			      <span class="custom-control-description">중급</span>
		    	</label>
		    	<label class="custom-control custom-radio">
			      <input type="radio" class="custom-control-input"name="mine" value="hard">
			      <span class="custom-control-indicator"></span>
			      <span class="custom-control-description">고급</span>
		    	</label>
			<input type="button" id="str" class="btn btn-primary btn-lg" value="게임하기" onclick="mineValueShow()"><br/>
			 </div>
			<div class="card text-white bg-primary mb-3" style="max-width: 20rem;"><div>시간 : <span id="time"> 0 </span></div></div>
			<div class="card text-white bg-primary mb-3" style="max-width: 20rem;"><div>지뢰 개수 : <span id="mineS"> 0 </span></div></div><br/>
				<table id="minelist">
				</table>
		</div>
	<br/><br/>
		<div class="dim-layer">
		    <div class="dimBg"></div>
		    <div id="layer2" class="pop-layer">
		        <div class="pop-container">
		                <!--content //-->
		                <p class="ctxt mb20"><span id="msg"></span><br/><br/>
		                    시간 :&nbsp; <span id ="setTime"></span>초 <br/>
		                    게임 횟수 :&nbsp; <span id ="setNum"></span> <br/><br/>
		                    이긴 게임 횟수 :&nbsp; <span id ="setWin"></span> &emsp;&emsp;&emsp; 승률 :&nbsp;<span id ="setPercent"></span>%
		                </p>
		                <div class="btn-r">
		                    <a href="#" class="btn-layerClose" id="re">다시하기</a>
		                </div>
		                <!--// content-->
		        </div>
		    </div>
		</div>
		</div>
	</body>
	<script>
	var myArray; // 값 담을 배열
	var winCount = 0; //찾은 지뢰수 카운트
	var mineCount = 0; // 총 지뢰수 카운트
	var timeUp;//시간 제어
	
	function layer_popup(el){//el = #layer2;

        var $el = $(el);        //레이어의 id를 $el 변수에 저장
        var isDim = $el.prev().hasClass('dimBg');   //dimmed 레이어를 감지하기 위한 boolean 변수

        isDim ? $('.dim-layer').fadeIn() : $el.fadeIn();

        var $elWidth = ~~($el.outerWidth()),
            $elHeight = ~~($el.outerHeight()),
            docWidth = $(document).width(),
            docHeight = $(document).height();

        // 화면의 중앙에 레이어를 띄운다.
        if ($elHeight < docHeight || $elWidth < docWidth) {
            $el.css({
                marginTop: -$elHeight /2,
                marginLeft: -$elWidth/2
            })
        } else {
            $el.css({top: 0, left: 0});
        }

        $el.find('a.btn-layerClose').click(function(){
            isDim ? $('.dim-layer').fadeOut() : $el.fadeOut();
            
            //return false;
        });
        
        /* $('.layer .dimBg').click(function(){
            $('.dim-layer').fadeOut();
            return false;
        }); */
    }
	
	$("#re").click(function(){
		mineValueShow();
    });

    function resultShow(result){//결과창 보여주고 저장하기
    	clearInterval(timeUp);
		var mineValue = $("input[name='mine']:checked").val();
    	
    	if(result==false){//폭탄 위치 전부 보여주기(졌을경우);
			var i=0,j=0, row = myArray.length,col = myArray[0].length;
			
			while(i<row){
					j=0;
				while(j<col){
			        	var clsElement = 'floor_'+i+' room_'+j;
			        	var cls = document.getElementsByClassName(clsElement);
			        	if(cls[0].innerHTML == "" && myArray[i][j]==9){
			        		cls[0].innerHTML ="<img src='./real/bomb.png' width='39px' height='39px'/>";
			        	}
	        		j++;
	        	}
				i++;
	        }
    	}
    
		$.ajax({//결과 데이터베이스 저장 후 뽑아오기용 아작스
			type:"post",
			url:"./resultShow",
			data:{
				level:$("input[name='mine']:checked").val(),
				time:$("#time").html(),
				"success":result,
				},
			dataType:"JSON",
			success:function(data){
				var percent = (data.list[1] / data.list[0] * 100).toFixed(2);
        		var timeUp = $("#time").html();
        		$("#setTime").html(timeUp);
        		$("#setNum").html(data.list[0]);
        		$("#setWin").html(data.list[1]);
        		$("#setPercent").html(percent);//승률 = 승리 ÷ (승리+패배) x 100
        		if(data.list[2]==1){
        			$("#msg").html("게임에서 승리하셨습니다. 축하드립니다.");
        		}else{
        			$("#msg").html("게임에서 졌습니다.<br/>다음 번에는 꼭 승리하시길 바랍니다.");
        		}
				layer_popup("#layer2");
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	////////////////////////////////////////////////////////////////////////////////////////////////////////
	function winCondition(){//승리 조건
		if(winCount == mineCount){
			
			var winner = 0;
			
			var i=0,j=0, row = myArray.length,col = myArray[0].length;
			
			while(i<row){
					j=0;
				while(j<col){
			        	var clsElement = 'floor_'+i+' room_'+j;
			        	var cls = document.getElementsByClassName(clsElement);
			        	if(cls[0].innerHTML == ""){
			        		winner++;
			        	}
	        		j++;
	        	}
				i++;
	        }
		
			if(winner==0){
				var success=true;
				resultShow(success);
			}
   		}
	}
	
	function roundOpen(cls,inner){//빈칸 클릭시 연동시켜 다 열기
		if(cls[0].innerHTML == ""){
    		 /* if(inner == 0){
    			cls[0].innerHTML = "<img src='./real/zero.png' width='39px' height='39px'/>";
    		} */if(inner == 1){
    			cls[0].innerHTML = "<img src='./real/one.png' width='39px' height='39px'/>";
    		}else if(inner == 2){
    			cls[0].innerHTML = "<img src='./real/two.png' width='39px' height='39px'/>";
    		}else if(inner == 3){
    			cls[0].innerHTML = "<img src='./real/three.png' width='39px' height='39px'/>";
    		}else if(inner == 4){
    			cls[0].innerHTML = "<img src='./real/four.png' width='39px' height='39px'/>";
    		}else if(inner == 5){
    			cls[0].innerHTML = "<img src='./real/five.png' width='39px' height='39px'/>";
    		}else if(inner == 6){
    			cls[0].innerHTML = "<img src='./real/six.png' width='39px' height='39px'/>";
    		}else if(inner == 7){
    			cls[0].innerHTML = "<img src='./real/seven.png' width='39px' height='39px'/>";
    		}else if(inner == 8){
    			cls[0].innerHTML = "<img src='./real/eight.png' width='39px' height='39px'/>";
    		}
    	}
	}

	function pressOpen(cls,myArray,floor,room){ // 주변 열리기
   		  if(myArray[floor][room] == 0){
   			 $.ajaxSettings.traditional = true;
    		 $.ajax({
    				type:"post",
    				url:"./zeroOpener",
    				data:{
    					floor:floor,
    					room:room,
    					level:$("input[name='mine']:checked").val(),
    					list:myArray
    					},
    				dataType:"JSON",
    				success:function(data){
    					
    					//console.log(data.list);
    					
    					var zeroLength = data.list.length, zer = 0;
    					var addr = [];
    					
    					while(zer<zeroLength){//0부분 탐색해온거 열어주는부분
    						
    						 var floroom = data.list[zer].split("/"); //쪼갠거 담아놓기.
    						//0부분 그냥 열기
    						var clsElement = 'floor_'+floroom[0]+' room_'+floroom[1];
 							var cls = document.getElementsByClassName(clsElement);
 							cls[0].innerHTML = "<img src='./real/zero.png' width='39px' height='39px'/>";

 							//주변부 열어주기
   					        var qx = parseInt(floroom[0]) -1 ;
   					        var qy = parseInt(floroom[1]) -1 ;

   					        var wx = parseInt(floroom[0]) -1 ;
   					        var wy = parseInt(floroom[1]);

   					        var ex = parseInt(floroom[0]) -1 ;
   					        var ey = parseInt(floroom[1]) +1 ;

   					        var ax = parseInt(floroom[0]);
   					        var ay = parseInt(floroom[1]) -1 ;

   					        var dx = parseInt(floroom[0]);
   					        var dy = parseInt(floroom[1]) +1 ;

   					        var zx = parseInt(floroom[0]) +1 ;
   					        var zy = parseInt(floroom[1]) -1 ;

   					        var xx = parseInt(floroom[0]) +1 ;
   					        var xy = parseInt(floroom[1]);

   					        var cx = parseInt(floroom[0]) +1 ;
   					        var cy = parseInt(floroom[1]) +1 ;
   					    	 
    						 if($('td').hasClass('floor_'+qx+' room_'+qy)){
    							var inner = myArray[qx][qy]
    							var clsElement = 'floor_'+qx+' room_'+qy;
    							var cls = document.getElementsByClassName(clsElement);
    							roundOpen(cls,inner);	
    						}
   					    	if($('td').hasClass('floor_'+wx+' room_'+wy)){
    							var inner = myArray[wx][wy]
    							var clsElement = 'floor_'+wx+' room_'+wy;
    							var cls = document.getElementsByClassName(clsElement);
    							roundOpen(cls,inner);	
    						}
   					    	if($('td').hasClass('floor_'+ex+' room_'+ey)){
    							var inner = myArray[ex][ey]
    							var clsElement = 'floor_'+ex+' room_'+ey;
    							var cls = document.getElementsByClassName(clsElement);
    							roundOpen(cls,inner);	
    						}
   					    	if($('td').hasClass('floor_'+ax+' room_'+ay)){
    							var inner = myArray[ax][ay]
    							var clsElement = 'floor_'+ax+' room_'+ay;
    							var cls = document.getElementsByClassName(clsElement);
    							roundOpen(cls,inner);	
    						} 
   					    	if($('td').hasClass('floor_'+dx+' room_'+dy)){
    							var inner = myArray[dx][dy]
    							var clsElement = 'floor_'+dx+' room_'+dy;
    							var cls = document.getElementsByClassName(clsElement);
    							roundOpen(cls,inner);	
    						} 
   					    	if($('td').hasClass('floor_'+zx+' room_'+zy)){
    							var inner = myArray[zx][zy]
    							var clsElement = 'floor_'+zx+' room_'+zy;
    							var cls = document.getElementsByClassName(clsElement);
    							roundOpen(cls,inner);	
    						} 
   					    	if($('td').hasClass('floor_'+xx+' room_'+xy)){
    							var inner = myArray[xx][xy]
    							var clsElement = 'floor_'+xx+' room_'+xy;
    							var cls = document.getElementsByClassName(clsElement);
    							roundOpen(cls,inner);	
    						} 
   					    	if($('td').hasClass('floor_'+cx+' room_'+cy)){
    							var inner = myArray[cx][cy]
    							var clsElement = 'floor_'+cx+' room_'+cy;
    							var cls = document.getElementsByClassName(clsElement);
    							roundOpen(cls,inner);	
    						} 
    						zer++;
    					}
    				},
    				error:function(e){
    					console.log(e);
    				}
    			});
   			cls[0].innerHTML = "<img src='./real/zero.png' width='39px' height='39px'/>";
   		}else if(myArray[floor][room] == 1){
   			cls[0].innerHTML = "<img src='./real/one.png' width='39px' height='39px'/>";
   		}else if(myArray[floor][room] == 2){
   			cls[0].innerHTML = "<img src='./real/two.png' width='39px' height='39px'/>";
   		}else if(myArray[floor][room] == 3){
   			cls[0].innerHTML = "<img src='./real/three.png' width='39px' height='39px'/>";
   		}else if(myArray[floor][room] == 4){
   			cls[0].innerHTML = "<img src='./real/four.png' width='39px' height='39px'/>";
   		}else if(myArray[floor][room] == 5){
   			cls[0].innerHTML = "<img src='./real/five.png' width='39px' height='39px'/>";
   		}else if(myArray[floor][room] == 6){
   			cls[0].innerHTML = "<img src='./real/six.png' width='39px' height='39px'/>";
   		}else if(myArray[floor][room] == 7){
   			cls[0].innerHTML = "<img src='./real/seven.png' width='39px' height='39px'/>";
   		}else if(myArray[floor][room] == 8){
   			cls[0].innerHTML = "<img src='./real/eight.png' width='39px' height='39px'/>";
   		}else{
   			cls[0].innerHTML = "<img src='./real/bomb.png' width='39px' height='39px'/>";
   			var success = false
   			resultShow(success);
   		}
	}
	
	$("#minelist").click(function(){
		if($("#time").html() == 0){
			 $("#time").html(1);
			 var t=1;
			 timeUp = setInterval(function(){
	   	 		t++;
	          $("#time").html(t);
	          if(t>=999){clearInterval(timeUp);}
	  	 },1000);	
	 	}
		
	})
	
	function select(e){//mouseup 이벤트
		
		var btn = event.button;
		//console.log("buttons : "+ event.buttons);
		//console.log("하하");
		//console.log(e.innerHTML);
		//console.log(event);
		//console.log(e.getAttribute("class"));
		//console.log(myArray);
		
		var classes = e.getAttribute("class").split(" ");
		
       // console.log(classes);
 		
        var addr = [];
        
        classes.forEach(function(item,idx){//classes 에 담긴 값(2개의 클래스)을 하나씩 거낸다.
            //forEach문 이나 for문 사용해서 각각 불러오기
            //하나씩 꺼내온 클래스를 이제는 "_" 기준으로 쪼갠다.
            //console.log(idx+"//"+item)
            var cls = item.split("_"); //쪼갠거 담아놓기.
            //console.log("cls : "+cls[1]);
            addr[idx]=cls[1];//쪼갠거 숫자 부분만 따로 담아둠
           // console.log("addr : "+addr);
        });
        
        console.log(addr);
    	var info = myArray[addr[0]][addr[1]];//클릭한 부분의 해당 배열의 값을 추출
       // console.log(info);
       // console.log("ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
       // console.log($("#time").html());
       
        if(btn==0 && e.innerHTML == ""){
        	 if(info==0){
        		 console.log(myArray)
        		 $.ajaxSettings.traditional = true;
        		 $.ajax({
        				type:"post",
        				url:"./zeroOpener",
        				data:{
        					floor:addr[0],
        					room:addr[1],
        					level:$("input[name='mine']:checked").val(),
        					list:myArray
        					},
        				dataType:"JSON",
        				success:function(data){
        					
        					//console.log(data.list);
        					
        					var zeroLength = data.list.length, zer = 0;
        					var addr = [];
        					
        					while(zer<zeroLength){//0부분 탐색해온거 열어주는부분
        						
        						 var floroom = data.list[zer].split("/"); //쪼갠거 담아놓기.
        						//0부분 그냥 열기
        						var clsElement = 'floor_'+floroom[0]+' room_'+floroom[1];
     							var cls = document.getElementsByClassName(clsElement);
     							cls[0].innerHTML = "<img src='./real/zero.png' width='39px' height='39px'/>";

     							//주변부 열어주기
       					        var qx = parseInt(floroom[0]) -1 ;
       					        var qy = parseInt(floroom[1]) -1 ;

       					        var wx = parseInt(floroom[0]) -1 ;
       					        var wy = parseInt(floroom[1]);

       					        var ex = parseInt(floroom[0]) -1 ;
       					        var ey = parseInt(floroom[1]) +1 ;

       					        var ax = parseInt(floroom[0]);
       					        var ay = parseInt(floroom[1]) -1 ;

       					        var dx = parseInt(floroom[0]);
       					        var dy = parseInt(floroom[1]) +1 ;

       					        var zx = parseInt(floroom[0]) +1 ;
       					        var zy = parseInt(floroom[1]) -1 ;

       					        var xx = parseInt(floroom[0]) +1 ;
       					        var xy = parseInt(floroom[1]);

       					        var cx = parseInt(floroom[0]) +1 ;
       					        var cy = parseInt(floroom[1]) +1 ;
       					    	 
        						 if($('td').hasClass('floor_'+qx+' room_'+qy)){
        							var inner = myArray[qx][qy]
        							var clsElement = 'floor_'+qx+' room_'+qy;
        							var cls = document.getElementsByClassName(clsElement);
        							roundOpen(cls,inner);	
        						}
       					    	if($('td').hasClass('floor_'+wx+' room_'+wy)){
        							var inner = myArray[wx][wy]
        							var clsElement = 'floor_'+wx+' room_'+wy;
        							var cls = document.getElementsByClassName(clsElement);
        							roundOpen(cls,inner);	
        						}
       					    	if($('td').hasClass('floor_'+ex+' room_'+ey)){
        							var inner = myArray[ex][ey]
        							var clsElement = 'floor_'+ex+' room_'+ey;
        							var cls = document.getElementsByClassName(clsElement);
        							roundOpen(cls,inner);	
        						}
       					    	if($('td').hasClass('floor_'+ax+' room_'+ay)){
        							var inner = myArray[ax][ay]
        							var clsElement = 'floor_'+ax+' room_'+ay;
        							var cls = document.getElementsByClassName(clsElement);
        							roundOpen(cls,inner);	
        						} 
       					    	if($('td').hasClass('floor_'+dx+' room_'+dy)){
        							var inner = myArray[dx][dy]
        							var clsElement = 'floor_'+dx+' room_'+dy;
        							var cls = document.getElementsByClassName(clsElement);
        							roundOpen(cls,inner);	
        						} 
       					    	if($('td').hasClass('floor_'+zx+' room_'+zy)){
        							var inner = myArray[zx][zy]
        							var clsElement = 'floor_'+zx+' room_'+zy;
        							var cls = document.getElementsByClassName(clsElement);
        							roundOpen(cls,inner);	
        						} 
       					    	if($('td').hasClass('floor_'+xx+' room_'+xy)){
        							var inner = myArray[xx][xy]
        							var clsElement = 'floor_'+xx+' room_'+xy;
        							var cls = document.getElementsByClassName(clsElement);
        							roundOpen(cls,inner);	
        						} 
       					    	if($('td').hasClass('floor_'+cx+' room_'+cy)){
        							var inner = myArray[cx][cy]
        							var clsElement = 'floor_'+cx+' room_'+cy;
        							var cls = document.getElementsByClassName(clsElement);
        							roundOpen(cls,inner);	
        						} 
        						zer++;
        					}
        				},
        				error:function(e){
        					console.log(e);
        				}
        			});
        		 
             }else if(info==1){
            	 e.innerHTML = "<img src='./real/one.png' width='39px' height='39px'/>";
            	 
             }else if(info==2){
            	 e.innerHTML = "<img src='./real/two.png' width='39px' height='39px'/>";
             }else if(info==3){
            	 e.innerHTML = "<img src='./real/three.png' width='39px' height='39px'/>";
             }else if(info==4){
            	 e.innerHTML = "<img src='./real/four.png' width='39px' height='39px'/>";
             }else if(info==5){
            	 e.innerHTML = "<img src='./real/five.png' width='39px' height='39px'/>";
             }else if(info==6){
            	 e.innerHTML = "<img src='./real/six.png' width='39px' height='39px'/>";
             }else if(info==7){
            	 e.innerHTML = "<img src='./real/seven.png' width='39px' height='39px'/>";
             }else if(info==8){
            	 e.innerHTML = "<img src='./real/eight.png' width='39px' height='39px'/>";
             }else{
            	 e.innerHTML = "<img src='./real/bomb.png' width='39px' height='39px'/>";
            	 var success = false
            	 resultShow(success);
             }
        }else if(btn==2 && e.innerHTML == ""){
        	event.target.innerHTML ="<img src='./real/flag.png' width='39px' height='39px'/>";
			var mineS = $("#mineS").html();
       		mineS = mineS - 1 ;
       		$("#mineS").html(mineS);
       		
			//console.log(e.innerHTML);
			//console.log(event);
			//console.log(event.target.children[0].attributes[0].value);
	        //console.log(myArray[addr[0]][addr[1]]);
	        //console.log("이 게임의 지뢰 수 : " + mineCount);
	        
	       	if(event.target.children[0].attributes[0].value == "./real/flag.png" && myArray[addr[0]][addr[1]] == 9){
	       		winCount += 1;//승리를 위한 개수 카운트
	       		if(winCount == mineCount){
	       			winCondition();
	       		}
	       		//console.log("찾은 지뢰수 : "+ winCount);
	       	}
        }else if(btn==2 && event.target.attributes[0].value == "./real/flag.png"){
        	event.target.outerHTML = "<img src='./real/questionmark.png' width='39px' height='39px'/>";
        	var mineSP = $("#mineS").html();
        	mineSP = parseInt(mineSP) + 1 ;
       		$("#mineS").html(mineSP);
       		
       		//console.log("ㅎㅎ");
       		//console.log(event);
       		//console.log(event.target.attributes[0].value);
       		
			if(event.target.attributes[0].value == "./real/flag.png" && myArray[addr[0]][addr[1]] == 9){
	       		winCount = winCount - 1;
	       		//console.log("찾은 지뢰수 : " + winCount);
	       	}
        }else if(btn==2 && event.target.attributes[0].value == "./real/questionmark.png"){
        	event.target.outerHTML ="";
        }else if(btn==0 && event.target.attributes[0].nodeValue == "./real/questionmark.png"){
      		 if(info==0){
      		 event.target.outerHTML = "<img src='./real/zero.png' width='39px' height='39px'/>";
           }else if(info==1){
          	 event.target.outerHTML = "<img src='./real/one.png' width='39px' height='39px'/>";
           }else if(info==2){
          	 event.target.outerHTML = "<img src='./real/two.png' width='39px' height='39px'/>";
           }else if(info==3){
          	 event.target.outerHTML = "<img src='./real/three.png' width='39px' height='39px'/>";
           }else if(info==4){
          	 event.target.outerHTML = "<img src='./real/four.png' width='39px' height='39px'/>";
           }else if(info==5){
          	 event.target.outerHTML = "<img src='./real/five.png' width='39px' height='39px'/>";
           }else if(info==6){
          	 event.target.outerHTML = "<img src='./real/six.png' width='39px' height='39px'/>";
           }else if(info==7){
          	 event.target.outerHTML = "<img src='./real/seven.png' width='39px' height='39px'/>";
           }else if(info==8){
          	 event.target.outerHTML = "<img src='./real/eight.png' width='39px' height='39px'/>";
           }else{
          	 event.target.outerHTML = "<img src='./real/bomb.png' width='39px' height='39px'/>";
          	var success = false
       	 	resultShow(success);
           }
		}else if(btn==1 || event.buttons == 1 || event.buttons == 0 || event.buttons == 2){
			var i=0,j=0, row = myArray.length,col = myArray[0].length;
			
			while(i<row){
					j=0;
				while(j<col){
	        		if($('td').hasClass('floor_'+i+' room_'+j)){//클래스가 있나 없나 확인
			        	var clsElement = 'floor_'+i+' room_'+j;
			        	var cls = document.getElementsByClassName(clsElement);
			        	if(cls[0].innerHTML != ""){
			        		if(cls[0].children[0].attributes[0].value == "./real/press.png"){ //press 눌려있는거 제거 
			        			cls[0].innerHTML ="";
			        		}
			        	}
			        	
			        }
	        		j++;
	        	}
				i++;
	        }
		}
        winCondition();
	}
	
	//밸류값 보내기
	function mineValueShow(){
			clearInterval(timeUp);
			$("#time").html(0);
			winCount = 0;
			var mineValue = $("input[name='mine']:checked").val();
			$("#minelist").html("");
			//console.log(mineValue);
			$.ajax({
				type:"post",
				url:"./mine",
				data:{mine:$("input[name='mine']:checked").val()},
				dataType:"JSON",
				success:function(data){
					console.log(data.array);
					mineShow(data.array,mineValue);
				},
				error:function(e){
					console.log(e);
				}
			});
	}
	
	
	//지뢰 난이도에 따라서 뿌리기
	function mineShow(list,mine){
		if(mine=="easy"){
			$("#mineS").html("10");
			mineCount = 10;
			mineShowWin(list,9,9);
		}else if(mine =="normal"){
			$("#mineS").html("40");
			mineShowWin(list,16,16);
			mineCount = 40;
		}else{
			$("#mineS").html("99");
			mineShowWin(list,16,30);
			mineCount = 99;
		}
	}
	
	//지뢰 뿌리기 모듈화
	function mineShowWin(list,x,y){
		var txt;
		myArray = [];
		var i=0,j=0;
		while(i<x){
			myArray[i] = [];
			txt +="<tr>";
			while(j<y){
				txt += "<td class='floor_"+i+" room_"+j+"' onmouseup='select(this)' background = './real/basic.png'/ style='background-size:39px 39px'></td>"
				myArray[i][j] = list[i][j];	
				j++;
			}
			txt +="</tr>";
			j=0;
		 	i++;
		}
		$("#minelist").append(txt);
		
		$("td").mousedown(function(e){//주변 영역 확인
			console.log(e);
			
			if(e.button == 1 || e.buttons==3 ||e.buttons==4){
				console.log(this.getAttribute("value"));
				var classes = this.getAttribute("class").split(" ");
		        //console.log(classes);
		        var addr = [];
		        
		        classes.forEach(function(item,idx){//classes 에 담긴 값(2개의 클래스)을 하나씩 거낸다.
		            //forEach문 이나 for문 사용해서 각각 불러오기
		            //하나씩 꺼내온 클래스를 이제는 "_" 기준으로 쪼갠다.
		           // console.log(idx+"//"+item)
		            var cls = item.split("_"); //쪼갠거 담아놓기.
		           // console.log("cls : "+cls[1]);
		            addr[idx]=cls[1];//쪼갠거 숫자 부분만 따로 담아둠
		            //console.log("addr : "+addr);
		        });
		       // console.log(addr[0]);
		       // console.log(addr[1]);
		        var info = myArray[addr[0]][addr[1]];
		        
		        var sx = parseInt(addr[0]);
		        var sy = parseInt(addr[1]);
		        
		        var qx = parseInt(addr[0]) -1 ;
		        var qy = parseInt(addr[1]) -1 ;

		        var wx = parseInt(addr[0]) -1 ;
		        var wy = parseInt(addr[1]);

		        var ex = parseInt(addr[0]) -1 ;
		        var ey = parseInt(addr[1]) +1 ;

		        var ax = parseInt(addr[0]);
		        var ay = parseInt(addr[1]) -1 ;

		        var dx = parseInt(addr[0]);
		        var dy = parseInt(addr[1]) +1 ;

		        var zx = parseInt(addr[0]) +1 ;
		        var zy = parseInt(addr[1]) -1 ;

		        var xx = parseInt(addr[0]) +1 ;
		        var xy = parseInt(addr[1]);

		        var cx = parseInt(addr[0]) +1 ;
		        var cy = parseInt(addr[1]) +1 ;
		        
			 if($('td').hasClass('floor_'+sx+' room_'+sy) || $('td').hasClass('floor_'+qx+' room_'+qy)||
						$('td').hasClass('floor_'+wx+' room_'+wy)||$('td').hasClass('floor_'+ex+' room_'+ey)||
						$('td').hasClass('floor_'+ax+' room_'+ay)||$('td').hasClass('floor_'+dx+' room_'+dy)||
						$('td').hasClass('floor_'+zx+' room_'+zy)||$('td').hasClass('floor_'+xx+' room_'+xy)||
						$('td').hasClass('floor_'+cx+' room_'+cy)){//깃발이랑 지뢰 위치 같은때 주변 빈칸 숫자들 보여주기
				 
					var mineLevel = $("input[name='mine']:checked").val();
					var roundMineCount = 0;//주변부 지뢰 수
					var roundFlagMine = 0;//깃발 지뢰 같은곳 수
					
					switch(mineLevel){//난이도 별로 배열 넘어가지 않게 arrayExeption 방지용
					case"easy":
						if(qx>=0 && qy>=0){
							if(myArray[qx][qy] == 9 ){roundMineCount++;}
						}
						if(wx>=0){
							if(myArray[wx][wy] == 9 ){roundMineCount++;}
						}
						if(ex>=0 && ey<9){
							if(myArray[ex][ey] == 9 ){roundMineCount++;}
						}
						if(ay>=0){
							if(myArray[ax][ay] == 9 ){roundMineCount++;}
						}
						if(dy<9){
							if(myArray[dx][dy] == 9 ){roundMineCount++;}
						}
						if(zx<9 && zy>=0){
							if(myArray[zx][zy] == 9 ){roundMineCount++;}
						}
						if(xx<9){
							if(myArray[xx][xy] == 9 ){roundMineCount++;}
						}
						if(cx<9 && cy<9){
							if(myArray[cx][cy] == 9 ){roundMineCount++;}
						}
						break
					case"normal":
						if(qx>=0 && qy>=0){
							if(myArray[qx][qy] == 9 ){roundMineCount++;}
						}
						if(wx>=0){
							if(myArray[wx][wy] == 9 ){roundMineCount++;}
						}
						if(ex>=0 && ey<16){
							if(myArray[ex][ey] == 9 ){roundMineCount++;}
						}
						if(ay>=0){
							if(myArray[ax][ay] == 9 ){roundMineCount++;}
						}
						if(dy<16){
							if(myArray[dx][dy] == 9 ){roundMineCount++;}
						}
						if(zx<16 && zy>=0){
							if(myArray[zx][zy] == 9 ){roundMineCount++;}
						}
						if(xx<16){
							if(myArray[xx][xy] == 9 ){roundMineCount++;}
						}
						if(cx<16 && cy<16){
							if(myArray[cx][cy] == 9 ){roundMineCount++;}
						}
						break
					case"hard":
						if(qx>=0 && qy>=0){
							if(myArray[qx][qy] == 9 ){roundMineCount++;}
						}
						if(wx>=0){
							if(myArray[wx][wy] == 9 ){roundMineCount++;}
						}
						if(ex>=0 && ey<30){
							if(myArray[ex][ey] == 9 ){roundMineCount++;}
						}
						if(ay>=0){
							if(myArray[ax][ay] == 9 ){roundMineCount++;}
						}
						if(dy<30){
							if(myArray[dx][dy] == 9 ){roundMineCount++;}
						}
						if(zx<16 && zy>=0){
							if(myArray[zx][zy] == 9 ){roundMineCount++;}
						}
						if(xx<16){
							if(myArray[xx][xy] == 9 ){roundMineCount++;}
						}
						if(cx<16 && cy<30){
							if(myArray[cx][cy] == 9 ){roundMineCount++;}
						}
						break
					}
					
				var slsElement = 'floor_'+sx+' room_'+sy;
		        var sls = document.getElementsByClassName(slsElement);   
			        
				var qlsElement = 'floor_'+qx+' room_'+qy;
		        var qls = document.getElementsByClassName(qlsElement);   
		        
		        var wlsElement = 'floor_'+wx+' room_'+wy;
	        	var wls = document.getElementsByClassName(wlsElement);

	        	var elsElement = 'floor_'+ex+' room_'+ey;
	        	var els = document.getElementsByClassName(elsElement);

	        	var alsElement = 'floor_'+ax+' room_'+ay;
	        	var als = document.getElementsByClassName(alsElement);

	        	var dlsElement = 'floor_'+dx+' room_'+dy;
	        	var dls = document.getElementsByClassName(dlsElement);

	        	var zlsElement = 'floor_'+zx+' room_'+zy;
	        	var zls = document.getElementsByClassName(zlsElement);

	        	var xlsElement = 'floor_'+xx+' room_'+xy;
	        	var xls = document.getElementsByClassName(xlsElement);

	        	var clsElement = 'floor_'+cx+' room_'+cy;
	        	var cls = document.getElementsByClassName(clsElement);
	        	
	        	if($('td').hasClass('floor_'+qx+' room_'+qy)){//클래스가 있나 없나 확인
	        		if(qls[0].childElementCount==1){
		        		if(qls[0].children[0].attributes[0].value=="./real/flag.png"){roundFlagMine++;}
		        	}
		        }
	        	if($('td').hasClass('floor_'+wx+' room_'+wy)){//클래스가 있나 없나 확인
	        		if(wls[0].childElementCount==1){
		        		if(wls[0].children[0].attributes[0].value=="./real/flag.png"){roundFlagMine++;}
		        	}
		        }
	        	if($('td').hasClass('floor_'+ex+' room_'+ey)){//클래스가 있나 없나 확인
	        		if(els[0].childElementCount==1){
		        		if(els[0].children[0].attributes[0].value=="./real/flag.png"){roundFlagMine++;}
		        	}
		        }
	        	if($('td').hasClass('floor_'+ax+' room_'+ay)){//클래스가 있나 없나 확인
	        		if(als[0].childElementCount==1){
		        		if(als[0].children[0].attributes[0].value=="./real/flag.png"){roundFlagMine++;}
		        	}
		        }
	        	if($('td').hasClass('floor_'+dx+' room_'+dy)){//클래스가 있나 없나 확인
	        		if(dls[0].childElementCount==1){
		        		if(dls[0].children[0].attributes[0].value=="./real/flag.png"){roundFlagMine++;}
		        	}
		        }
	        	if($('td').hasClass('floor_'+zx+' room_'+zy)){//클래스가 있나 없나 확인
	        		if(zls[0].childElementCount==1){
		        		if(zls[0].children[0].attributes[0].value=="./real/flag.png"){roundFlagMine++;}
		        	}
		        }
	        	if($('td').hasClass('floor_'+xx+' room_'+xy)){//클래스가 있나 없나 확인
	        		if(xls[0].childElementCount==1){
		        		if(xls[0].children[0].attributes[0].value=="./real/flag.png"){roundFlagMine++;}
		        	}
		        }
	        	if($('td').hasClass('floor_'+cx+' room_'+cy)){//클래스가 있나 없나 확인
	        		if(cls[0].childElementCount==1){
		        		if(cls[0].children[0].attributes[0].value=="./real/flag.png"){roundFlagMine++;}
		        	}
		        }
	        	
	        	console.log("이게 깃발이랑 지뢰 위치 같은경우 : "+ roundFlagMine);
	        	//var roundMineCount = 0;//주변부 지뢰 수
				//var roundFlagMine = 0;//깃발 수
	        	if(sls[0].innerHTML !=""){
	        		if(roundMineCount==roundFlagMine){
	        			if($('td').hasClass('floor_'+qx+' room_'+qy)){//클래스가 있나 없나 확인
	        				if(qls[0].innerHTML==""){
			        			pressOpen(qls,myArray,qx,qy);
			        		}
	    		        }
	    	        	if($('td').hasClass('floor_'+wx+' room_'+wy)){//클래스가 있나 없나 확인
	    	        		if(wls[0].innerHTML==""){
			        			pressOpen(wls,myArray,wx,wy);
			        		}
	    		        }
	    	        	if($('td').hasClass('floor_'+ex+' room_'+ey)){//클래스가 있나 없나 확인
	    	        		if(els[0].innerHTML==""){
			        			pressOpen(els,myArray,ex,ey);
			        		}
	    		        }
	    	        	if($('td').hasClass('floor_'+ax+' room_'+ay)){//클래스가 있나 없나 확인
	    	        		if(als[0].innerHTML==""){
			        			pressOpen(als,myArray,ax,ay);
			        		}
	    		        }
	    	        	if($('td').hasClass('floor_'+dx+' room_'+dy)){//클래스가 있나 없나 확인
	    	        		if(dls[0].innerHTML==""){
			        			pressOpen(dls,myArray,dx,dy);
			        		}
	    		        }
	    	        	if($('td').hasClass('floor_'+zx+' room_'+zy)){//클래스가 있나 없나 확인
	    	        		if(zls[0].innerHTML==""){
			        			pressOpen(zls,myArray,zx,zy);
			        		}
	    		        }
	    	        	if($('td').hasClass('floor_'+xx+' room_'+xy)){//클래스가 있나 없나 확인
	    	        		if(xls[0].innerHTML==""){
			        			pressOpen(xls,myArray,xx,xy);
			        		}
	    		        }
	    	        	if($('td').hasClass('floor_'+cx+' room_'+cy)){//클래스가 있나 없나 확인
	    	        		if(cls[0].innerHTML==""){
			        			pressOpen(cls,myArray,cx,cy);
			        		}
	    		        }
	        		}
	        	}
				winCondition();
				}
				
		        if($('td').hasClass('floor_'+sx+' room_'+sy)){//클래스가 있나 없나 확인
		        	var clsElement = 'floor_'+sx+' room_'+sy;
		        	var cls = document.getElementsByClassName(clsElement);
		        	if(cls[0].innerHTML == ""){
		        		cls[0].innerHTML ="<img src='./real/press.png' width='39px' height='39px'/>";
		        	}       
		        }
		        if($('td').hasClass('floor_'+qx+' room_'+qy)){
		        	var clsElement = 'floor_'+qx+' room_'+qy;
		        	var cls = document.getElementsByClassName(clsElement);
		        	if(cls[0].innerHTML == ""){
		        		cls[0].innerHTML ="<img src='./real/press.png' width='39px' height='39px'/>";
		        	}
		        	
		        }
		        if($('td').hasClass('floor_'+wx+' room_'+wy)){
		        	var clsElement = 'floor_'+wx+' room_'+wy;
		        	var cls = document.getElementsByClassName(clsElement);
		        	if(cls[0].innerHTML == ""){
		        		cls[0].innerHTML ="<img src='./real/press.png' width='39px' height='39px'/>";
		        	}
		        }
		        if($('td').hasClass('floor_'+ex+' room_'+ey)){
		        	var clsElement = 'floor_'+ex+' room_'+ey;
		        	var cls = document.getElementsByClassName(clsElement);
		        	if(cls[0].innerHTML == ""){
		        		cls[0].innerHTML ="<img src='./real/press.png' width='39px' height='39px'/>";
		        	}
		        }
		        if($('td').hasClass('floor_'+ax+' room_'+ay)){
		        	var clsElement = 'floor_'+ax+' room_'+ay;
		        	var cls = document.getElementsByClassName(clsElement);
		        	if(cls[0].innerHTML == ""){
		        		cls[0].innerHTML ="<img src='./real/press.png' width='39px' height='39px'/>";
		        	}
		        }
		        if($('td').hasClass('floor_'+dx+' room_'+dy)){
		        	var clsElement = 'floor_'+dx+' room_'+dy;
		        	var cls = document.getElementsByClassName(clsElement);
		        	if(cls[0].innerHTML == ""){
		        		cls[0].innerHTML ="<img src='./real/press.png' width='39px' height='39px'/>";
		        	}
		        }
		        if($('td').hasClass('floor_'+zx+' room_'+zy)){
		        	var clsElement = 'floor_'+zx+' room_'+zy;
		        	var cls = document.getElementsByClassName(clsElement);
		        	if(cls[0].innerHTML == ""){
		        		cls[0].innerHTML ="<img src='./real/press.png' width='39px' height='39px'/>";
		        	}
		        }
		        if($('td').hasClass('floor_'+xx+' room_'+xy)){
		        	var clsElement = 'floor_'+xx+' room_'+xy;
		        	var cls = document.getElementsByClassName(clsElement);
		        	if(cls[0].innerHTML == ""){
		        		cls[0].innerHTML ="<img src='./real/press.png' width='39px' height='39px'/>";
		        	}
		        }
		        if($('td').hasClass('floor_'+cx+' room_'+cy)){
		        	var clsElement = 'floor_'+cx+' room_'+cy;
		        	var cls = document.getElementsByClassName(clsElement);
		        	if(cls[0].innerHTML == ""){
		        		cls[0].innerHTML ="<img src='./real/press.png' width='39px' height='39px'/>";
		        	}
		        }
			}
		});
		}
	
		 $(document).bind("contextmenu", function(event) {//우클릭시 발생했던 메뉴창 삭제
			    event.preventDefault();//이벤트 삭제
			    event.stopPropagation();
			});
			$('html, body').css({'overflow': 'hidden', 'height': '100%'});
			$('#element').on('scroll touchmove mousewheel', function(event) {
			  event.preventDefault();
			  event.stopPropagation();
			  return false;
			});
	</script>
</html>