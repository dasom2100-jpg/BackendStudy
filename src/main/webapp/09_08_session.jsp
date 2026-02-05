<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*" %>
<!DOCTYPE html><html><head><title>Session</title></head>
<body>
	<%
		String session_id = session.getId();
		out.println("세션 아이디 : " + session_id + "<br>");
		
		
		Date date = null;
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");

		long start_time = session.getCreationTime();
		out.print("세션이 생성된 시간(long자료형의 값) : "+ start_time + "<br>");
		
		date = new Date(start_time);
		out.println("세션이 생성된 시간  : " + sdf.format(date) + "<br>");
		
		long last_time = session.getLastAccessedTime();
		date = new Date(last_time);
		out.println("세션에 마지막으로 접근한 시간 : " + sdf.format(date) + "<br>");

		long used_time = (last_time - start_time) / 60000;
		out.println("웹 사이트에서 경과 시간  : " + used_time + "<br>");
	%>
</body>
</html>