<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import = "java.sql.*, javax.sql.*,java.io.*" %>
<html>
<head>
</head>
<body>
<h1>실습데이터 입력</h1> <%-- h1태그 사용 --%>
<%
	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.1:3306/kopo10","root","kopoctc");
	// 192.168.56.1 : 서버 IP주소, 3306 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	
	stmt.execute("insert into examtable values ('나연',209901,95,100,95);"); // 나연 정보 입력
	stmt.execute("insert into examtable values ('정연',209902,95,95,95);"); // 정연 정보 입력
	stmt.execute("insert into examtable values ('모모',209903,100,100,100);"); // 모모 정보 입력
	stmt.execute("insert into examtable values ('사나',209904,100,95,90);"); // 사나 정보 입력
	stmt.execute("insert into examtable values ('지효',209905,80,100,70);"); // 지효 정보 입력
	stmt.execute("insert into examtable values ('미나',209906,100,100,70);"); // 미나 정보 입력
	stmt.execute("insert into examtable values ('다현',209907,70,70,70);"); // 다현 정보 입력
	stmt.execute("insert into examtable values ('채영',209908,80,75,75);"); // 채영 정보 입력
	stmt.execute("insert into examtable values ('쯔위',209909,75,80,70);"); // 쯔위 정보 입력
	stmt.close(); // 리소스 정리
	conn.close(); // 리소스 정리
%>
</body>
</html>