<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="tool.*" %>
<%@ page import="pds3.*" %>
<%@ include file="./ssi.jsp" %>
<%
  request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/style.css" type="text/css" />
<style>
	.content {
	text-align:center;
	margin-left:auto;
	margin-right:auto;
	margin-top:100px;
	}
	ul {
		list-style-type:none;
	}
</style>
</head>
<!--  -->
<body>
<jsp:include page="./menu/top.jsp" flush='false'/> 
<!--  -->
<%
int pdsno = Integer.parseInt(request.getParameter("pdsno"));
%>
  <div class='content' style="width:60%">
    <form name='frm' method='post' action='./delete_proc.jsp'>
      <input type="hidden" name="pdsno" value='<%=pdsno %>'>
      <input type="hidden" name="col" value='<%=col %>'>
      <input type="hidden" name="word" value='<%=word %>'>
      <input type="hidden" name="nowPage" value='<%=nowPage %>'>
        <fieldset>
          <legend><b>영화 정보 삭제<b></legend>
            <ul>
              <li>
                <label for='passwd'>패스워드 확인</label><br>
                <input type='password' name='passwd' id='title' size='30px' value=''>
              </li>
              <li class="right"><br>
                <button type="submit">삭제</button>
                <button type="button" onclick="location.href='./list.jsp?col=<%=col %>&word=<%=word %>&nowPage=<%=nowPage %>'">취소</button>
              </li>
            </ul>
        </fieldset>
    </form>
  </div>
<!--  -->
<jsp:include page="/menu/footer.html" flush='false'/> 
<!--  -->
</body>
</html>