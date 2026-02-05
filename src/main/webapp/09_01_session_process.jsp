<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Session</title>
</head>
<body>
	<%
	/*
	요청 : 09_01_session_process.jsp => request
	데이터전송방식 : POST  => Parameter
	"id" = "admin"
	"passwd" = "1234"
	*/
	request.setCharacterEncoding("UTF-8");
	String user_id = request.getParameter("id"); //"admin"
	String user_pw = request.getParameter("passwd"); //"1234"

	if (user_id.equals("admin") && user_pw.equals("1234")) {
		session.setAttribute("userID", user_id);
		session.setAttribute("userPW", user_pw);
		out.println("세션 설정이 성공했습니다<br>");
		out.println(user_id + "님 환영합니다.<br>");
		
		out.print("<a href=\"09_01_session_main.jsp\">메인페이지로 이동</a>");
	} else {
		out.println("세션 설정이 실패했습니다");
	}
	%><br>
	<a href="09_02_session.jsp">세션 확인하기</a>
</body>
</html>










