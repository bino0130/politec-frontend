<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import = "java.sql.*, javax.sql.*,java.io.*" %>
<html>
<head>
<style>
	td { /* td 셀렉터 : td 태그에 너비 50px로 설정 */
		width : 50px;
	}
	p { /* p 셀렉터 : p 태그에 align center 설정 */
		align : center;
	}
</style>
</head>
<body>
<%
	String ckey = request.getParameter("key"); // "key"를 parameter로 받는 String변수 ckey 생성
%>
<h1>[<%=ckey%>]조회</h1> <%-- 00 조회 --%>
<table cellspacing=1 width=600 border=1px solid black>
<%-- 테이블 생성 --%>
	<tr> <%-- table row --%>
		<td><p>이름</p></td> <%-- 이름 --%>
		<td><p>학번</p></td> <%-- 학번 --%>
		<td><p>국어</p></td> <%-- 국어 --%>
		<td><p>영어</p></td> <%-- 영어 --%>
		<td><p>수학</p></td> <%-- 수학 --%>
	</tr>
<%
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo10","root","kopoctc");
		// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
		// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
		Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
		
		ResultSet rset = stmt.executeQuery("select * from anotherTwice where name = '"+ckey+"';");
		// 해당 쿼리를 실행하기 위해 executeQuery를 호출하고 그 결과를 rset에 저장한다.
		while(rset.next()){ // rset이 있으면
			out.println("<tr>"); // tr
			out.println("<td><p>"+rset.getString(1)+"</p></td>"); // 이름 출력
			out.println("<td><p>"+Integer.toString(rset.getInt(2))+"</p></td>"); // 학번 출력
			out.println("<td><p>"+Integer.toString(rset.getInt(3))+"</p></td>"); // 국어점수 출력
			out.println("<td><p>"+Integer.toString(rset.getInt(4))+"</p></td>"); // 영어점수 출력
			out.println("<td><p>"+Integer.toString(rset.getInt(5))+"</p></td>"); // 수학점수 출력
			out.println("</tr>"); // /tr
		}
		rset.close(); // 리소스 정리
		stmt.close(); // 리소스 정리
		conn.close(); // 리소스 정리
	} catch (Exception e) {
		
	}
%>
</table>
</body>
</html>