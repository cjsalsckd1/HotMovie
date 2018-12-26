<%@page import="tool.Upload"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp" %>
<%
  // **********************************
  // 파일 업로드 관련 코드 시작
  // **********************************
  String tempDir = application.getRealPath("/pds3/temp");
  //최종 파일 저장소
  String upDir = application.getRealPath("/pds3/storage");
  // request : 내부삭제
  // -1 : 메모리에 저장할 최대 크기, 무제한 사용
  // -1 : 업로드 할 최대 파일 크기, 무제한 사용
  // tempDir : 파일 업로드중에 임시로 저장할 폴더
  Upload upload = new Upload(request, -1, -1, tempDir);
  // 파일 객체 추출 <input type='file' name='file1' size='60'>
  FileItem fileItem = upload.getFileItem("file1");
  String file1 = "";
  long size1 = 0; // 8 byte
  if (fileItem != null) {
   size1 = fileItem.getSize();
   if (size1 > 0) {
    file1 = upload.saveFile(fileItem, upDir);
   }
  }
  // ******************************
  // 파일 업로드 관련 코드 종료
  // ******************************
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/style.css" rel="Stylesheet" type="text/css">
</head>
<!--  ********************************* -->
<body leftmargin="0" topmargin="0">
<!--  ********************************* -->
<%
  String title = upload.encodeFileUpload12(upload.getParameter("title"));
  String content = upload.encodeFileUpload12(upload.getParameter("content"));
  String url = upload.getParameter("url");
  String rname = upload.encodeFileUpload12(upload.getParameter("rname"));
  String email = upload.encodeFileUpload12(upload.getParameter("email"));
  String passwd = upload.encodeFileUpload12(upload.getParameter("passwd"));
  
  PdsVO vo = new PdsVO();
  vo.setTitle(title);
  vo.setContent(content);
  vo.setUrl(url);
  vo.setRname(rname);
  vo.setEmail(email);
  vo.setPasswd(passwd);
  vo.setFile1(file1);
  vo.setSize1(size1);
  int count = pdsDAO.insert(vo);

%>
  <div class='title' style='width : 20%;'>전송 결과</div>
  <div class='content'>
  <%
  if (count ==1) {
  %>
    <div class="title" style='width : 70%;'>자료 <%=count %> 건을 등록했습니다.</div>
  <%
  }else {
  %>  
    <div class="title" style='width : 70%;'>자료<%=count %> 건을 등록했습니다.</div>
  <%
  }
  %>
  </div> 
  <div class='bottom'>
  <input type="button" value="계속 전송" onclick="location.href='./create_form.jsp'">
  <input type="button" value="목록" onclick= "location.href='./list2.jsp'">
  </div>
<!-- ********************** -->
</body>
<!-- ********************** -->
</html>