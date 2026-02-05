<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Enumeration"%>
<!DOCTYPE html>
<html>
<head>
<title>Session</title>
</head>
<body>
	<h4>----- 세션을 삭제하기 전 -----</h4>
	<p>
	<%
		String name;
		String value;

		Enumeration en = session.getAttributeNames(); //"userID", "userPW"
		int i = 0;

		while (en.hasMoreElements()) {
			i++;
// 			name = en.nextElement().toString(); //비권장방식
			name = (String) en.nextElement(); //권장방식 "userID" => "userPW"
			value = session.getAttribute(name).toString(); // "admin" => "1234"
			out.println("설정된 세션 이름 [ %d ] : %s<br>".formatted(i, name));
			out.println("설정된 세션 값 [ %d ] : %s<br>".formatted(i, value));
		}

		session.removeAttribute("userID");
	%>
	</p>
	<h4>----- 세션을 삭제한 후 -----</h4>
	<p>
	<%
		en = session.getAttributeNames(); // "userPW"

		i = 0;
		while (en.hasMoreElements()) {
			i++;
			name = en.nextElement().toString(); //"userPW"
			value = session.getAttribute(name).toString(); //"1234"
			out.println("설정된 세션 이름 [ " + i + " ] : " + name + "<br>");
			out.println("설정된 세션 값 [ " + i + " ] : " + value + "<br>");
		}
	%>
	</p>
</body>
</html>
