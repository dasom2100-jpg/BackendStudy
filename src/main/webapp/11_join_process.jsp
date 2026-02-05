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
<title>Form Processing</title>
</head>
<body>
	<jsp:useBean id="usersVO" class="com.dto.UsersVo" />
	<%-- <%@page import="com.dto.UsersVO" %> <% UsersVO usersVO = new UsersVO(); %> --%>
	
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
		//반드시 commit 또는 rollback코드가 존재해야 함. 임시공간에 계속 머물러 있어서
		//차후 실행되는 dml(insert, update, delete)명령이 제대로 실행되지 않을 수 있다.

		ps = conn.prepareStatement(sql);
		ps.setString(1, usersVO.getUid());
		ps.setString(2, usersVO.getUpw());
		ps.setString(3, usersVO.getUnm());
		ps.setString(4, usersVO.getUtel());
		ps.setString(5, usersVO.getUmail());
		ps.setString(6, usersVO.getUbirth() != "" ? usersVO.getUbirth() : null);
		resultcnt = ps.executeUpdate(); //정상 작동 1반환

		if (resultcnt > 0)
			result = true;
		else
			result = false;
		System.out.println("처리한 행 수: " + result);

	} catch (Exception e) {
		out.print("에러 발생");
		try {
			conn.rollback(); //에러가 나면 위에서 setAutoCommit한 놈이 작동 롤백
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