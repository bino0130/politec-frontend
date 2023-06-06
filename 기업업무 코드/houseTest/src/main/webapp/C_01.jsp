<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.sql.*, javax.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> <!-- 인코딩 utf-8로 설정 -->
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
	
	// 후보의 기호, 이름, 득표수, 득표율을 출력하는 쿼리
	String Querytxt = "SELECT a.id, a.name, " + "(SELECT COUNT(b.id) FROM tupyo AS b WHERE a.id = b.id) AS 득표수, "
			+ "(SELECT ROUND((COUNT(b.id) / (SELECT COUNT(id) FROM tupyo) * 100), 2) "
			+ "FROM tupyo AS b WHERE a.id = b.id) AS 득표율 " + "FROM kiho AS a";

	ResultSet rset = stmt.executeQuery(Querytxt); // 쿼리 실행

	int id = 0; // id = 0으로 초기화
	String name = ""; // name = ""으로 초기화
	int countId = 0; // countId = 0으로 초기화
	double printPercent = 0.0; // printPercent = 0.0으로 초기화
	%>
	<div style="border: 1px solid black; width: 900px; height: 800px; margin: auto;"> <!-- border가 1px solid black, 너비는 900, 높이는 800, 마진은 auto인 div태그 -->
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
							value='개표결과' formaction="./C_01.jsp" /></td> <!-- 메뉴 중 개표결과 출력하는 td, input 태그, 클릭 시 C_01로 이동 -->
					</tr> <!-- table row -->
				</table> <!-- table 닫음 -->
			</form>

			<br><span style="margin-left: 50px;">후보 별 득표율</span><br><br> <!-- 후보 별 득표율 출력 -->
			<form method='post' action="C_02.jsp"> <!-- C_02파일에 데이터를 전달하는 form 태그 -->
				<table class="printVote"> <!-- 클래스명이 printVote인 table 오픈 -->
					<%
					while (rset.next()) { // rset이 있으면
						id = rset.getInt(1); // id에 getInt(1) 대입
						name = rset.getString(2); // name에 getString(2) 대입
						countId = rset.getInt(3); // countId에 getInt(3) 대입
						printPercent = rset.getDouble(4); // printPercent에 getDouble(4) 대입
					%>
					<tr style="border-bottom: 1px solid black;"> <!-- table row -->
						<td style="width: 20%; border: 1px solid black;"> <!-- 너비 20%, border : 1px solid black -->
								<!-- 링크를 클릭하면 C_02 파일에 데이터를 전달하는 a태그 -->
							<p><a style="text-decoration:none; color:black;" href="C_02.jsp?id=<%=id%>&name=<%=name%>"><%=id%>. <%=name%></a></p>
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