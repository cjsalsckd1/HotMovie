<%@page import="pds3.PdsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="./ssi.jsp" %>
<%@ page import="tool.*"%>
<%
//-------------------------------------
//페이징 관련 코드 시작
//-------------------------------------
int totalRecord = pdsDAO.count(col, word);
int recordPerPage = 4;  //페이지당 레코드 수
String paging = new Paging().paging3(totalRecord, nowPage, recordPerPage, col, word);
//-------------------------------------
//페이징 관련 코드 종료
//-------------------------------------

//ArrayList<Pds3VO> list = pds3DAO.list();  //전체 레코드
//ArrayList<PdsVO> list = pdsDAO.list(col, word); //검색
ArrayList<PdsVO> list = pdsDAO.list(col, word, nowPage, recordPerPage);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/style.css" type="text/css" />
</head>
<!-- ------------------------------------------------- -->
<body leftmargin="0" topmargin="0">
<jsp:include page="/menu/top.jsp" flush="false" />
<!-- ------------------------------------------------- -->
<div class="title">힐링 휴양림</div>

<div class="content" style="width:88%;">
  <form action="./list.jsp" name="frm" method="post">
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
      <input type="text" name="word" value="<%=word %>" />
      <input type="submit" value="검색" />
    </div>
    <div class="menu_on_table_right">
      휴양림의 수 : <%=totalRecord %> 건
      <a href="./list2.jsp">목록 보기</a>
      <a href="./list1.jsp">요약 보기</a>
      <a href="./create_form.jsp">등록</a>
    </div>
  </form>
  <div style="width:100%; clear:both; height:1px; border-top:dotted 1px #AAAAAA;"></div>
  
  <div style="border:none 2px #FF0000; width:100%; margin:0px auto">
    <%
      for(int index=0; index<list.size(); index++){
       PdsVO vo = list.get(index);
       if(index!=0 && index%4==0){
    %>
      <div style="width:100% clear:both; height:1px; border-top:dotted 1px #AAAAAA"></div>
    <%
       }
    %>
    
    <div style="margin=5px; padding:5px; width:200px; height:200px; float:left; border:none 1px #AAAAAA;">
      <%
        int pdsno = vo.getPdsno();
        String file = vo.getFile1();
        long size = vo.getSize1();
        String title = vo.getTitle();
        String rdate = vo.getRdate();
        int cnt = vo.getCnt();
        
        if(title.length() > 8){ //긴 문장을 10 자 이내로 변경
         title = title.substring(0, 8) + "..."; 
        }
        
        if(size>0){
         if(Tool.isImage(file)){  //이미지인 경우
      %>
      <a href="./read.jsp?pdsno=<%=pdsno %>&col=<%=col %>&word=<%=word %>&nowPage=<%=nowPage %>">
      <img src="./storage/<%=file %>"style="width:200px; height:150px;" /></a><br>
      
      <a href="./read.jsp?pdsno=<%=pdsno %>&col=<%=col %>&word=<%=word %>&nowPage=<%=nowPage %>">
      <%=title %>(<%=cnt %>)</a><br>
      <%=rdate.substring(0, 16) %>
      <%
         }else{ //이미지가 아닌 경우
      %>
      
      <a href="./read.jsp?pdsno=<%=pdsno %>&col=<%=col %>&word=<%=word %>&nowPage=<%=nowPage %>">
      <%=file %>파일을 <br> 다운로드 할 수 있습니다.</a><br><br>
      
      <a href="./read.jsp?pdsno=<%=pdsno %>&col=<%=col %>&word=<%=word %>&nowPage=<%=nowPage %>">
      <%=title %>(<%=cnt %>)</a><br>
      <%=rdate.substring(0, 16) %>
      <%
         }
        }else{
      %>
        <a href="./read.jsp?pdsno=<%=pdsno %>&col=<%=col %>&word=<%=word %>&nowPage=<%=nowPage %>">
      관련 이미지가 없습니다. <br> 이미지를 업로드 해주세요.</a><br><br>
      
       <a href="./read.jsp?pdsno=<%=pdsno %>&col=<%=col %>&word=<%=word %>&nowPage=<%=nowPage %>">
      <%=title %>(<%=cnt %>)</a><br>
      <%=rdate.substring(0, 16) %>
      <%
      }
      %>
      </div>
      <%
      }
      %>
      <div style="width:100%; clear:both; height:1px; border-top: dotted 1px #AAAAAA;"></div>
  </div>
</div>
<div class="bottom">
  <%=paging %>
</div>
<!-- -------------------------- -->
<jsp:include page="/menu/footer.html" flush="false" />
</body>
</html>