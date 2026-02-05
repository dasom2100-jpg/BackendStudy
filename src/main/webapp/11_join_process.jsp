<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%!Connection conn = null;
	PreparedStatement ps = null;
	String url = "jdbc:mariadb://localhost:3306/jsp";
	String user = "root";
	String password = "1111";%>
<!DOCTYPE html>
<html>
<head>
<title>Form Processing</title>
</head>
<body>
	<jsp:useBean id="usersVO" class="com.dto.UsersVo" />
	<jsp:setProperty property="*" name="usersVO" />
	<%
	request.setCharacterEncoding("UTF-8");
	String sql = "insert into users (uid, upw, unm, utel, umail, ubirth)";
	sql += "values (?, ?, ?, ?, ?, ?)";

	int resultcnt = 0;
	boolean result = false;
	try {
		Class.forName("org.mariadb.jdbc.Driver");
		conn = DriverManager.getConnection(url, user, password);
		conn.setAutoCommit(false);

		ps = conn.prepareStatement(sql);
		ps.setString(1, usersVO.getUid());
		ps.setString(2, usersVO.getUpw());
		ps.setString(3, usersVO.getUnm());
		ps.setString(4, usersVO.getUtel());
		ps.setString(5, usersVO.getUmail());
		ps.setString(6, usersVO.getUbirth() != "" ? usersVO.getUbirth() : null);
		resultcnt = ps.executeUpdate();

		if (resultcnt > 0)
			result = true;
		else
			result = false;
		System.out.println("처리한 행 수: " + result);

	} catch (Exception e) {
		out.print("에러 발생");
		try {
			conn.rollback();
		} catch (Exception e1) {
		}
		e.printStackTrace();
	} finally {
		try {
			if (result) { conn.commit(); }
			else{conn.rollback();}
			
			if(ps !=null){if(!ps.isClosed()) ps.close();}
			if(conn !=null){if(!conn.isClosed()) conn.close();}
			
		} catch (Exception e) {}

	}
	%>
	
	<p> 아이디 : <%=usersVO.getUid()%></p>
	<p> 비밀번호 : <%=usersVO.getUpw()%></p>
	<p> 비밀번호(표시로 대체 출력) : <%= "*".repeat(usersVO.getUpw().length())%></p>
	<p> 이름 : <%=usersVO.getUnm()%></p>
	<p> 연락처 : <%=usersVO.getUtel()%></p>
	<p> 메일 : <%=usersVO.getUmail()%></p>
	<p> 생년월일 : <%=usersVO.getUbirth()%></p>
	
	
</body>
</html>