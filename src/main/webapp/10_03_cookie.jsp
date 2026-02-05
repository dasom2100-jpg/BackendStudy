<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	
	
	
	
	Cookie[] cookies = request.getCookies();
	
	String username = null;
	if (cookies != null){
		for (Cookie cookie : cookies){
			if(cookie.getName().equals("userName")){
				username = cookie.getValue();
				break;
			}
		}
	}
	
	
	if(username !=null) {
		out.print("환영합니다." + username+ "님");
		
		for (int i = 0; i < cookies.length; i++) {
		    //쿠키삭제
		    cookies[i].setMaxAge(0);
		    response.addCookie(cookies[i]);
		}
		
		response.sendRedirect("10_02_cookie.jsp");
		
		
	}else {
		
		out.print("저장된 사용자 정보가 없습니다." + "<br>" );
	}
	
	
	
	%>
	
</body>
</html>