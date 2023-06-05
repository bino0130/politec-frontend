<%@page import="com.mysql.cj.Query"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import = "java.sql.*, javax.sql.*,java.io.*" %>
<html>
<head>
</head>
<body>
<h1>트와이스 실습데이터 입력</h1> <%-- h1태그 사용 --%>
<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo10", "root", "kopoctc");
    Statement stmt = conn.createStatement();
    
    String searchID = "SELECT MAX(studentid) FROM anotherTwice"; // anotherTwice테이블의 비어있는 학번, 최대 학번 구하기
    ResultSet rset = stmt.executeQuery(searchID); // 쿼리 실행
    rset.next(); 
    int maxID = rset.getInt(1); // maxID 설정
    // 시작 학번 설정
    int startID = 0; // startID=0으로 초기화
    if (maxID > 0) { // maxiD가 0보다 크면
        startID = maxID; // startID = maxID
    } else { // 값이 없으면
        startID = 209900; // 학번은 209900부터 시작 
    }
    
    for (int i = startID + 1; i < startID + 301; i++) { // 학번이 존재한다면 학번의 최대값 +1부터 300개의 데이터를 입력
        String name = "홍길" + (i - 209900); // 이름은 홍길00
        int id = i; // 학번은 i
        int kor = (int) (Math.random() * 100) + 1; // 국어
        int eng = (int) (Math.random() * 100) + 1; // 영어
        int mat = (int) (Math.random() * 100) + 1; // 수학
        
        // 테이블에 데이터 입력
        String insertQuery = "INSERT INTO anotherTwice VALUES ('" + name + "', " + id + "," + kor + ", " + eng + ", " + mat + ");";
        stmt.executeUpdate(insertQuery); // 쿼리 실행
    }
    
    stmt.close(); // 리소스 누수 방지
    conn.close(); // 리소스 누수 방지
} catch (ClassNotFoundException | SQLException e) { // ClassNotFoundException, SQLException 처리
    e.printStackTrace(); // 에러 출력
}
%>


</body>
</html>