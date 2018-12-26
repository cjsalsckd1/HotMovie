<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>영화나라</title>
	<style>
		.mySlides {
			display:none;
		}
		#main {
			border:none;
			width:30%;
			margin-left:auto;
			margin-right:auto;
		}
	</style>
</head>
<body leftmargin="0" topmargin="0">
<!-- ----------------------------------------------------------- -->
<jsp:include page="./menu/top.jsp" flush='false'/> 
<!-- ----------------------------------------------------------- -->
	<div id="main">
		<h1 class="w3-center" align="center">오늘의 영화</h1>
		
		<div class="w3-content w3-display-container" align="center">
		
		  <img class="mySlides" src="images/m2.JPG" style="width:65%">
		  <img class="mySlides" src="images/m3.JPG" style="width:65%">
		  <img class="mySlides" src="images/m4.JPG" style="width:65%">
		  <img class="mySlides" src="images/m5.JPG" style="width:65%">
		  <img class="mySlides" src="images/m6.JPG" style="width:65%">
		  <img class="mySlides" src="images/m7.JPG" style="width:65%">
		  <img class="mySlides" src="images/m8.JPG" style="width:65%">
		  <img class="mySlides" src="images/m9.JPG" style="width:65%">
		  <img class="mySlides" src="images/m1.JPG" style="width:65%">
		  
		  <button class="w3-button w3-black w3-display-left" onclick="plusDivs(-1)">&#10094;</button>
		  <button class="w3-button w3-black w3-display-right" onclick="plusDivs(1)">&#10095;</button>
		</div>
	</div>
<hr>
<%
  ArrayList<PdsVO> list = pdsDAO.list();
%>
<div class="content">
  <div class="imageList style="border:none 2px #FF0000; width:80%;">
  <%
  for(int index=0; index<list.size(); index++){
   PdsVO vo = list.get(index);
   if(index != 0 && index % 9 == 0){
    %>
  <div style="width:100%; clear:both; height:1px; border-top:dotted 1px #AAAAAA;"></div>
   <%
   }
   %>
   <div style="margin:5px; padding:5px; width:200px; height:200px; float:left; border:none 1px #AAAAAA;">
   <%
   int pdsno = vo.getPdsno();
   String file = vo.getFile1();
   long size = vo.getSize1();
   String title = vo.getTitle();
   String rdate = vo.getRdate();
   int cnt = vo.getCnt();
   
   if(title.length() > 10){//긴 문장을 10자 이내로 변경
     title = title.substring(0, 10) + "...";
   }
   if(size > 0){
     if(Tool.isImage(file)){//이미지인 경우
      %>
      <a href="./read.jsp?pdsno=<%=pdsno %>"><img src="./storage/<%=file %>" style="width:200px; height:150px;" /></a>
      <br>
      <%=rdate.substring(0, 16) %>
      <%}else{ %><!-- //이미지가 아닌경우 -->
        <a href="./read.jsp=pdsno=<%=pdsno %>"><%=file %>파일을 <br> 다운로드 할 수 있습니다.</a>
        <br><br>
        <%=rdate.substring(0, 16) %>
        <%
      }
   }else{
     %>
     <a href="./read.jsp?pdsno=<%=pdsno %>">관련 이미지가 없습니다.<br> 이미지를 업로드 해주세요.</a>
     <br><br>
     <a href="./read.jsp?pdsno=<%=pdsno %>"><%=title %>(<%=cnt %>)</a>
     <br>
     <%=rdate.substring(0, 10) %>
     <%
     }
     %>
   </div>
   <%
   }
   
   %>
   <div style="width:100%; clear:both; height:1px; border-top:dotted 1px #AAAAAA;"></div>
   </div>
  </div>
	
<script>
var slideIndex = 1;
showDivs(slideIndex);

function plusDivs(n) {
  showDivs(slideIndex += n);
}

function showDivs(n) {
  var i;
  var x = document.getElementsByClassName("mySlides");
  if (n > x.length) {slideIndex = 1}
  if (n < 1) {slideIndex = x.length}
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";  
  }
  x[slideIndex-1].style.display = "block";  
}
</script>
<!-- ----------------------------------------------------------- -->
<jsp:include page="/menu/footer.html" flush='false'/> 
<!-- ----------------------------------------------------------- -->
</body>
</html>