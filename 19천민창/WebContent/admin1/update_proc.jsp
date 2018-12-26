<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp" %>
<%
int admin1no = Integer.parseInt(request.getParameter("admin1no"));
String email = request.getParameter("email");
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
<jsp:include page="/menu/top.jsp" flush="false" />
<!-- ----------------------- -->

<div class="content" style="text-align:center">
<%
//기존 패스워드 일치 여부 검사
if(admin1DAO.update(admin1no, email)==1){ 
%>
  <script type="text/javascript">
  	opener.location.reload();
  </script>
  회원 정보를 변경했습니다.
<%
}else{
%>
  회원 정보를 변경하지 못했습니다.<br><br>
  다시 시도해주세요.<br><br>
<%
}
%>
</div>

<div class="bottom">
  <button type="button" onclick="location.href='./list.jsp'">목록</button>
</div>

<!-- ------------------------------- -->
<jsp:include page="/menu/footer.html" flush="false" />
</body>
<!-- ------------------------------- -->
</html>