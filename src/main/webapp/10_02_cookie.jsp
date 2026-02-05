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
	
// 		String username = null;
// 		if (cookies != null){
// 			for (Cookie cookie : cookies){
// 				if(cookie.getName().equals("userName")){
// 					username = cookie.getValue();
// 					break;
// 				}
				
// 			}
// 		}
		
// 		if(username !=null) {
// 			out.print("환영합니다." + username+ "님");
			
// 		}else {
			
// 			out.print("저장된 사용자 정보가 없습니다." + "<br>" );
// 		}
		
		
		if(cookies != null){
		    out.println("현재 설정된 쿠키의 개수 => " + cookies.length + "<br>");
		    out.println("----------------------------------<br>");
		    for (int i = 0; i < cookies.length; i++){
		        out.println("설정된 쿠키의 속성 이름 [ %d ]: %s<br>".formatted(i, cookies[i].getName()));
		        out.println("설정된 쿠키의 속성 값 [ %d ]: %s<br>".formatted(i, cookies[i].getValue()));
		    }
		    out.println("----------------------------------<br>");
		} else {
		    out.print("쿠키가 없습니다.");
		}
	%>
	
</body>
</html>