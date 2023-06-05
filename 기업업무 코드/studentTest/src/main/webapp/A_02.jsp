<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import = "java.sql.*, javax.sql.*,java.io.*,java.util.*" %>
<%
request.setCharacterEncoding("utf-8"); // 인코딩 utf-8로 설정
String name = request.getParameter("deleteName"); // input받은 deleteName 값 변수에 저장
String id = request.getParameter("deleteId"); // input받은 deleteId 값 변수에 저장
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후보등록 - 등록결과(삭제)</title>
<style>
.blue1 { /* 클래스명이 blue1인 태그 셀렉터로 css 지정 */
	width: 350px;
	border: 1px solid black;
	margin: auto;
}

.menu { /* 클래스명이 menu인 태그 셀렉터로 css 지정 */
	width: 100%;
	height: 35px;
	border: 1px solid blue;
	font-size: 25px;
}

#down { /* id가 down인 태그 셀렉터로 css 지정 */
	width: 700px;
	height: 100px;
	border: 1px solid green;
	margin : auto;
}
</style>
</head>
<body>
	<%
	Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	
	// parameter로 받은 id와 id가 일치하는 데이터를 찾아 kiho 테이블에서 삭제하는 쿼리
	String Querytxt = String.format("delete from kiho where id = %d",Integer.parseInt(id));
	stmt.execute(Querytxt); // 쿼리 실행
	%>
	<div style="border:1px solid black; width : 900px; height : 800px; margin: auto;"> <!-- border : 1px solid black, 너비는 900, 높이는 800, 마진은 auto인 div태그 -->
		<div id=down> <!-- id명이 down인 div 태그 -->
		
		<form method='post'> <!-- post방식 form 태그 -->
			<table class="blue1"> <!-- class명이 blue1인 table 태그 -->
				<tr> <!-- table row -->
					<td><input class="menu" style='background-color: yellow; cursor: pointer;' type='submit' value='후보등록' formaction="./A_01.jsp" /></td> <!-- 메뉴 중 후보등록 출력하는 td, input태그. 클릭 시 A_01로 이동 -->
					<td><input class="menu" style='background-color: white; cursor: pointer;' type='submit' value='투표' formaction="./B_01.jsp" /></td> <!-- 메뉴 중 투표 출력하는 td, input 태그, 클릭 시 B_01로 이동 -->
					<td><input class="menu" style='background-color: white; cursor: pointer;' type='submit' value='개표결과' formaction="./C_01.jsp" /></td> <!-- 메뉴 중 개표결과 출력하는 td, input 태그, 클릭 시 C_01로 이동 -->
				</tr> <!-- table row -->
			</table> <!-- table close -->
		</form> <!-- form태그 닫힘 -->
		
		<span style="margin-left: 140px;"> <!-- margin-left가 140ox인 span 태그 -->
		<%
			out.println("후보등록 결과 : 기호 " + id + "번 " + name + " 후보가 삭제되었습니다."); // 삭제 메세지 출력
		%>
		</span>
		</div>
	</div>
</body>
</html>