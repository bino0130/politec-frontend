<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.sql.*, javax.sql.*"%>
<%
request.setCharacterEncoding("utf-8");
String id = request.getParameter("id"); // input받은 id 값 변수에 저장
String name = request.getParameter("name"); // input받은 name 값 변수에 저장
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개표결과 - 득표율</title>
<style>
.table-row {
	border-bottom: 1px solid black;
	border-collapse: collapse;
}

.blue1 {
	width: 350px;
	border: 1px solid black;
	margin: auto;
}

.menu {
	width: 100%;
	height: 35px;
	border: 1px solid blue;
	font-size: 25px;
}

.button {
	background-color: #5CFFD1;
	width: 100px;
	border-radius: 5px;
}

.printVote {
	border: 1px solid black;
	width: 600px;
	margin: auto;
	border-collapse: collapse;
}

#up {
	width: 700px;
	height: 650px;
	border: 1px solid green;
	margin: auto;
}

/*td {
	border : 1px solid black;
}*/
</style>
</head>
<body>
	<%
	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성

	String Querytxt = String.format("SELECT age_range.age, COALESCE(t.vote_count, 0) AS 득표수, "
	        + "CASE WHEN COALESCE(t.vote_count, 0) = 0 THEN '0%%' ELSE "
	        + "CONCAT(ROUND((COALESCE(t.vote_count, 0) / (SELECT COUNT(id) FROM tupyo WHERE id = %d) * 100), 2), '%%') "
	        + "END AS 득표율 "
	        + "FROM ( "
	        + "SELECT '10대' AS age "
	        + "UNION ALL SELECT '20대' AS age "
	        + "UNION ALL SELECT '30대' AS age "
	        + "UNION ALL SELECT '40대' AS age "
	        + "UNION ALL SELECT '50대' AS age "
	        + "UNION ALL SELECT '60대' AS age "
	        + "UNION ALL SELECT '70대' AS age "
	        + "UNION ALL SELECT '80대' AS age "
	        + "UNION ALL SELECT '90대' AS age "
	        + ") AS age_range "
	        + "LEFT JOIN ( "
	        + "SELECT age, COUNT(id) AS vote_count "
	        + "FROM tupyo "
	        + "WHERE id = %d "
	        + "GROUP BY age "
	        + ") AS t ON age_range.age = t.age",
	        Integer.parseInt(id), Integer.parseInt(id));

	ResultSet rset = stmt.executeQuery(Querytxt);

	String printAge = "";
	String printName = "";
	int countId = 0;
	double printPercent = 0.0;
	%>
	<div
		style="border: 1px solid black; width: 900px; height: 800px; margin: auto;">
		<div id=up>

			<form method='post'>
				<table class="blue1">
					<tr>
						<td><input class="menu"
							style='background-color: white; cursor: pointer;' type='submit'
							value='후보등록' formaction="./A_01.jsp" /></td>
						<td><input class="menu"
							style='background-color: white; cursor: pointer;' type='submit'
							value='투표' formaction="./B_01.jsp" /></td>
						<td><input class="menu"
							style='background-color: yellow; cursor: pointer;' type='submit'
							value='개표결과' formaction="./C_01.jsp" /></td>
					</tr>
				</table>
			</form>

			<br><span style="margin-left: 50px;"><%=id%>.<%=name%> 후보 득표성향 분석</span><br><br>
			<form action="">
				<table class="printVote">
					<%
					while (rset.next()) {
						printAge = rset.getString(1);
						countId = rset.getInt(2);
						printPercent = Double.parseDouble(rset.getString(3).replaceAll("%", ""));
					%>
					<tr style="border-bottom: 1px solid black;">
						<td style="width: 20%; border: 1px solid black;">
							<p><%=printAge%></p>
						</td>
						<td style="width: 80%;">
							<div style="display: flex; align-items: center;">
                    	 <p style="background-color: #ff0000; width: <%=printPercent%>%; height:20px; margin: 0;"></p>
                    	 <span style="margin-left: 10px;"><%=countId%>(<%=printPercent%>%)</span>
                    	 </div>
						</td>
					</tr>
					<%
						}
					%>
				</table>
			</form>

		</div>
	</div>
</body>
</html>