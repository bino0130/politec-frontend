<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.sql.*, javax.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후보등록 - 등록</title>
<style>
.blue1 {
	width: 350px;
	border: 1px solid black;
	margin: auto;
}

.menu {
	width: 100%;
	height: 35px;
	border: 2px solid blue;
	font-size: 25px;
}

.button {
	background-color: #5CFFD1;
	width: 100px;
	border-radius: 5px;
}

#up {
	width: 700px;
	height: 350px;
	border: 1px solid green;
	margin : auto;
}

select {
	width: 200px; 
	padding: .8em .5em; 
	border: 1px solid #00ff00;
	font-family: inherit;  
	background: url('arrow.jpg') no-repeat 95% 50%; 
	border-radius: 0px; 
	-webkit-appearance: none; 
	-moz-appearance: none;
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
	%>
	<div style="border:1px solid black; width : 900px; height : 800px;">
		<div id=up>
		
		<form  method='post'>
			<table class="blue1">
				<tr>
					<td><input class="menu" style='background-color: white; cursor: pointer;' type='submit' value='후보등록' formaction="./A_01.jsp" /></td>
					<td><input class="menu" style='background-color: yellow; cursor: pointer;' type='submit' value='투표' formaction="./B_01.jsp" /></td>
					<td><input class="menu" style='background-color: white; cursor: pointer;' type='submit' value='개표결과' formaction="./C_01.jsp" /></td>
				</tr>
			</table>
		</form>
		
		<form post='method'>
			<table style="width : 500px; height : 50px; border : 1px solid black; margin : auto">
				<tr>
					<td style="text-align : center;">
						<select name="hubo" required>
	<%
		String Querytxt1 = "select * from kiho";
		ResultSet rset1 = stmt.executeQuery(Querytxt1);

		while (rset1.next()) {
			int id = rset1.getInt(1);
			String name = rset1.getString(2);
	%>
								<option value="<%=id%>"><%=id%>번 <%=name%></option>
	<%
		}
	%>
						</select>
					</td>
					<td style="text-align : center;">
						<select name="age" required>
							<option value="10대">10대</option>
							<option value="20대">20대</option>
							<option value="30대">30대</option>
							<option value="40대">40대</option>
							<option value="50대">50대</option>
							<option value="60대">60대</option>
							<option value="70대">70대</option>
							<option value="80대">80대</option>
							<option value="90대">90대</option>
						</select>
					</td>
					<td style="text-align : center;"><input style='cursor:pointer;' class="button" type="submit"  value='투표하기' formaction="./B_02.jsp"/></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>