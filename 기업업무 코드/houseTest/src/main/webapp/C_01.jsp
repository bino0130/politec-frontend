<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.sql.*, javax.sql.*"%>
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
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 3306 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성

	String Querytxt = "SELECT a.id, a.name, " + "(SELECT COUNT(b.id) FROM tupyo AS b WHERE a.id = b.id) AS 득표수, "
			+ "(SELECT ROUND((COUNT(b.id) / (SELECT COUNT(id) FROM tupyo) * 100), 2) "
			+ "FROM tupyo AS b WHERE a.id = b.id) AS 득표율 " + "FROM kiho AS a";

	ResultSet rset = stmt.executeQuery(Querytxt);

	int id = 0;
	String name = "";
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

			<br><span style="margin-left: 50px;">후보 별 득표율</span><br><br>
			<form action="C_02.jsp">
				<table class="printVote">
					<%
					while (rset.next()) {
						id = rset.getInt(1);
						name = rset.getString(2);
						countId = rset.getInt(3);
						printPercent = rset.getDouble(4);
					%>
					<tr style="border-bottom: 1px solid black;">
						<td style="width: 20%; border: 1px solid black;">
							<p><a style="text-decoration:none; color:black;" href="C_02.jsp?id=<%=id%>&name=<%=name%>"><%=id%>. <%=name%></a></p>
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