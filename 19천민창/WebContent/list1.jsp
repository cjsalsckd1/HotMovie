<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ include file="./ssi.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.img{
  width:30%;
  height:30%;
}
.title {
	text-align:center;
	font-size:30px;
}
.bottom {
	text-align:center;
}
</style>
<link rel="Stylesheet" href="../css/style.css" type="text/css" />
</head>
<body leftmargin="0" topmargin="0">
  <jsp:include page="./menu/top.jsp" flush="false" />
  <!-- ----------------- -->
  <%
  	ArrayList<PdsVO> list = pdsDAO.list();
  %>
  <DIV class="title"><b>추천영화</b></DIV><br>
  <div class="container">
  <div class="row">
  <div class="col">

  <table class="table table-hover table-bordered">
    <tr>
      <th class="th" style="width: 10%">번호</th>
      <th class="th" style="width: 45%">제목</th>
      <th class="th" style="width: 10%">성명</th>
      <th class="th" style="width: 5%">조회</th>
      <th class="th" style="width: 20%">등록일</th>
      <th class="th" style="width: 10%" colspan="2">기타</th>
    </tr>
    <%
    	for (int index = 0; index < list.size(); index++) {
    		PdsVO vo = list.get(index);
    %>
    <tr>
      <td class="td"><%=vo.getPdsno()%></td>
      <td class="td_left"><a
        href="./read.jsp?pdsno=<%=vo.getPdsno()%>"><%=vo.getTitle()%></a></td>
      <td class="td"><%=vo.getRname()%></td>
      <td class="td"><%=vo.getCnt()%></td>
      <td class="td"><%=vo.getRdate().substring(0, 10)%></td>
      <td class="td">
      <a href="./update_form.jsp?pdsno=<%=vo.getPdsno()%>" class="btn btn-primary">수정</a></td>
      <td>
      <a href="./delete_form.jsp?pdsno=<%=vo.getPdsno()%>" class="btn btn-danger">삭제</a></td>
    </tr>
    <%
    	}
    %>
  </table>
  </div>
  </div>
  </div>
  <div class="bottom">
    <button type="button" onclick="location.href='./create_form.jsp'">등록</button>
  </div>
  <!-- -------------------- -->
  <jsp:include page="/menu/footer.html" flush="false" />
</body>
<!-- -------------------- -->
</html>