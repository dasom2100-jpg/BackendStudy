<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<% System.out.println(pageContext.getRequest().getServletContext().getContextPath()); %>
<link rel="stylesheet" href="${pageContext.request.servletContext.contextPath}/css/login.css">
<style>
table{ border-collapse : collapse;}
table, td, th {border : 1px solid #555;}
td, th {padding: 5px 10px;}
</style>
</head>
<body>
<%
String keyword = request.getParameter("keyword")==null ? "" :request.getParameter("keyword");

String loginID = (String) session.getAttribute("loginID");
if(loginID == null){
	out.print("회원로그인 후 이용이 가능합니다.");
	out.print("<a href='11_login.jsp'>로그인하러가기</a>");
}else{
%>
<div id="ADMIN_userList">

<h1 style="text-align:center;">회원목록</h1>
<div class="nav_wrap">
	
	
	<form>
		<input type="search" placeholder="이름이나 아이디를 입력하세요(일부가능)" name="keyword">
		<input type="submit" value="검색">
	</form>
	</div>
	<div class="nav_wrap">
 	<table>
		<tr>
			<th>아이디</th>
			<th>비밀번호</th>
			<th>이름</th>
			<th>연락처</th>
			<th>이메일</th>
			<th>생년월일</th>
			<th>가입일자</th>
			<th>탈퇴일자</th>
			<th>역할</th>
		</tr>
		<%
		String sql ="select * from users where 1=1 ";
		if(keyword != null) sql += " and uid like concat('%',?,'%') or unm like concat('%',?,'%') ";
		sql +="order by unm";
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try{
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(
					"jdbc:mariadb://localhost:3306/jsp", 
					"root", 
					"1111"
			);
			stmt = conn.prepareStatement(sql);
			if(keyword != null) {
				stmt.setString(1, keyword);
				stmt.setString(2, keyword);
			}
			rs = stmt.executeQuery();
			//테이블에 데이터를 행수만큼 반복해서 가져옴.
			if(rs.next()){
				do{ %>
					<!-- 데이터베이스의 정보에 따라 반복할 행(시작) -->
				<tr>
					<td><%=rs.getString("UID") %></td>
					<td><%=rs.getString("UPW") %></td>
					<td><%=rs.getString("UNM") %></td>
					<td><%=rs.getString("UTEL") %></td>
					<td><%=rs.getString("UMAIL") %></td>
					<td><%=rs.getString("UBIRTH")!=null ? rs.getString("UBIRTH") : "" %></td>
					<td><%=rs.getString("USTART")!=null ? rs.getString("USTART").replace("-","").substring(0,8) : ""  %></td>
					<td><%=rs.getString("UEND")!=null ? rs.getString("UEND").replace("-","").substring(0,8) : ""   %></td>
					<%
					String role =rs.getString("UROLE");
					String roleStr = "";
					if(role.equals("super")){
						roleStr = "최고관리자";
					}else if(role.equals("sub")){
						roleStr = "중간관리자";
					}else{
						roleStr = "사용자";
					}
					
					%>
					<td><%=roleStr%></td>
				</tr>
				<!-- 데이터베이스의 정보에 따라 반복할 행(끝) -->
				<%}while(rs.next());
			
			}else{ %>
				<tr><td colspan="9">일치하는 정보가 존재하지 않습니다.</td></tr>
			<%}
				
		}catch(Exception e){
			out.print("에러 발생");
		}finally{
			//객체들 close
		}
		
		%>
		
	</table>
	</div>
	
	<div class="nav_wrap">
		<a href="11_session_main.jsp" class="btn_link">홈으로</a>
	</div>
</div>
<%} %>
</body>
</html>