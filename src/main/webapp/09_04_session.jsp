<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Session</title>
</head>
<body>
	<h4>----- 세션을 삭제하기 전 -----</h4>
	<p>
	<%
		String user_id = (String) session.getAttribute("userID");//"admin"(Object,String)
		String user_pw = (String) session.getAttribute("userPW"); //"1234"(Object,String)
		out.println("설정된 세션 이름 userID : " + user_id + "<br>");
		out.println("설정된 세션 값 userPW : " + user_pw + "<br>");

		//단일 세션 삭제
		session.removeAttribute("userID");
	%>
	</p>
	<h4>----- 세션을 삭제한 후 -----</h4>
	<p>
	<%
		user_id = (String) session.getAttribute("userID"); //null
		user_pw = (String) session.getAttribute("userPW");
		out.println("설정된 세션 이름 userID : " + user_id + "<br>");
		out.println("설정된 세션 값 userPW : " + user_pw + "<br>");
	%>
	</p>
</body>
</html>




