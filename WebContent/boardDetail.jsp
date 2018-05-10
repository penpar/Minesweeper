<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8"> 
<script src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
<meta http-equiv="X-UA-Compatible" content="IE=edge"> 
<meta name="viewport" content="width=device-width, initial-scale=1"> 
<title>글쓰기</title> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script> 
<link href="css/bootstrap.min.css" rel="stylesheet">
<style>
   body{
      overflow: auto;
   }
      #comArea{
         position: absolute;
         width: 1020px;
         resize: none;
         overflow-y : auto;
         
      }
       #comBtn{
         position: absolute;
         
         width: 100px;
         height: 75px;
      } 
      #comment{
         position: relative;
         width: 1020px;
         height: 75px;
         left:400px;
         
      }
      #comAreaDiv{
         width: 1050px;
         height: 75px;
         float: left;
      }
      #comTable > tr{
         border: 1px solid;
      }
      #myOnlyDelete,#myOnlyUpdate{
      	display: none;
      }
      #comentPaging{
      position:absolute;
      	left: 50%;
      }
      #nuckBack{
      	height: 50px;
      }
</style> 
</head> 
<body> 
<jsp:include page="./leftBar.jsp"/>
   <div class="panel panel-default"> 
   
   <div class="panel-heading"><h2>게시판</h2></div> 
   
   <div class="panel-body">
   
   <div class="container"> 
   
   <div class="row"> 
   <div class="col-md-6">
   <div class="form-group"> 
   <label for="name">닉네임</label> 
   <input type="text" class="form-control" value="${nickName}" readonly>
   </div> 
   </div>  
   
   </div>
   
   <div class="form-group"> 
   <label for="subject">글 제목</label> 
   <input type="text" class="form-control" value="${dto.b_subject}" readonly> 
   </div> 
   
   
   <div class="form-group"> 
   <label for="content">내용</label> 
   
               <c:if test="${dto.newFileName == null}">
                  <div class="form-control" rows="50" style="height: auto; width: 100%; height:404px" readonly>
               </c:if>
               <c:if test="${dto.newFileName != null}">
                  <div class="form-control" rows="50" style="height: auto; width: 100%;" readonly>
                  <img src="./upload/${dto.newFileName}" width="50%"/>
                  <hr>
               </c:if>
               
               ${dto.b_content}
   </div> 
   </div> 

               
   </div> 
   </div>
   
   
   <div id="gg"class="center-block" style='width:500px'>       
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="button" onclick="location.href='./boardList?ca_num=${ca_num}'" class="btn btn-primary" value="리스트"/>
      <c:if test="${sessionScope.loginId == dto.id}">
      <input type="button" onclick="location.href='./boardUpdateForm?b_key=${dto.b_key}&nickName=${nickName}&id=${id}&ca_num=${ca_num}'" class="btn btn-primary" value="수정"/>
      <input type="button" onclick="location.href='./boardDelete?b_key=${dto.b_key}&ca_num=${ca_num}'" class="btn btn-primary" value="삭제"/>
      </c:if>
      <c:if test="${sessionScope.state == 2}">
      	<input type="button" onclick="location.href='./boardBlind?b_key=${dto.b_key}&ca_num=${ca_num}'" class="btn btn-primary" value="블라인드"/>
      </c:if>
   </div> 

   </div> 
         
         <div id ="comment">
            <div id="comAreaDiv">
                <textarea rows="3" id = "comArea" name="comArea"></textarea>
            </div>
            <div>
               <button class="btn btn-outline-primary" id="comBtn" onclick="comBtn()">댓글 작성</button> 
            </div>
         </div>
         
      <div id="parentComTable">
      <table class="table table-hover" id="comTable">
         
            <tr class="table-active"></tr>
         
      </table>
    <div id="nuckBack"></div>
      </div>
      
      
</body>
<script>
	var session = "${sessionScope.loginId}";
	var id = "${dto.id}";
	$("#comTable").append($("#comentPaging"));
	if(id==session){
		$("#myOnlyUpdate").css("display","inline");
		$("#myOnlyDelete").css("display","inline");
	}

	var filename = "${dto.newFileName}";
	console.log(filename);
      var b_key = "${dto.b_key}";
      $("#comment").append($("#parentComTable"));
      $(document).ready(function(){
         $.ajax({
            type:"get",
            url:"./comList",
            data:{b_key:b_key},
            dataType:"JSON",
            success:function(data){
               console.log(data);
               console.log(data.list);
               if(data.list!=null){
                  listPrint(data.list);               
               }
            },
            error:function(e){
            }
         });
      });
      var session = "${sessionScope.loginId}";
      function listPrint(list){
          var content="";
          var array = [];
          var ax = 0;
          list.forEach(function(item,index){ //향상된 for문
              content ="<tr>";
              content +="<td width='200px'>"+item.nickName+"</td>";
              content +="<td>"+item.c_content+"</td>";
              content +="<td class='date' width='250px'>"+item.c_date+"&nbsp;&nbsp;&nbsp;";
              if(session == item.id||session =='2jomoji'){
            	 content +="<a class='"+item.id+"' href='./comDel?idx="+item.c_idx+"&b_key=${dto.b_key}&ca_num=${ca_num}&nickName=${nickName}'>삭제</a></td>";  
              }
              content +="</tr>";
              $("#comTable").append(content);
              
              if(session == item.id){
                 array[ax] = session;
                 ax++; 
              } 
          });
          
          console.log("길이 : "+array.length);
          var cls;
          for(var i = 0 ; i<array.length;i++){
             cls = document.getElementsByClassName(array[i])
             console.log(cls);
             cls[i].style.display = 'inline';
             console.log(array);
          } 
      }
      
      function comBtn(){
         $.ajax({
            type:"post",
            url:"./comCreat",
            data:{
               b_key:b_key,
               textarea:$("textarea").val(),
            },
            dataType:"JSON",
            success:function(data){
               if(data.success==1){
                  location.reload();
               }else{
                  alert("내용을 입력해 주세요.");
               }
            },
            error:function(e){
               console.log(e);
            }   
         });
      }
</script>
</html>