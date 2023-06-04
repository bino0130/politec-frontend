<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import = "java.sql.*, javax.sql.*,java.io.*,java.util.*" %>
<%
request.setCharacterEncoding("utf-8");
String name = request.getParameter("addName"); // input받은 name 값 변수에 저장
String id = request.getParameter("addId"); // input받은 id 값 변수에 저장
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후보등록 - 등록결과(추가)</title>
<style>
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

#down {
	width: 700px;
	height: 100px;
	border: 1px solid green;
	margin : auto;
}
</style>
</head>
<body>
	<%
	try {
	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	String Querytxt = String.format("insert into kiho value (%d, '%s')",Integer.parseInt(id), name);
	stmt.execute(Querytxt);
	%>
	<div style="border:1px solid black; width : 900px; height : 800px; margin: auto;">
		<div id=down>
		
		<form method='post'>
			<table class="blue1">
				<tr>
					<td><input class="menu" style='background-color: yellow; cursor: pointer;' type='submit' value='후보등록' formaction="./A_01.jsp" /></td>
					<td><input class="menu" style='background-color: white; cursor: pointer;' type='submit' value='투표' formaction="./B_01.jsp" /></td>
					<td><input class="menu" style='background-color: white; cursor: pointer;' type='submit' value='개표결과' formaction="./C_01.jsp" /></td>
				</tr>
			</table>
		</form>
		
		<span style="margin-left: 140px;">
		<%
			out.println("후보등록 결과 : 기호 " + id + "번 " + name + " 후보가 추가되었습니다.");
	} catch (SQLIntegrityConstraintViolationException e) {
	    out.println("중복된 기호번호입니다. 다른 기호번호를 선택해주세요.");
	}
		%>
		</span>
		</div>
	</div>
</body>
</html>