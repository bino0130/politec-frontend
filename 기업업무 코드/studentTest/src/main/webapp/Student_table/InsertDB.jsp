<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*"%>
<%
request.setCharacterEncoding("utf-8");
String name = request.getParameter("name"); // input받은 username 값 변수에 저장
String kor = request.getParameter("korean"); // input받은 korean 값 변수에 저장
String eng = request.getParameter("english"); // input받은 english 값 변수에 저장
String mat = request.getParameter("math"); // input받은 mat 값 변수에 저장
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
table {
	width: 400px;
}

.one {
	width: 100px;
}

.three {
	width: 300px;
}

p {
	text-align: center;
	margin: auto;
}
</style>
</head>
<body>
	<%
	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	String insertQuery = "INSERT INTO anotherTwice (name, kor, eng, mat) VALUES ('" + name + "', " + Integer.parseInt(kor) + ", " + Integer.parseInt(eng) + ", " + Integer.parseInt(mat) + ");";
	stmt.executeUpdate(insertQuery);
	
	String printID = "select *  from anotherTwice ORDER BY studentid DESC LIMIT 1"; // studentid가 가장 마지막 번호인 데이터 출력 
	ResultSet rset = stmt.executeQuery(printID);
	int studentId = 0;
	while (rset.next()) {
		studentId = Integer.parseInt(rset.getString("studentId"));
	}

	%>
	<table cellspacing=1 border=0>
		<tr>
			<td class="three"></td>
			<td class="one"><input type="submit" value="추가"></td>
		</tr>
	</table>

	<table cellspacing=1 border=1px solid black>
		<tr>
			<td class="one"><p>이름</p></td>
			<td class="three"><p>
					<input type='text' name='name' value='<%=name%>'></p></td>
		</tr>
		<tr>
			<td class="one"><p>학번</p></td>
			<td class="three"><p><%=studentId%></p></td>
		</tr>
		<tr>
			<td class="one"><p>국어</p></td>
			<td class="three"><p>
					<input type='text' name='korean' value='<%=kor%>'></p></td>
		</tr>
		<tr>
			<td class="one"><p>영어</p></td>
			<td class="three"><p>
					<input type='text' name='english' value='<%=eng%>'></p></td>
		</tr>
		<tr>
			<td class="one"><p>수학</p></td>
			<td class="three"><p>
					<input type='text' name='math' value='<%=mat%>'></p></td>
		</tr>
	</table>
</body>
</html>