<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp" %>
<% request.setCharacterEncoding("utf-8"); %>

<%
  String email = request.getParameter("email");  
%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title></title>
    
    <link href="../css/style.css" rel="Stylsheet" type="text/css">
    <script type="text/javascript" src="../js/tool.js"></script>
    <script type="text/javascript">
    	function use() {
    	    opener.document.frm.email.value='<%=email%>';
    	    window.close();
    	}
    </script>
  </head>

  <body leftmargin="0" topmargin="0">
        <div class='content'>
            <form name='frm' method='post' action='./.jsp'>
                <fieldset class='fieldset'>
                    <legend class='legend'>관리자 등록 - 중복 Email 검사 결과</legend>
                    <ul>
                        <li class='center'>
                            <%
                                int count = admin1DAO.emailCount(email);
                                out.println("Email : " + email + "<br><br>");
                                if(count == 0) {
                                    out.println("중복되지 않았습니다. <br>사용 가능합니다.");   
                                }
                                else {
                                	out.println("이메일이 중복됩니다.");
                                }
                            %>
                        </li>
                        <li class='center'>
                            <%
                                if(count == 0) {                                    
                            %>      
                                    <span class='link'><a href='javascript: use()'>사용</a></span> |
                                    <span class='link'><a href='./email_form.jsp'>다시 검사</a></span> |
                                    <span class='link'><a href='javascript: window.close()'>닫기</a></span>
                            <%     
                                }
                                else {
                            %>
                                    <span class='link'><a href='./email_form.jsp'>다시 검사</a></span> |
                                    <span class='link'><a href='javascript: window.close()'>닫기</a></span>
                            <%        
                                }
                            %>
                        </li>
                    </ul>
                </fieldset>            
            </form>
        </div>
  </body>
</html>