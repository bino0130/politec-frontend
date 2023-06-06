<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.sql.*, javax.sql.*"%>
<%
request.setCharacterEncoding("utf-8"); // 인코딩 utf-8로 설정
String id = request.getParameter("id"); // input받은 id 값 변수에 저장
String name = request.getParameter("name"); // input받은 name 값 변수에 저장
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개표결과 - 득표율</title>
<style>
.table-row { /* class명이 table-row인 태그에 css 지정 */
	border-bottom: 1px solid black;
	border-collapse: collapse;
}

.blue1 { /* class명이 blue1인 태그에 css 지정 */
	width: 350px;
	border: 1px solid black;
	margin: auto;
}

.menu { /* class명이 menu인 태그에 css 지정 */
	width: 100%;
	height: 35px;
	border: 1px solid blue;
	font-size: 25px;
}

.button { /* class명이 button인 태그에 css 지정 */
	background-color: #5CFFD1;
	width: 100px;
	border-radius: 5px;
}

.printVote { /* class명이 printVote인 태그에 css 지정 */
	border: 1px solid black;
	width: 600px;
	margin: auto;
	border-collapse: collapse;
}

#up { /* id가 up인 태그에 css 지정 */
	width: 700px;
	height: 650px;
	border: 1px solid green;
	margin: auto;
}

</style>
</head>
<body>
	<%
	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 3306 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성

	// 특정 후보자에게 투표한 연령대를 출력하는 쿼리문
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

	ResultSet rset = stmt.executeQuery(Querytxt); // 쿼리 실행

	String printAge = ""; // printAge = ""으로 초기화
	String printName = ""; // printName ""으로 초기화
	int countId = 0; // countId = 0으로 초기화
	double printPercent = 0.0; // printPercent = 0.0으로 초기화
	%>
	<div
		style="border: 1px solid black; width: 900px; height: 800px; margin: auto;"> <!-- border가 1px solid black, 너비는 900, 높이는 800, 마진은 auto인 div태그 -->
		<div id=up> <!-- id가 up인 div태그 -->

			<form method='post'> <!-- post방식 form 태그 -->
				<table class="blue1">  <!-- table 오픈 -->
					<tr> <!-- table row -->
						<td><input class="menu"
							style='background-color: white; cursor: pointer;' type='submit'
							value='후보등록' formaction="./A_01.jsp" /></td> <!-- 메뉴 중 후보등록 출력하는 td, input태그. 클릭 시 A_01로 이동 -->
						<td><input class="menu"
							style='background-color: white; cursor: pointer;' type='submit'
							value='투표' formaction="./B_01.jsp" /></td> <!-- 메뉴 중 투표 출력하는 td, input 태그, 클릭 시 B_01로 이동 -->
						<td><input class="menu"
							style='background-color: yellow; cursor: pointer;' type='submit'
							value='개표결과' formaction="./C_01.jsp" /></td><!-- 메뉴 중 개표결과 출력하는 td, input 태그, 클릭 시 C_01로 이동 -->
					</tr>
				</table>
			</form>

			<br><span style="margin-left: 50px;"><%=id%>.<%=name%> 후보 득표성향 분석</span><br><br> <!-- 0. 000 후보 득표성향 분석 -->
			<form action="">
				<table class="printVote"> <!-- 클래스명이 printVote인 table 오픈 -->
					<%
					while (rset.next()) { // rset이 있으면
						printAge = rset.getString(1); // printAge에 getString(1) 대입
						countId = rset.getInt(2); // countId에 getInt(2) 대입
						printPercent = Double.parseDouble(rset.getString(3).replaceAll("%", "")); // printPercent에 getString(3)대입. %는 없앰
						%>
					<tr style="border-bottom: 1px solid black;"> <!-- table row -->
						<td style="width: 20%; border: 1px solid black;"> <!-- 너비 20%, border : 1px solid black -->
							<p><%=printAge%></p>
						</td>
						<td style="width: 80%;"> <!-- 너비 80% -->
							<div style="display: flex; align-items: center;">
                    	 <p style="background-color: #ff0000; width: <%=printPercent%>%; height:20px; margin: 0;"></p>
                    	 <span style="margin-left: 10px;"><%=countId%>(<%=printPercent%>%)</span> <!-- 득표율에 따라 너비가 달라지는 p태그와 득표수, 득표율을 출력하는 span태그 -->
                    	 </div>
						</td>
					</tr> <!-- table row -->
					<%
						}
					%>
				</table> <!-- table 닫음 -->
			</form>

		</div>
	</div>
</body>
</html>