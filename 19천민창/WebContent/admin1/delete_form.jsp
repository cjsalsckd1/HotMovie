<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp" %>
<%
int admin1no = Integer.parseInt(request.getParameter("admin1no"));
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/style.css" type="text/css" />
</head>
<!-- ------------------------- -->
<body leftmargin="0" topmargin="0">
<jsp:include page="/menu/top.jsp" flush="false" />
<!-- ------------------------- -->

<div class="content">
  <form action="./update_proc.jsp" name="frm" method="post">
    <input type="hidden" name="admin1no" value="<%=admin1no %>" />
    
    <fieldset class="filedset">
      <legend class="legend">관리자 > 회원 정보 변경</legend>
      <ul>
        <li>
          <label for="email" class="label">이메일</label>
          <input type="email" name="email" id="email" required="required" />
        </li>
        <li class="center">
          <button type="submit">변경 적용</button>
          <button type="button" id="close">닫기 </button>
        </li>
      </ul>
    </fieldset>
  </form>
</div>
<!-- --------------------------------- -->
<jsp:include page="/menu/footer.html" flush="false" />
<!-- --------------------------------- -->
</body>
</html>