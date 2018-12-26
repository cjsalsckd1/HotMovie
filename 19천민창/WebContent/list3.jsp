<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="Stylesheet" href="../css/style.css" type="text/css" />
	<style>
		body {
			text-align:center;
			margin-left:auto;
			margin-right:auto;
		}
		.title {
			font-size:30px;
		}
		
	</style>
</head>
<body leftmargin="0" topmargin="0">
<!-- ----------------------------------------------------------- -->
<jsp:include page="./menu/top.jsp" flush='false'/> 
<!-- ----------------------------------------------------------- -->
<%
  ArrayList<PdsVO> list = pdsDAO.list();
%>
<div class="title"><b>영화 목록</b></div><br>
<div class="mennu_on_table_left">
      <select name="col">
        <option value="none" <%=(word.length()==0)?"selected='selected'":"" %>>전체 목록</option>
        <option value="rname" <%=(col.equals("rname"))?"selected='selected'":"" %>>이름</option>
        <option value="title" <%=(col.equals("title"))?"selected='selected'":"" %>>제목</option>
        <option value="content" <%=(col.equals("content"))?"selected='selected'":"" %>>내용</option>
      </select>
      
      <%
        if(col.equals("none")){
        	word="";
        }
      %>
      <input type="text" name="word" style="width:300px" value="<%=word %>" />
      <input type="submit" value="검색" />
      <button type="button" onclick="location.href='./list3.jsp?col=<%=col %>&nowPage=<%=nowPage %>'">앨범형</button>
<button type="button" onclick="location.href='./list2.jsp?col=<%=col %>&nowPage=<%=nowPage %>'">목록형</button>
    </div>
    
<div class="content">
  <div class="imageList style="border:none 2px #FF0000; width:80%;">
  <%
  for(int index=0; index<list.size(); index++){
   PdsVO vo = list.get(index);
   if(index != 0 && index % 4 == 0){
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
  <div class="bottom">
    <button type="button" onclick="location.href='./create_form.jsp'">영화 등록</button>
   </div> 
<!-- ----------------------------------------------------------- -->
<jsp:include page="/menu/footer.html" flush='false'/> 
<!-- ----------------------------------------------------------- -->
</body>
</html>