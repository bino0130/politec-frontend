<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import = "java.sql.*, javax.sql.*,java.io.*,java.util.*" %>
<%
request.setCharacterEncoding("utf-8"); // 인코딩 utf-8로 설정
String hubo = request.getParameter("hubo"); // input받은 hubo 값 변수에 저장
String age = request.getParameter("age"); // input받은 age 값 변수에 저장
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>투표 - 투표결과</title>
<style>
.blue1 { /* 클래스가 blue1인 태그에 스타일 적용 */
	width: 350px;
	border: 1px solid black;
	margin: auto;
}

.menu { /* 클래스가 menu인 태그에 스타일 적용 */
	width: 100%;
	height: 35px;
	border: 1px solid blue;
	font-size: 25px;
}

#down { /* id가 down인 태그에 스타일 적용 */
	width: 700px;
	height: 100px;
	border: 1px solid green;
	margin : auto;
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
	String Querytxt = String.format("insert into tupyo value (%d, %d)",Integer.parseInt(hubo), Integer.parseInt(age));
	stmt.execute(Querytxt);
	%>
	<div style="border:1px solid black; width : 900px; height : 800px; margin: auto;"> <%-- div태그 내부에 직접적으로 css 적용 --%>
		<div id=down> <!-- id가 down인 div태그 -->
		
		<form method='post'> <!-- post방식 form 태그 -->
			<table class="blue1"> <!-- 클래스명이 blue1인 테이블 태그 -->
				<tr> <!-- table row -->
					<%-- 후보등록, 투표, 개표결과 메뉴 출력 --%>
					<td><input class="menu" style='background-color: white; cursor: pointer;' type='submit' value='후보등록' formaction="./A_01.jsp" /></td>
					<td><input class="menu" style='background-color: yellow; cursor: pointer;' type='submit' value='투표' formaction="./B_01.jsp" /></td>
					<td><input class="menu" style='background-color: white; cursor: pointer;' type='submit' value='개표결과' formaction="./C_01.jsp" /></td>
				</tr> <!-- table row -->
			</table> <!-- table close -->
		</form> <!-- form태그 닫힘 -->
		
		<span style="margin-left: 250px;"> <!-- margin-left가 250ox인 span 태그 -->
		<%
			out.println("투표 결과 : 투표하였습니다."); // 안내 메세지 출력
		%>
		</span>
		</div>
	</div>
</body>
</html>