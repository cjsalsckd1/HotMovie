<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp" %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Email_Form</title>
  </head>

  <body leftmargin="0" topmargin="0">
        <div class='content'>
            <form name='frm' method='post' action='./email_proc.jsp'>
                <fieldset class='fieldset'>
                    <legend class='legend'>관리자 등록  - Email 중복 확인</legend>
                    <ul>
                        <li>
                            <label class='label' for='email'>이메일</label>
                            <input type='email' name='email' id='email' required='required' value='test1@mail.com'>
                        </li>
                        <li class='center'>
                            <button type='submit'>중복 조회</button>
                            <button type='button' id='close' onclick='window.close();'>닫기</button>
                        </li>
                    </ul>
                </fieldset>
            </form>
        </div>
  </body>
</html>