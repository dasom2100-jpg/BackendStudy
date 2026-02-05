<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Session</title>
</head>
<body>
	<h4>----- 세션 유효 시간 변경 전 -----</h4>
	<%
		//세션 기본값  1,800초(30분)
		//세션의 유효시간을 0이나 음수로 설정하면 세션 유효시간이 없는 상태가 됨.
		//이 상태에서 세션 제거를 하지 않고 종료되면 웹서버에서 세션이 제거 되지 않고 유지됨.
		int time = session.getMaxInactiveInterval() / 60;

		out.println("세션 유효 시간  : " + time + "분<br>");
	%>
	<h4>----- 세션 유효 시간 변경 후 -----</h4>
	<%
		//세션 유효시간 설정 60초=1분 설정
		//유효시간 이후 세션 자동 만료됨
		session.setMaxInactiveInterval(60);
		time = session.getMaxInactiveInterval() / 60;

		out.println("세션 유효 시간  : " + time + "분<br>");
	%>
</body>
</html>








