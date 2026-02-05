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
		String user_id = (String) session.getAttribute("userID"); //"admin"
		String user_pw = (String) session.getAttribute("userPW"); //"1234"

		out.println("설정된 세션 이름 userID : " + user_id + "<br>");
		out.println("설정된 세션 값 userPW : " + user_pw + "<br>");

		if (request.isRequestedSessionIdValid() == true) {
			out.print("세션이 유효합니다.");
		} else {
			out.print("세션이 유효하지 않습니다.");
		}
		//다중 세션삭제 // 세션의 해당 클라이언트의 브라우저와 연결된 jsession값의 연결을 끊어버림 
		session.invalidate(); // 로그아웃 기능
		%>
	</p>
	<h4>----- 세션을 삭제한 후 -----</h4>
	<p>
		<%
		if (request.isRequestedSessionIdValid() == true) {
			out.print("세션이 유효합니다.");
		} else {
			out.print("세션이 유효하지 않습니다.");
		}
		%>
	</p>
</body>
</html>