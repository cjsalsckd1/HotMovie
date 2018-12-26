<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="tool.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/style.css" type="text/css" />
<script type="text/javascript">
	//console.log('console test');
	//var parent = opener.document;	//window.open을 호출한 html(jsp) 페이지
	//ID 가 'file'인 태그를 찾아 값을 추출
	/* //console.log('-->file: ' + parent.getElementById("file").innerHTML); */
</script>
</head>
<!-- ------------------------------ -->
<body leftmargin="0" topmargin="0">
<!-- ------------------------------ -->
<%
int pdsno = Integer.parseInt(request.getParameter("pdsno"));
String file1 = request.getParameter("file1");
%>
<form action="./update_file_proc.jsp" name="frm" method="post" enctype="multipart/form-data">
  <input type="hidden" name="pdsno" value="<%=pdsno %>" />
  <div style="text-align:center; width:90%; margin:10px auto;">
    <img src="./storage/<%=file1 %>" width="100%" />
    <br>
    <label for="file1">새로운 파일 :</label>
    <input type="file" name="file1" /><br><br>
    <label for="passwd">패스워드 : </label>
    <input type="password" name="passwd" size="10" value="123" />
    <button type="submit">변경 적용</button>
    <button type="button" onclick="window.close();">취소</button>
  </div>
</form>

<!-- --------------------------- -->
</body>
<!-- --------------------------- -->
</html>