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
<link rel= "stylesheet" type="text/css" href="./css/literacss.css">
<style>
   .form-control{
      position: relative;
      resize: none;
   }
</style>
</head> 
<body> 
<jsp:include page="./leftBar.jsp"/>
   <div class="panel panel-default"> 
   
   <div class="panel-heading"><h2>게시판</h2></div> 
   
   <div class="panel-body">
   
   <div class="container"> 
    
   
   <form action="./boardUpdate?ca_num=${ca_num }&nickName=${nickName}&b_key=${dto.b_key}" method="post" enctype="multipart/form-data">
   
   <div class="row"> 
   <div class="col-md-6">
   <div class="form-group"> 
   <label for="name">닉네임</label> 
   <input type="text" class="form-control" name="nickName" value="${nickName}" readonly>
   <input type="hidden" name="b_key" value="${dto.b_key}"/>
   </div> 
   </div>  
   
   </div>
   
   <div class="form-group"> 
   <label for="subject">글 제목</label> 
   <input type="text" class="form-control" name ="b_subject" id="subject" value="${dto.b_subject}"> 
   </div> 
   
   
   <div class="form-group"> 
   <label for="content">내용</label> 
   <textarea class="form-control" rows="15" name="b_content" id="content">${dto.b_content}</textarea> 
   
   </div> 
    
   <div class="form-group"> 
   <label for="File">사진 등록</label>
               <c:if test="${dto.newFileName != null}">
                  <img class="thumb" src="./upload/${dto.newFileName}" width="200px" height="200px"/>
               </c:if> 
   <input type="file" name="photo"> 
   </div> 
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <div class="center-block" style='width:500px'> 
   <input  type="submit" class="btn btn-primary" value="수정하기"> <input type="reset"  class="btn btn-primary" value="다시쓰기">
   <input type="button"  class="btn btn-primary"value="리스트" onclick="location.href='./boardList?ca_num=${ca_num}'">
   </div> 
   
   </form>
   </div> 
   </div>
   </div> 

</body>
</html>