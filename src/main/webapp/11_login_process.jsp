<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인 처리</title>
    <style>
        body {
            font-family: 'Malgun Gothic', sans-serif;
            padding: 40px;
            background: #f5f6fa;
        }
        .result-box {
            background: white;
            border-radius: 10px;
            padding: 30px;
            max-width: 500px;
            margin: 0 auto;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .success {
            color: #27ae60;
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .error {
            color: #e74c3c;
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .info {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            margin-top: 20px;
        }
        .info p {
            margin: 10px 0;
            color: #333;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="result-box">
        <jsp:useBean id="usersVO" class="com.dto.UsersVo" />
        <jsp:setProperty property="*" name="usersVO" />

        <%
            // 한글 인코딩 설정 (가장 먼저!)
            request.setCharacterEncoding("UTF-8");
            
            // 로그인 결과 변수
            boolean loginSuccess = false;
            String userName = "";
            String errorMessage = "";
            
            // DB 연결 정보
            String url = "jdbc:mariadb://localhost:3306/jsp";
            String dbUser = "root";
            String dbPassword = "1111";
            
            // 지역 변수로 선언 (중요!)
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            
            // 입력값 검증
            String uid = usersVO.getUid();
            String upw = usersVO.getUpw();
            
            // null 체크 및 빈 문자열 체크
            if (uid == null || upw == null || uid.trim().isEmpty() || upw.trim().isEmpty()) {
                errorMessage = "아이디와 비밀번호를 모두 입력해주세요.";
            } else {
                try {
                    // 1. 드라이버 로드
                    Class.forName("org.mariadb.jdbc.Driver");
                    
                    // 2. DB 연결
                    conn = DriverManager.getConnection(url, dbUser, dbPassword);
                    
                    // 3. SQL 쿼리 준비
                    String sql = "SELECT uid, upw, unm, utel, umail, ubirth FROM users WHERE uid=? AND upw=?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, uid);
                    ps.setString(2, upw);
                    
                    // 4. 쿼리 실행
                    rs = ps.executeQuery();
                    
                    // 5. 결과 처리
                    if (rs.next()) {
                        // ✅ 로그인 성공
                        loginSuccess = true;
                        userName = rs.getString("unm");
                        
                        // VO에 전체 정보 설정
                        usersVO.setUid(rs.getString("uid"));
                        usersVO.setUpw(rs.getString("upw"));
                        usersVO.setUnm(rs.getString("unm"));
                        usersVO.setUtel(rs.getString("utel"));
                        usersVO.setUmail(rs.getString("umail"));
                        usersVO.setUbirth(rs.getString("ubirth"));
                        
                        // 세션에 저장
                        session.setAttribute("loginUser", usersVO);
                        session.setAttribute("userId", uid);
                        session.setAttribute("userName", userName);
                        
                    } else {
                        // ❌ 로그인 실패
                        errorMessage = "아이디 또는 비밀번호가 일치하지 않습니다.";
                    }
                    
                } catch (ClassNotFoundException e) {
                    errorMessage = "데이터베이스 드라이버를 찾을 수 없습니다.";
                    e.printStackTrace();
                    
                } catch (SQLException e) {
                    errorMessage = "데이터베이스 연결 오류: " + e.getMessage();
                    e.printStackTrace();
                    
                } finally {
                    // 6. 자원 해제 (역순으로!)
                    try {
                        if (rs != null && !rs.isClosed()) rs.close();
                        if (ps != null && !ps.isClosed()) ps.close();
                        if (conn != null && !conn.isClosed()) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        %>
        
        <!-- 결과 출력 -->
        <% if (loginSuccess) { %>
            <div class="success">✅ 로그인 성공!</div>
            <p><strong><%=userName%></strong>님, 환영합니다!</p>
            
            <div class="info">
                <h3>회원 정보</h3>
                <p><strong>아이디:</strong> <%=usersVO.getUid()%></p>
                <p><strong>비밀번호:</strong> <%="*".repeat(usersVO.getUpw().length())%></p>
                <p><strong>이름:</strong> <%=usersVO.getUnm()%></p>
                <p><strong>연락처:</strong> <%=usersVO.getUtel() != null ? usersVO.getUtel() : "미등록"%></p>
                <p><strong>이메일:</strong> <%=usersVO.getUmail() != null ? usersVO.getUmail() : "미등록"%></p>
                <p><strong>생년월일:</strong> <%=usersVO.getUbirth() != null ? usersVO.getUbirth() : "미등록"%></p>
            </div>
            
            <a href="main.jsp" class="btn">메인으로 이동</a>
            <a href="logout.jsp" class="btn" style="background: #95a5a6;">로그아웃</a>
            
        <% } else { %>
            <div class="error">❌ 로그인 실패</div>
            <p><%=errorMessage%></p>
            
            <div class="info">
                <p>입력하신 정보:</p>
                <p><strong>아이디:</strong> <%=uid != null ? uid : "미입력"%></p>
                <p><strong>비밀번호:</strong> <%=upw != null ? "*".repeat(upw.length()) : "미입력"%></p>
            </div>
            
            <a href="login.jsp" class="btn">다시 시도</a>
            
        <% } %>
    </div>
</body>
</html>
