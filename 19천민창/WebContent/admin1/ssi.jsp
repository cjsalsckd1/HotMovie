<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="tool.*" %>
<%@ page import="pds3.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%
  Admin1DAO admin1DAO = new Admin1DAO();
%>

<%
//프로젝트 경로 자동 추출. Context root 명 자동 추출
String root = request.getContextPath();

//검색 컬럼 및 검색어 추출
String col = request.getParameter("col");
if(col==null){
 col=""; 
}else{
 col= col.trim(); 
}

String word = request.getParameter("word");
if(word==null){
 word="";
}else{
 word=word.trim(); 
}

int nowPage=1;  //현재 페이지

if(request.getParameter("nowPage")!=null){
 nowPage = Integer.parseInt(request.getParameter("nowPage")); 
}
%>