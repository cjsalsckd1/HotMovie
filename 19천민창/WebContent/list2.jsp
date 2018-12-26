<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ include file="./ssi.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
			text-align:center;
			margin-left:auto;
			margin-right:auto;
		}
.img{
  width:30%;
  height:30%;
}
.title {
			font-size:30px;
		}
</style>
<link rel="Stylesheet" href="../css/style.css" type="text/css" />
</head>
<!-- -------------------- -->
<body leftmargin="0" topmargin="0">
  <jsp:include page="./menu/top.jsp" flush="false" />
  <!-- -------------------- -->
  <%
  ArrayList<PdsVO> list = pdsDAO.list();
  %>
<div class="title"><b>영화 목록</b></div><br>
<div class="mennu_on_table_left">
      <select name="col">
        <option value="none" <%=(word.length()==0)?"selected='selected'":"" %>>전체 목록</option>
        <option value="rname" <%=(col.equals("rname"))?"selected='selected'":"" %>>이름</option>
        <option value="title" <%=(col.equals("title"))?"selected='selected'":"" %>>제목</option>
        <option value="content" <%=(col.equals("content"))?"selected='selected'":"" %>>내용</option>
      </select>
      
      <%
        if(col.equals("none")){
        	word="";
        }
      %>
      <input type="text" name="word" style="width:300px" value="<%=word %>" />
      <input type="submit" value="검색" />
      <button type="button" onclick="location.href='./list3.jsp?col=<%=col %>&nowPage=<%=nowPage %>'">앨범형</button>
	  <button type="button" onclick="location.href='./list2.jsp?col=<%=col %>&nowPage=<%=nowPage %>'">목록형</button>
    </div><br>
      <div class="container">
  <div class="row">
  <div class="col">
  <table class="table table-hover table-bordered">
    <colgroup>
      <col style="width: 5%" />
      <col style="width: 10%" />
      <col style="width: 45%" />
      <col style="width: 10%" />
      <col style="width: 5%" />
      <col style="width: 15%" />
      <col style="width: 10%" />
    </colgroup>
    <tr>
      <th class="th">번호</th>
      <th class="th">파일</th>
      <th class="th">제목</th>
      <th class="th">성명</th>
      <th class="th">조회</th>
      <th class="th">등록일</th>
      <th class="th">기타</th>
    </tr>
    <%
    for(int index=0; index<list.size(); index++){
     PdsVO vo = list.get(index);  //PdsVO 객체 추출 
    %>
    <tr>
      <td class="td"><%=vo.getPdsno() %></td>
      <td class="td">
        <%
    String file = vo.getFile1();
    long size = vo.getSize1();
    
    if(size > 0){
     if(Tool.isImage(file) == true){
    	 %> <a href="./storage/<%=file %>"></a><img
        src="./storage/<%=file %>" width="50%" /> <%
      }else{ 
    %> <a href="./storage/<%=file %>"><%=file %></a> <%
      }
    }
    %>
      </td>
      <td class="td_left">
        <a href="./read.jsp?pdsno=<%=vo.getPdsno() %>"><%=vo.getTitle() %></a></td>
      <td class="td"><%=vo.getRname() %></td>
      <td class="td"><%=vo.getCnt() %></td>
      <td class="td"><%=vo.getRdate().substring(0, 10) %></td>
      <td class="td">
        <a href="./update_form.jsp?pdsno=<%=vo.getPdsno() %>" class="btn btn-primary">수정</a>
        <a href="./delete_form.jsp?pdsno=<%=vo.getPdsno() %>" class="btn btn-danger">삭제</a>
        </td>
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
<!-- ------------------- -->
  <jsp:include page="/menu/footer.html" flush="false" />
</body>
<!-- -------------------- -->
</html>