<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<% System.out.println(pageContext.getRequest().getServletContext().getContextPath()); %>
<link rel="stylesheet" href="${pageContext.request.servletContext.contextPath}/css/login.css">

</head>

<body>
<%
String id = (String) session.getAttribute("loginID");
String nm = (String) session.getAttribute("loginNM");
if(id == null){
	out.print("<div class=\'nav_wrap\'>");
	out.print("<button class='btn_link' onclick=\"location.href=\'11_login.jsp\';\">로그인</button><br>");
	out.print("</div>");
}else{
	out.print("<div class=\'nav_wrap\'>");
	out.print("%s님, 안녕하세요. <br>".formatted(nm) );	
	out.print("<button class='btn_link' onclick=\"location.href=\'11_session_logout.jsp\';\">로그아웃</button><br>");
	out.print("</div>");
}

if(id != null ){
	
	if(id.equals("admin")){ %>
	<div class='menu_wrap'>
		<a href="">상품등록</a>
		<a href="">회원등록</a>
		<a href="">상품목록</a>
		<a href="11_userList.jsp">회원목록</a>
	</div>
	<%}else{ %>
	<div class='menu_wrap'>
		<a href="11_myinfo.jsp">내정보보기</a>
		<a href="">장바구니</a>
		<a href="">찜리스트</a>
	</div>
	<%}
	
}else{
	out.print("<div class='cont_box'>");
	out.print("	로그인 되기전 메인화면 입니다.<br>");
	out.print("</div>");
}
%>

</body>
</html>











