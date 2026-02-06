<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // 세션에서 로그인된 사용자 ID 확인
    String loginId = (String) session.getAttribute("loginID");
    boolean isAdmin = "admin".equals(loginId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
<style>
    body {
        font-family: 'Malgun Gothic', sans-serif;
        margin: 40px;
        background: #f5f5f5;
    }
    h2 {
        color: #333;
        border-bottom: 2px solid #4CAF50;
        padding-bottom: 10px;
    }
    .access-denied {
        color: #d32f2f;
        font-size: 18px;
        padding: 20px;
        background: #ffebee;
        border-radius: 8px;
        text-align: center;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        background: #fff;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        border-radius: 8px;
        overflow: hidden;
    }
    th {
        background: #4CAF50;
        color: white;
        padding: 12px 15px;
        text-align: center;
    }
    td {
        padding: 10px 15px;
        text-align: center;
        border-bottom: 1px solid #eee;
    }
    tr:hover {
        background: #f1f8e9;
    }
    .badge-y { color: #2e7d32; font-weight: bold; }
    .badge-n { color: #d32f2f; font-weight: bold; }
    .count {
        margin: 10px 0;
        color: #666;
    }
</style>
</head>
<body>

<h2>📋 회원 목록</h2>

<%
    if (!isAdmin) {
%>
    <div class="access-denied">
        ⚠️ 관리자(admin)만 접근할 수 있습니다.<br>
        현재 로그인: <%= (loginId != null) ? loginId : "로그인 안됨" %>
    </div>
<%
    } else {
        // DB 연결 및 회원 조회
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count = 0;

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            conn = DriverManager.getConnection(
                "jdbc:mariadb://localhost:3306/jsp", "root", "1234"
            );

            String sql = "SELECT uid, upw, unm, utel, umail, ubirth, "
                       + "DATE_FORMAT(ustart, '%Y-%m-%d %H:%i') AS ustart, "
                       + "DATE_FORMAT(uend, '%Y-%m-%d %H:%i') AS uend, "
                       + "use_yn, urole "
                       + "FROM users ORDER BY ustart DESC";

            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
%>
    <table>
        <thead>
            <tr>
                <th>No</th>
                <th>아이디</th>
                <th>비밀번호</th>
                <th>이름</th>
                <th>연락처</th>
                <th>이메일</th>
                <th>생년월일</th>
                <th>가입일자</th>
                <th>탈퇴일자</th>
                <th>사용여부</th>
                <th>역할</th>
            </tr>
        </thead>
        <tbody>
<%
            while (rs.next()) {
                count++;
                String useYn = rs.getString("use_yn");
%>
            <tr>
                <td><%= count %></td>
                <td><%= rs.getString("uid") %></td>
                <td><%= rs.getString("upw") %></td>
                <td><%= rs.getString("unm") %></td>
                <td><%= rs.getString("utel") %></td>
                <td><%= rs.getString("umail") %></td>
                <td><%= rs.getString("ubirth") != null ? rs.getString("ubirth") : "-" %></td>
                <td><%= rs.getString("ustart") %></td>
                <td><%= rs.getString("uend") != null ? rs.getString("uend") : "-" %></td>
                <td class="<%= "y".equals(useYn) ? "badge-y" : "badge-n" %>">
                    <%= "y".equals(useYn) ? "사용" : "탈퇴" %>
                </td>
                <td><%= rs.getString("urole") %></td>
            </tr>
<%
            }

            if (count == 0) {
%>
            <tr>
                <td colspan="11" style="padding:30px; color:#999;">등록된 회원이 없습니다.</td>
            </tr>
<%
            }
%>
        </tbody>
    </table>
    <p class="count">총 <strong><%= count %></strong>명의 회원이 조회되었습니다.</p>
<%
        } catch (ClassNotFoundException e) {
%>
            <div class="access-denied">❌ DB 드라이버를 찾을 수 없습니다: <%= e.getMessage() %></div>
<%
        } catch (SQLException e) {
%>
            <div class="access-denied">❌ DB 오류: <%= e.getMessage() %></div>
<%
        } finally {
            if (rs != null) try { rs.close(); } catch(Exception e) {}
            if (pstmt != null) try { pstmt.close(); } catch(Exception e) {}
            if (conn != null) try { conn.close(); } catch(Exception e) {}
        }
    }
%>

</body>
</html>
