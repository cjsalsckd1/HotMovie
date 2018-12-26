<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/style.css" type="text/css" />
<script type="text/javascript">
	function passwd_p(){
	  var reg_passwd= /^[^\s]{4, 20}$/; 		//공백을 제외한 모든 문자, 4~20자
	  //console.log('-->:' + '1234'.search(reg_passwd));
	  if(var('passwd').search(reg_passwd)==1){
	    id('passwd_panel').style.color='#FF0000";
	    id('passwd_panel').innerHTML = '사용할 수 없는 패스워드입니다.'
	    return false;
	  }else{
	    id('passwd_panel').style.color="#0000FF";
	    id('passwd_panel').innerHTML = "사용할 수 없는 패스워드입니다."
	    return true;
	  }
	  //id('passwd_panel').innerHTML = val('passwd');
	}
	
	function email_duplicate(){
	  var reg_email=/^[A-Za-z0-9_]+[-A-Za-z0-9_.]*{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{2.5}$/;
	  /*
	  - //: 정규 표현식 시작과 종료
	  - ^[A-Za-z0-9_] : 알파벳이나 숫자로 시작
	  - + : 1번 이상 반복되어야함.
	  - [-A-Za-z0-9_.] : 하이픈, 알파벳, 숫자, 언더바, 점 입력 가능
	  - * : 0번 이상 반복되어야 함
	  - [@]{1} : 1번 이상 입력되어야함.
	  - [-A-Za-z0-9_]+ : 하이픈 또는 알파벳 또는 숫자가 1회이상 입력되어야 함
	  - [-A-Za-z0-9_.]* : 하이픈 또는 알파벳 또는 숫자가 1회이상 입력되어야함
	  - [.]{1} : 점이 1회 입력되어야함
	  - [A-Za-z]{2,5}$ : 마지막으로 알파벳이 2에서 5자 입력되어야함
	  
	  [참고]
	  ?: 존재하지 않거나 1번만 입력 가능
	  */
	  
	  //console.log : 브라우저의 console 에 출력, Chrome 에서 F12
	  //console.log('-->frm.email_dns.selectedIndex : ' + frm.email_dns.selectedIndex)
	  var email_dns="";
	  f(frm.email_dns.selectedIndex==0){//직접입력
	    email_dns = document.getElementById("email").value;
	  }else{
	    var email_dns = document.getElementById("email").value + '@' + document.getElementById("email_dns").value;
	  }
	  
	  if(email_dns.search(reg_email)==-1){
	    alert("이메일 형식이 일치하지 않습니다.");
	    document.getElementById("email").focus();
	    return false;		//실행 중지
	  }
	  
	  var url = './email_proc.jsp?email='+email_dns;
	  var win = window.open(url, "중복 이메일 검사", "width=500px, height=440px, scrollbars=no");
	  
	  var x = (screen.width - 500)/2;
	  var y = (screen.height - 440)/2;
	  
	  win.moveTo(x, y);	//화면 이동	  
	}
	function send(){
	  if(frm.passwd.value!=frm.repasswd.value){
	    frm.passwd.focus();
	    var str = "패스워드가 일치하지 않습니다.";
	    document.getElementById("passwd_panel").innerHTML=str;
	    return false;	//서브밋 중지
	  }
	  return true;	//서브밋 진행
	}
</script>
</head>
<!-- -------------------------------- -->
<body leftmargin="0" topmargin="0">
<jsp:include page="/menu/top.jsp" flush="false" />
<!-- -------------------------------- -->

<div class="content">
  <form action="./create_proc.jsp" name="frm" method="post" onsubmit="return send();">
    <fieldset>
      <legend class="legend">관리자 등록</legend>
      <ul>
        <li>
          <label for="email" class="label">이메일</label>
          <input type="email" name="email" id="email" required="required" value="test" />
          <select id="email_dns">
            <option value="none">직접 입력</option>
            <option value="gmail.com">gmail.com</option>
            <option value="daum.net">daum.net</option>
            <option value="naver.com">naver.com</option>
            <option value="nate.com">nate.com</option>
            <option value="hotmail.com">hotmail.com</option>
          </select>
          <span class="link"><a href="javascript:email_duplicate();">이메일 중복 검사</a></span>
        </li>
        <li>
          <label for="passwd" class="label">패스워드</label>
          <input type="password" name="passwd" id="passwd" value="1234" />
          <label for="passwd" class="label">패스워드 확인</label>
          <input type="password" name="repasswd" id="repasswd" value="1234" />
          <br>
          <span id="passwd_panel" style="color: #FF0000; margin-left: 80px;"></span>
        </li>
        
        <li class="center">
          <button type="submit">등록</button>
          <button type="button" onclick="history.back();">취소</button>
        </li>
      </ul>
    </fieldset>
  </form>
</div>
<!-- ----------------------------- -->
<jsp:include page="/menu/footer.html" flush="false" />
</body>
<!-- ----------------------------- -->
</html>