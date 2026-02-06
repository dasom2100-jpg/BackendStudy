<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
// 09_01_session_process.jsp에서 오는 로직 처리시
// String id = (String) session.getAttribute("userID");

// 11_login_process.jsp에서 오는 로직 처리시
String id = (String) session.getAttribute("loginID");
String nm = (String) session.getAttribute("loginNM");
if(id == null){
	out.print("<span onclick=\"location.href=\'09_01_session.jsp\';\">로그인</span><br>");
}else{
	out.print("%s님, 안녕하세요. ".formatted(nm));
	out.print("<span onclick=\"location.href=\'09_01_session_logout.jsp\';\">로그아웃</span><br>");
}

if(id != null ){
	if(id.equals("admin")){ %>
		<a href="">상품등록</a>
		<a href="">회원등록</a>
		<a href="">상품목록</a>
		<a href="">회원목록</a>
	<%}else{ %>
		<a href="11_myinfo.jsp">내정보보기</a>
		<a href="">장바구니</a>
		<a href="">찜리스트</a>
	<%}
}else{
	out.print("로그인 되기전 메인화면 입니다.<br>");
}
%>
</body>
</html>











