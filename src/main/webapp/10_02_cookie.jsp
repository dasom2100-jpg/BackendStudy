<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Cookie</title>
</head>
<body>
	<%
	Cookie[] cookies = request.getCookies();
	if (cookies != null) {
		out.println("현재 설정된 쿠키의 개수 => " + cookies.length + "<br>");
		out.println("==========================<br>");
		for (int i = 0; i < cookies.length; i++) {
			out.println("설정된 쿠키의 속성 이름 [ %d ]: %s<br>".formatted(i, cookies[i].getName()));
			out.println("설정된 쿠키의 속성 값  [ %d ]: %s<br>".formatted(i, cookies[i].getValue()));
			out.println("---------------------------------------------<br>");
		}
	} else {
		out.print("쿠키가 없습니다.");
	}
	%>
</body>
</html>