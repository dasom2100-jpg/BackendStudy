<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Enumeration"%>
<!DOCTYPE html>
<html>
<head>
<title>Session</title>
</head>
<body>
	<%
		String name;
		String value;

		/*
		session.getAttributeNames(); => "userID" , "userPW"
		
		*/
// 		Enumeration en = session.getAttributeNames();
		Enumeration<String> en = session.getAttributeNames();
		int i = 0;

		while (en.hasMoreElements()) {
			i++; // 2
			name = en.nextElement(); //"userID" -> "userPW"
// 			name = (String) en.nextElement();
			value = (String) session.getAttribute(name); //"admin" -> "1234"
			out.println("설정된 세션의 속성 이름 [ " + i + " ] : " + name + "<br>");
			out.println("설정된 세션의 속성 값 [ " + i + " ] : " + value + "<br>");
		}
	%>
</body>
</html>