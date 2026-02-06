<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Cookie</title>
</head>
<body>
	<%
	String pid = request.getParameter("pid");
	String pnm = request.getParameter("pnm");

	//쿠키 객체 생성
	Cookie cook_pid = new Cookie("cook_pid", pid);
	Cookie cook_pnm = new Cookie("cook_pnm", pnm);
	//응답객체에 쿠키 추가(클라이언트 브라우저에 저장)
	response.addCookie(cook_pid);
	response.addCookie(cook_pnm);
	
	out.println("쿠기 생성이 성공했습니다<br>");
	out.println("상품번호: "+ pid + "<br>");
	out.println("상품명: "+ pnm + "<br>" );
	%>
</body>
</html>