<%@page import="java.net.URLEncoder"%>
<%@page import="tool.Upload"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/style.css" rel="Stylesheet" type="text/css">
</head>
<!--  ********************************* -->
<body leftmargin="0" topmargin="0">
<!--  ********************************* -->
<%
  int pdsno = Integer.parseInt(request.getParameter("pdsno"));
  String passwd = request.getParameter("passwd");
  
  //파일 전송시 사용할 임시 파일 저장소
  String tempDir = application.getRealPath("/pds3/temp");
  
  //최종 파일 저장소
  String upDir = application.getRealPath("/pds3/storage");
  
  if(pdsDAO.passwordCheck(pdsno, passwd)==1){
    Upload upload = new Upload(request, -1, -1, tempDir);
    upload.deleteFile(upDir, pdsDAO.read(pdsno).getFile1());  //파일 삭제
    
    int count = pdsDAO.delete(pdsno);   //레코드 삭제
    if(count==1){
     //URLEncoder.encode(); // 한글 및 특수문자 코드로 변환
     String link = "./list.jsp?col=" + col + "&word=" + URLEncoder.encode(word, "utf-8") + "&nowPage=" + nowPage;
     response.sendRedirect(link); //페이지 자동 이동
    }else{
     %> 
    <div class="title" style="width:70%">삭제에 실패했습니다.</div>
    <div class="bottom">
      <button type="button" onclick="history.back();">다시 시도</button>
      <button type="button" onclick="location.href='./list.jsp?col=<%=col %>&word=<%=word %>&nowPage=<%=nowPage %>'">목록</button>
    </div>
    <%
    }
    }else{
    %>
    <div class="title" style="width:70%">패스워드가 일치하지 않습니다.</div>
    <div class="bottom">
      <button type="button" onclick="history.back();">다시 시도</button>
      <button type="button" onclick="location.href='./list.jsp?col=<%=col %>&word=<%=word %>&nowPage=<%=nowPage %>'">목록</button>
    </div>
  <%
  }
  %>
<!-- ********************** -->
</body>
<!-- ********************** -->
</html>