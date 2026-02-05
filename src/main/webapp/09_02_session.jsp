<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Session</title>
</head>
<body>
	<%
	/*
	session.getAttribute("userID")값이 null인경우
	null.toString();
	(String) null;
	*/
		String user_id = (String) session.getAttribute("userID");
		String user_pw = (String) session.getAttribute("userPW");

		out.println("설정된 세션의 속성 값 [1] : " + user_id + "<br>");
		out.println("설정된 세션의 속성 값 [2] : " + user_pw);
	%>
</body>
</html>