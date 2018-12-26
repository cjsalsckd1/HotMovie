<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp" %>
<%
String email = request.getParameter("email");
String passwd = request.getParameter("passwd");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/style.css" type="text/css" />
</head>
<!-- ----------------------- -->
<body leftmargin="0" topmargin="0">
<jsp:include page="../menu/top.jsp" flush="false" />
<!-- ----------------------- -->

<div class="content">
  <form action="./create_form.jsp" name="frm" method="post">
    <fieldset>
      <legend class="legend">관리자 등록 결과</legend>
      <ul>
        <li>
          <%
            Admin1VO vo = new Admin1VO();
          vo.setEmail(email);
          vo.setPasswd(passwd);
          
          int count = admin1DAO.insert(vo);
          if(count==1){
          %>
          관리자 등록에 성공 했습니다.<br>
          
          <%
          }else{
          %>
          관리자 등록에 실패했습니다. 계속 오류시 담당자에게 문의 하세요.<br>
          <%
          }
          %>
          </li>
          <li class="center">
          <%
          if(count==1){
          %>
          
          <%
          }else{
          %>
          <%
          }
          %>
          </li>
      </ul>
    </fieldset>
    <button type="submit">계속 등록</button>
    <a href='./list.jsp'>목록</a>
  </form>
</div>
<!-- ----------------------- -->
<jsp:include page="/menu/footer.html" flush="false" />
</body>
<!-- ----------------------- -->
</html>