<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="Stylesheet" href="../css/style.css" type="text/css" />
	<style>
		ul, li {
		margin-bottom:2px
		}
	</style>
</head>
<!-- -------------------------------- -->
<body leftmargin="0" topmargin="0">
<jsp:include page="./menu/top.jsp" flush="false" />
<!-- -------------------------------- -->
<%
int pdsno = Integer.parseInt(request.getParameter("pdsno"));

PdsVO vo = pdsDAO.read(pdsno);
//System.out.println("-->  + vo.getTitle()");

pdsDAO.increaseCnt(pdsno);//조회수 증가
%>

<div class="title"><b>영화 정보</b></div>

<div class="content">
<form>
  <fieldset>
    <ul style="line-height:150%">
      <li>
        <span class="item_title"><b>제목</b> : </span><%=vo.getTitle() %>(<%=vo.getRdate().substring(0, 16) %>) 
          조회수 : <%=vo.getCnt() %>
      </li>
      <li>
        <span class="item_title"><b>내용</b> : </span><br>
        <%
        String file = vo.getFile1();
        long size = vo.getSize1();
        
        if(Tool.isImage(file)){
        %>
          <div style="width:50%; float:left; margin:0px 0px 0px 0px;">
          	<img src="./storage/<%=vo.getFile1() %>" width=50%" />
          	<div id="cts" style="float:left;">
            <%=Tool.convertChar(vo.getContent()) %>
            </div>
          </div>
          <%
        }
          %>
          
      </li>
      <li>
        <div style="clear:both; width:30%; margin:0px auto;"> </div>
        <span class="item_title"><b>성명</b> : </span><%=vo.getRname() %>
        <%
        if(vo.getEmail().length()>0){
        %>
          <span class="item_title">Email :</span><%=vo.getEmail() %>
        <%
        }
        if(vo.getSize1()>0){
        %>
        <span class="item_title">FILE :</span>
        <a href="<%=root %>/download?dir=/pds3/storage&filename=<%=vo.getFile1() %>"><%=vo.getFile1() %></a>
        (<%=Tool.unit(vo.getSize1()) %>)
        <%
        }
        %>  
      </li>
      <li>
      <%
      if(Tool.checkNull(vo.getUrl()).length()>0){
      %>
      <span class="item_title"><b>URL</b> :</span>
      <a href="<%=vo.getUrl() %>" target=" _blank=""><%=vo.getUrl() %></a>
      <%
      }
      %>
      </li>
      <li class="right">
        <button type="button" onclick="location.href='./update_form.jsp?pdsno=<%=pdsno %>'">수정</button>
        <button type="button" onclick="location.href='./delete_form.jsp?pdsno=<%=pdsno %>'">삭제</button>
      </li>
    </ul>
  </fieldset>
</form>
</div>
<!-- -------------------------------- -->
<jsp:include page="/menu/footer.html" flush="false" />
</body>
<!-- -------------------------------- -->
</html>