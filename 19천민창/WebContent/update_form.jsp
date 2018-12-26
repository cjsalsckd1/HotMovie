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
<script type="text/javascript">
  function fileUpdate(pdsno, file1){
    //alert(file);
    var win_file = window.open('./update_file_form.jsp?pdsno=' + pdsno+'&file1='+file1, '파일 변경',
        'width=600px, height=550px, scrollbars=no')
    //alert(screen.width + "/" + screen.height);
    var x = (screen.width - 600)/2;
    var y = (screen.height - 550)/2;
    
    win_file.moveTo(x, y); //화면 이동
  }
</script>
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

PdsVO vo = pdsDAO.read(pdsno);  //변경할 내용 조회
%>
  <div class='content'>
    <form name='frm' method='post' action='./update_proc.jsp'>
      <input type="hidden" name="pdsno" value='<%=pdsno %>'>
        <fieldset>
          <legend><b>영화 정보 변경</b></legend>
            <ul>
               <li>
                <label for='file1'>첨부 파일</label><br>
                  <span id="file1">
                   <a href="javascript: fileUpdate(<%=pdsno %>, '<%=vo.getFile1() %>')">
                   <img src="./storage/<%=vo.getFile1() %>" width='300px'></a>
                  </span><br><br>
              </li>
              <li>
                <label for='title'>제목</label>
                <input type='text' name='title' id='title' size='50' value='<%=vo.getTitle()%>'>
              </li>
              <li>
                <label for='url'>URL:</label>
                <input type='text' name='url' id='url' size='50' value='<%=Tool.checkNull(vo.getUrl())%>'>
              </li>
              <li>
                <label for='content'>설명:</label>
                <input type='text' name='content' id='content' size='50' value='<%=vo.getContent()%>'>
              </li>
               <li>
                <label for='rname'>이름:</label>
                <input type='text' name='rname' id='rname' size='10' value='<%=vo.getRname()%>'>
                
                <label for='email'>이메일:</label>
                <input type='email' name='email' id='email' size='16' value='<%=vo.getEmail()%>'>
                
                <label for='passwd'>패스워드:</label>
                <input type='password' name='passwd' id='passwd' size='5' value=""><br><br>
              </li>
              
              <li>
                <button type="submit">등록</button>
                <button type="button" onclick="location.href='./list.jsp'">목록</button>
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