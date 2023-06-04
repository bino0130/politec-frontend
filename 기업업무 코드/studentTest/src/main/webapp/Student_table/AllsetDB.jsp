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
    
 	// 학번 데이터가 존재하는지 확인
    String searchID = "SELECT MAX(studentid) FROM anotherTwice";
    ResultSet rset = stmt.executeQuery(searchID);
    rset.next();
    int maxID = rset.getInt(1);
    // 시작 학번 설정
    int startID = 0;
    if (maxID > 0) {
        startID = maxID;
    } else {
        startID = 209900;
    }
    
    for (int i = startID + 1; i < startID + 301; i++) {
        String name = "홍길" + (i - 209900);
        int id = i;
        int kor = (int) (Math.random() * 100) + 1;
        int eng = (int) (Math.random() * 100) + 1;
        int mat = (int) (Math.random() * 100) + 1;
        
        String insertQuery = "INSERT INTO anotherTwice VALUES ('" + name + "', " + id + "," + kor + ", " + eng + ", " + mat + ");";
        stmt.executeUpdate(insertQuery);
    }
    
    stmt.close();
    conn.close();
} catch (ClassNotFoundException | SQLException e) {
    e.printStackTrace();
}
%>


</body>
</html>