<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
  request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!--  -->
<jsp:include page="./menu/top.jsp" flush='false'/> 
<!--  -->
<seciton>
  <div class='content'>
    <form name='frm' method='post' action='./create_proc.jsp' enctype='multipart/form-data'>
      <fieldset>
        <ul>
          <li>
            <label for='title'>제목:</label>
            <input type='text' name='title' id='title' size='50' value='팔공산'>
          </li>
          <li>
            <label for='url'>URL:</label>
            <input type='text' name='url' id='url' size='50' value='http://www.naver.com'>
          </li>
           <li>
            <label for='file1'>참고 파일:</label>
            <input type='file' name='file1' id='file1' size='50' >
          </li>
          <li>
            <label for='content'>이미지파일 설명:</label>
            <input type='text' name='content' id='content' size='50' value='파일 업로드 게시판'>
          </li>
           <li>
            <label for='rname'>이름:</label>
            <input type='text' name='rname' id='rname' size='10' value='홍길동'>
            
            <label for='email'>이메일:</label>
            <input type='email' name='email' id='email' size='25' value='mail@naver.com'>
            
            <label for='passwd'>패스워드:</label>
            <input type='password' name='passwd' id='passwd' size='5' >
          </li>
          
          <li>
            <button type="submit">등록</button>
            <button type="button" onclick="location.href='./list2.jsp'">목록</button>
          </li>
        </ul>
      </fieldset>
    </form>
  </div>
</seciton>
<!--  -->
<jsp:include page="/menu/footer.html" flush='false'/> 
<!--  -->
</body>
</html>