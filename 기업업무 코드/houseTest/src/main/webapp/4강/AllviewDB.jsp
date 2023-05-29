<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import = "java.sql.*, javax.sql.*,java.io.*" %>
<html>
<head>
<style>
	td { /* td 셀렉터 : td 태그에 너비 50px로 설정 */
		width = 50px;
	}
	p { /* p 셀렉터 : p 태그에 align center 설정 */
		align = center;
	}
</style>
</head>
<body>
<h1>조회</h1> <%-- h1태그 사용 --%>
<%
	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.1:3306/kopo10","root","kopoctc");
	// 192.168.56.1 : 서버 IP주소, 3306 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	ResultSet rset = stmt.executeQuery("select * from examtable;");
	// 해당 쿼리를 실행하기 위해 executeQuery를 호출하고 그 결과를 rset에 저장한다.
%>
<table cellspacing=1 width=600px border=1px solid black>
<%-- cellspacing=1, 너비 600px. border : 1px solid black인 테이블 생성 --%>
	<tr> <%-- table row --%>
		<td><p>이름</p></td> <%-- 이름 --%>
		<td><p>학번</p></td> <%-- 학번 --%>
		<td><p>국어</p></td> <%-- 국어 --%>
		<td><p>영어</p></td> <%-- 영어 --%>
		<td><p>수학</p></td> <%-- 수학 --%>
	</tr>
<%
	while(rset.next()){ // rset이 있으면
		out.println("<tr>"); // tr
		out.println("<td><p><a href='OneviewDB.jsp?key=" + // OneviewDB.jsp로 연결하는 a태그
		rset.getString(1) + "'>" + rset.getString(1) + "</a></p></td>"); // 이름 출력
		out.println("<td><p>"+Integer.toString(rset.getInt(2))+"</p></td>"); // 학번 출력
		out.println("<td><p>"+Integer.toString(rset.getInt(3))+"</p></td>"); // 국어점수 출력
		out.println("<td><p>"+Integer.toString(rset.getInt(4))+"</p></td>"); // 영어점수 출력
		out.println("<td><p>"+Integer.toString(rset.getInt(5))+"</p></td>"); // 수학점수 출력
		out.println("</tr>"); // /tr
	}
	rset.close(); // 리소스 정리
	stmt.close(); // 리소스 정리
	conn.close(); // 리소스 정리
%>
</table>
</body>
</html>