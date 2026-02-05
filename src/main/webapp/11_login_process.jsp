<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.sql.*" %>
<%!
	Connection conn = null;
	PreparedStatement ps = null;
	String url = "jdbc:mariadb://localhost:3306/jsp";
	String user = "root";
	String password = "1111";
%>   

<!DOCTYPE html>
<html>
<head>
<title>Implicit Objects: 페이지 이동방식 확인</title>
</head>
<body>
	<jsp:useBean id="usersVO" class="com.dto.UsersVo" />	
	<jsp:setProperty property="*" name="usersVO" />

<%

int resultcnt = 0;
boolean result = false;
ResultSet rs = null;

		 
	String sql = "select * from users where uid=? and upw=?";	 
	
	try {
		Class.forName("org.mariadb.jdbc.Driver");
		conn = DriverManager.getConnection(url, user, password);

		ps = conn.prepareStatement(sql);
		ps.setString(1, usersVO.getUid());
		ps.setString(2, usersVO.getUpw());
		
		rs = ps.executeQuery(); //정상 작동 1반환
		
		if(rs.next()){
			String uid = rs.getString("uid");
			String upw = rs.getString("upw");
			
			out.print( " 회원명 :" + uid + "<br>");

			
		}else{
			System.out.println("일치하는 회원정보가 없습니다." );
		}

	} catch (Exception e) {
		out.print("에러 발생");
		e.printStackTrace();
	} finally {
		try {
			if(ps !=null){if(!ps.isClosed()) ps.close();}
			if(conn !=null){if(!conn.isClosed()) conn.close();}
		} catch (Exception e) {}

	}
	
	request.setCharacterEncoding("utf-8");
	 String userid = request.getParameter("uid");
	 String password = request.getParameter("upw");

    if (userid.equals("cmsnet") && password.equals("Dasom1234!")) {
//         response.sendRedirect("06_03_login_success.jsp");

        out.print( "로그인 성공");

    } else {

    	 out.print( "로그인 실패");
//          pageContext.forward("./06_03_login_failed.jsp");
    }
%>

</body>
</html>
