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
<div class="title" style="width:20%">전송 결과</div>
<%
  // **********************************
  // 파일 업로드 관련 코드 시작
  // **********************************
  String tempDir = application.getRealPath("/temp");
  //최종 파일 저장소
  String upDir = application.getRealPath("/storage");
  // request : 내부삭제
  // -1 : 메모리에 저장할 최대 크기, 무제한 사용
  // -1 : 업로드 할 최대 파일 크기, 무제한 사용
  // tempDir : 파일 업로드중에 임시로 저장할 폴더
  Upload upload = new Upload(request, -1, -1, tempDir);
  int pdsno = Integer.parseInt(upload.getParameter("pdsno"));
  String passwd = upload.encodeFileUpload12(upload.getParameter("passwd"));
  
  if(pdsDAO.passwordCheck(pdsno, passwd)==1){
   //파일 업로드 관련 코드 시작
   //***********************************
   FileItem fileItem = upload.getFileItem("file1");
   String file1 ="";
   long size1 = 0; //8byte
   
   if(fileItem != null){
    size1 = fileItem.getSize();
    if(size1>0){
     //pdsDAO.read(pdsno).getFile()
     //PdsVO vo = pdsDAO.read(pdsno);
     //String filename= vo.getFile();
     upload.deleteFile(upDir, pdsDAO.read(pdsno).getFile1());  //파일 삭제
     file1 = upload.saveFile(fileItem, upDir);  //파일 저장
    }
   
   }
  //**************************************
 PdsVO vo = new PdsVO();
  vo.setPdsno(pdsno);
  vo.setFile1(file1);
  vo.setSize1(size1);
  int count = pdsDAO.updateFile(vo);
  %>
  <div class="content">
  <%
  if(count==1){
  %>
  <script type="text/javascript">
  <%-- //opener.document.getElementById("file").innerHTML = '<%=file %>'; --%>
  <%-- //var str = "<img src='./storage/<%=file %>' width='150px'>"; --%>
  var str = "<a href=\"javascript: fileUpdate(<%=pdsno%>, '<%=file1 %>')\"><img src='./storage/<%=file1%>' width='150px'></a>";
  opener.document.getElementById("file1").innerHTML = str;  
  // window.close(); //성공했음으로 창 닫기
  </script>
  <%
  }else{
  %>
  <div class="title" style="width:70%">파일 변경에 실패 했습니다.</div>
  <div class="bottom">
    <button type="button" onclick="history.back();">다시 시도</button>
    <button type="button" onclick="window.close();">닫기</button>
  </div>
  <%
  }
  %>
  </div>
  <%
  }else{ 
  %>
  <div class="title" style="width:70%">패스워드가 일치하지 않습니다.</div>
  <div class="bottom">
    <button type="button" onclick="history.back();">다시 시도</button>
    <button type="button" onclick="window.close();">닫기</button>
  </div>
  <%
  }
  %>
<!--  ********************************* 
<jsp:include page="/menu/footer.html" flush="false" />
 ********************** -->
</body>
<!-- ********************** -->
</html>