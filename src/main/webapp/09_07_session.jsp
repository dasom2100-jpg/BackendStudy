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
		//브라우저가 켜져 있는 동안의 세션 기본값  1,800초(30분)
		//세션의 유효시간을 0이나 음수로 설정하면 세션 유효시간이 없는 상태가 됨.
		//브라우저가 켜져 있는 동안에는 세션의 유효시간이 적용되나
		//브라우저가 꺼지면 유효시간이 만료되지 않아도 적용되지 않음.
		//(보안정책이 높아지면서 세션 유지시간은 브라우저가 켜져있는 시간까지로만 변경됨.)
		int time = session.getMaxInactiveInterval() / 60;

		out.println("세션 유효 시간  : " + time + "분<br>");
	%>
	<h4>----- 세션 유효 시간 변경 후 -----</h4>
	<%
		//세션 유효시간 설정 60초=1분 설정
		//유효시간 이후 세션 자동 만료됨
		session.setMaxInactiveInterval(5);
		time = session.getMaxInactiveInterval() / 60;

		out.println("세션 유효 시간  : " + time + "분<br>");
	%>
</body>
</html>








