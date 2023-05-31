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
		text-align : center;
	}
</style>
</head>
<body>
<h1>트와이스 데이터 조회</h1> <%-- h1태그 사용 --%>
<table cellspacing=1 width=600px border=1px solid black>
	<%-- cellspacing=1, 너비 600px. border : 1px solid black인 테이블 생성 --%>
		<tr> <%-- table row --%>
			<td><p>이름</p></td> <%-- 이름 --%>
			<td><p>학번</p></td> <%-- 학번 --%>
			<td><p>국어</p></td> <%-- 국어 --%>
			<td><p>영어</p></td> <%-- 영어 --%>
			<td><p>수학</p></td> <%-- 수학 --%>
			<td><p>총합</p></td> <%-- 총합 --%>
			<td><p>평균</p></td> <%-- 평균 --%>
			<td><p>등수</p></td> <%-- 등수 --%>
		</tr>
<%
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo10","root","kopoctc");
		// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
		// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
		Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
		String Querytxt = "select *, kor + eng + mat as sum , (kor + eng + mat) / 3 as avg , " +
                "(select count(*) + 1 from anotherTwice as r1 where r1.kor+r1.eng+r1.mat > r.kor + r.eng + r.mat) as rnk " +
                "from anotherTwice as r order by rnk";
		ResultSet rset = stmt.executeQuery(Querytxt);
		// 해당 쿼리를 실행하기 위해 executeQuery를 호출하고 그 결과를 rset에 저장한다.
		while(rset.next()){ // rset이 있으면
			out.println("<tr>"); // tr
			out.println("<td><p><a href='OneviewDB.jsp?key=" + // OneviewDB.jsp로 연결하는 a태그
			rset.getString(1) + "'>" + rset.getString(1) + "</a></p></td>"); // 이름 출력
			out.println("<td><p>"+Integer.toString(rset.getInt(2))+"</p></td>"); // 학번 출력
			out.println("<td><p>"+Integer.toString(rset.getInt(3))+"</p></td>"); // 국어점수 출력
			out.println("<td><p>"+Integer.toString(rset.getInt(4))+"</p></td>"); // 영어점수 출력
			out.println("<td><p>"+Integer.toString(rset.getInt(5))+"</p></td>"); // 수학점수 출력
			out.println("<td><p>"+Integer.toString(rset.getInt(6))+"</p></td>"); // 총점점수 출력
			out.println("<td><p>"+Integer.toString(rset.getInt(7))+"</p></td>"); // 평균점수 출력
			out.println("<td><p>"+Integer.toString(rset.getInt(8))+"</p></td>"); // 등수 출력
			out.println("</tr>"); // /tr
		}
		rset.close(); // 리소스 정리
		stmt.close(); // 리소스 정리
		conn.close(); // 리소스 정리
	} catch (Exception e) {
		e.printStackTrace();	
	}
%>
</table>
</body>
</html>