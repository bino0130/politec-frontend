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
    
    String deleteQuery = "DELETE FROM anotherTwice WHERE studentid > 0;";
    stmt.executeUpdate(deleteQuery);
    
    for (int i = 1; i <= 50; i++) {
        String name = "홍길" + i;
        int id = i;
        int kor = (int) (Math.random()*10) * 10 + 10;
        int eng = (int) (Math.random()*10) * 10 + 10;
        int mat = (int) (Math.random()*10) * 10 + 10;
        
        String insertQuery = "INSERT INTO anotherTwice (name, kor, eng, mat) VALUES ('" + name + "', " + kor + ", " + eng + ", " + mat + ");";
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