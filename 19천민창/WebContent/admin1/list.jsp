<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<link href="../css/style.css" rel="Stylesheet" type="text/css">
<script type="text/javascript">
function delete_admin(admin1no, email){
	var sw = confirm(email + '관리자를 삭제하시겠습니까?');
	if(sw == true){
		location.href="./delete_proc.jsp?admin1no=" + admin1no;
	}else{
		alert('관리자 삭제를 취소합니다.');
	}
}
</script>
</head>
<!-- ------------------------- -->
<body leftmargin="0" topmargin="0">
<jsp:include page="/menu/top.jsp" flush='false' />
<!-- ------------------------- -->
<%
ArrayList<Admin1VO> list = admin1DAO.list();
%>
<div class='title'>관리자 목록</div>
<table class='table'>
<tr>
	<th class='th' style='width:10%;'>번호</th>
	<th class='th' style='width:60%;'>이메일</th>
	<th class='th' style='width:15%;'>등록일</th>
	<th class='th' style='width:15%;'>기타</th>
</tr>
<%
for(int index=0; index<list.size(); index++){
	Admin1VO vo = list.get(index);
	int admin1no = vo.getAdmin1no();
%>
<tr>
	<td class='td'><%=admin1no %></td>
	<td class='td_left'><%=vo.getEmail() %></td>
	<td class='td'><%=vo.getMdate().substring(0, 10) %></td>
	<td class='td'><a href='./passwd_form.jsp?admin1no=<%=admin1no %>'>
		패스워드 수정</a>
		<a href='./update_form.jsp?admin1no=<%=admin1no %>'>
		수정</a>
		<a href="javascript:delete_admin(<%=admin1no %>, '<%=vo.getEmail() %>')">
		삭제</a></td>
</tr>
<%
	}
%>
</table>
<div class='bottom'>
	<button type='button' onclick="location.href='./create_form.jsp'">등록</button>
	<button type='button' onclick="location.reload();">새로고침</button>
</div>
<!-- -------------------------- -->
<jsp:include page="/menu/footer.html" flush='false' />
</body>
<!-- -------------------------- -->
</html>