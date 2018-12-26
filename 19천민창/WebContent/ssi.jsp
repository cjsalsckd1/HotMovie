<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="org.apache.commons.fileupload.*" %>
<%@ page import ="pds3.*" %>
<%@ page import ="java.util.ArrayList" %>
<%@ page import = "tool.*" %>

<% request.setCharacterEncoding("utf-8"); %>
<%
  PdsDAO pdsDAO = new PdsDAO();
%>
<%
//개발시 최상위 경로 : /pds_v3jc
//서비스 최상위 경로 :/ -->
String root = request.getContextPath();

//검색 컬럼 및 검색어 추출 -->
String col = Tool.checkNull(request.getParameter("col"));
String word = Tool.checkNull(request.getParameter("word"));

int nowPage=1;
if(request.getParameter("nowPage")!=null){
 nowPage = Integer.parseInt(request.getParameter("nowPage")); 
}
%>