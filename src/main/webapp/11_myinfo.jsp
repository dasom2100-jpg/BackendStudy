<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	//세션에 담아놓은 로그인한 아이디가져오기
	// String loginID = (String) session.getAttribute("loginID");
	String sql = "select unm, uid, upw, utel, umail, ubirth from users where uid = ?";
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	try {
		//드라이버 설치
		Class.forName("com.mysql.cj.jdbc.Driver");

		//데이터베이스 연결객체 생성
		String url = "jdbc:mysql://localhost:3306/jsp";
		String username = "root", password = "1111";
		conn = DriverManager.getConnection(url, username, password);

		//명령문 객체 생성
		ps = conn.prepareStatement(sql);
		ps.setString(1, (String) session.getAttribute("loginID"));

		// 명령문 실행 및 ResultSet으로 반환한 데이터 담아오기
		rs = ps.executeQuery();
		if (rs.next()) {
	%>

	<div id="MyInfoBox">
		<h1>내정보보기</h1>
		이름: <input type="text" name="unm" value="<%=rs.getString("UNM")%>"><br>
		아이디 : <input type="text" name="uid" value="<%=rs.getString("UID")%>"><br>
		비밀번호 : <input type="password" name="upw" value="<%="*".repeat(rs.getString("UPW").length())%>"><br> 
		연락처 : <input type="tel" name="utel" value="<%=rs.getString("UTEL")%>"><br>
		이메일 : <input type="email" name="umail" value="<%=rs.getString("UMAIL")%>"><br> 
		생년월일 : <input type="text" name="ubirth" value="<%=rs.getString("UBIRTH")%>"><br>
	</div>


	<%
	}

	} catch (Exception e) {
		//에러처리
		out.print("에러발생");
		e.printStackTrace();
	} finally {
		// rs, ps, conn 닫아주기
		try {
			if (rs != null && !rs.isClosed()) rs.close();
			if (ps != null && !ps.isClosed()) ps.close();
			if (conn != null && !conn.isClosed()) conn.close();
		} catch (Exception e) {
			out.print("close에러 발생");
		}
	}
	%>

</body>
</html>