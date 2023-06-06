<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.sql.*, javax.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후보등록 - 등록</title>
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

.button { /* 클래스가 button인 태그에 스타일 적용 */
	background-color: #5CFFD1;
	width: 100px;
	border-radius: 5px;
}

#up { /* id가 up인 태그에 스타일 적용 */
	width: 700px;
	height: 350px;
	border: 1px solid green;
	margin : auto;
}

select { /* select 태그에 스타일 적용 */
	width: 200px; 
	padding: .8em .5em; 
	border: 1px solid #00ff00;
	font-family: inherit;  
	background: url('arrow.jpg') no-repeat 95% 50%; 
	border-radius: 0px; 
	-webkit-appearance: none; 
	-moz-appearance: none;
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
	%>
	<div style="border:1px solid black; width : 900px; height : 800px; margin: auto;"> <%-- div태그 내부에 직접적으로 css 적용 --%>
		<div id=up> <%-- id가 up인 div태그 --%>
		
		<form  method='post'> <%-- post형식 form 태그 --%>
			<table class="blue1"> <%-- blue1 클래스 테이블 --%>
				<tr> <%-- row 추가 --%>
					 <%-- 후보등록, 투표, 개표결과 메뉴 출력 --%>
					<td><input class="menu" style='background-color: white; cursor: pointer;' type='submit' value='후보등록' formaction="./A_01.jsp" /></td>
					<td><input class="menu" style='background-color: yellow; cursor: pointer;' type='submit' value='투표' formaction="./B_01.jsp" /></td>
					<td><input class="menu" style='background-color: white; cursor: pointer;' type='submit' value='개표결과' formaction="./C_01.jsp" /></td>
				</tr>
			</table>
		</form>
		
		<form post='method'>  <%-- post형식 form 태그 --%>
			<table style="width : 500px; height : 50px; border : 1px solid black; margin : auto">  <%-- 테이블 태그 내부에 직접적으로 css 적용 --%>
				<tr> <%-- row 추가 --%>
					<td style="text-align : center;"> <%-- td태그 내부에 직접적으로 css 적용 --%>
						<select name="hubo" required> <%-- select 태그에 required 적용해서 비어있으면 넘어가지 않게 설정 --%>
	<%
		String Querytxt1 = "select * from kiho"; // kiho테이블 전체출력 쿼리
		ResultSet rset1 = stmt.executeQuery(Querytxt1); // 쿼리실행

		while (rset1.next()) { // rset의 다음 데이터가 있으면
			int id = rset1.getInt(1); // id = rset1.getInt(1)
			String name = rset1.getString(2); // name = rset1.getString(2)
	%>
								<option value="<%=id%>"><%=id%>번 <%=name%></option> <!-- 0번 000 출력 -->
	<%
		}
	%>
						</select>
					</td>
					<td style="text-align : center;">
						<select name="age" required> <%-- select 태그에 required 적용해서 비어있으면 넘어가지 않게 설정 --%>
							<option value="10">10대</option> <!-- 10대 -->
							<option value="20">20대</option> <!-- 20대 -->
							<option value="30">30대</option> <!-- 30대 -->
							<option value="40">40대</option> <!-- 40대 -->
							<option value="50">50대</option> <!-- 50대 -->
							<option value="60">60대</option> <!-- 60대 -->
							<option value="70">70대</option> <!-- 70대 -->
							<option value="80">80대</option> <!-- 80대 -->
							<option value="90">90대</option> <!-- 90대 -->
						</select>
					</td>
					<!-- B_02에 데이터를 전달하는 투표하기 버튼 input 태그 -->
					<td style="text-align : center;"><input style='cursor:pointer;' class="button" type="submit"  value='투표하기' formaction="./B_02.jsp"/></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>