<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection,java.sql.PreparedStatement,java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
<title>Implicit Objects</title>
<% System.out.println(pageContext.getRequest().getServletContext().getContextPath()); %>
<link rel="stylesheet" href="${pageContext.request.servletContext.contextPath}/css/login.css">
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String userid = request.getParameter("uid");
		String userpw = request.getParameter("upw");
		Connection conn= null;
		String sql = "SELECT * FROM USERS WHERE UID= ? AND UPW = ?" ;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try{
			Class.forName("org.mariadb.jdbc.Driver");
			conn= DriverManager.getConnection(
					"jdbc:mariadb://localhost:3306/jsp",
					"root",
					"1111"
					);
		
			ps = conn.prepareStatement(sql);
			ps.setString(1, userid);
			ps.setString(2, userpw);
			rs = ps.executeQuery();
			if(rs.next()){
				//회원 정보가 있는 경우 처리
				session.setAttribute("loginID", rs.getString("UID"));
				session.setAttribute("loginNM", rs.getString("UNM"));
				response.sendRedirect("11_session_main.jsp");

			}else{
				//회원 정보가 없는 경우 처리
				out.print("<div class='cont_box'>");
				out.print("회원 정보가 일치하지 않습니다.<br>");
				String moveStr = "<a href='11_login.jsp' class='btn_link'>로그인으로 돌아가기</a>";
				out.print(moveStr);
				out.print("</div>");
			}
			
		}catch(Exception e){
			out.print("에러발생");
			e.printStackTrace();
		}finally{
			
			try{
				if(rs != null && !rs.isClosed()) rs.close();
				if(ps != null && !ps.isClosed()) ps.close();
				if(conn != null && !conn.isClosed()) conn.close();
			}catch(Exception e){
				out.print("close시 에러 발생");
			}
		}
	%>
</body>
</html>



