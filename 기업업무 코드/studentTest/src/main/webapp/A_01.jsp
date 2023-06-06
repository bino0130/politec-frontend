<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.sql.*, javax.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> <!-- 인코딩 utf-8로 설정 -->
<title>후보등록 - 등록</title>
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

.printKiho { /* class명이 printKiho인 태그에 css 지정 */
	border: 1px solid black;
	width: 500px;
	margin: auto;
	border-collapse: collapse;
}

#up { /* id가 up인 태그에 css 지정 */
	width: 700px;
	height: 350px;
	border: 1px solid green;
	margin: auto;
}

</style>
<script>
//특수문자, 숫자 입력 방지
function nameCheck(obj) {
	// 특수문자 및 공백 입력 방지
	var regExp = /[~`!@#$%^&*()\-_=+[{\]}\\|;:'",<.>/?\s0-9]/gi;

	if (regExp.test(obj.value)) { // 특수문자, 공백 또는 숫자가 입력되면
		alert("이름에는 한글과 영어만 입력할 수 있습니다."); // 안내메세지 출력
		obj.value = obj.value.replace(regExp, ""); // 특수문자, 공백, 숫자 제거
	}
}
</script>
</head>
<body>
	<%
	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	%>
	<div style="border: 1px solid black; width: 900px; height: 800px; margin: auto;"> <!-- border가 1px solid black, 너비는 900, 높이는 800, 마진은 auto인 div태그 -->
		<div id=up> <!-- id가 up인 div태그 -->

			<form method='post'> <!-- post방식 form 태그 -->
				<table class="blue1">  <!-- table 오픈 -->
					<tr> <!-- table row -->
						<td><input class="menu" 
							style='background-color: yellow; cursor: pointer;' type='submit'
							value='후보등록' formaction="./A_01.jsp" /></td> <!-- 메뉴 중 후보등록 출력하는 td, input태그. 클릭 시 A_01로 이동 -->
						<td><input class="menu"
							style='background-color: white; cursor: pointer;' type='submit'
							value='투표' formaction="./B_01.jsp" /></td> <!-- 메뉴 중 투표 출력하는 td, input 태그, 클릭 시 B_01로 이동 -->
						<td><input class="menu"
							style='background-color: white; cursor: pointer;' type='submit'
							value='개표결과' formaction="./C_01.jsp" /></td> <!-- 메뉴 중 개표결과 출력하는 td, input 태그, 클릭 시 C_01로 이동 -->
					</tr>
				</table> <!-- table 닫음 -->
			</form>

			<table class="printKiho"> <!-- table 오픈 -->
				<%
				String Querytxt1 = "select * from kiho"; // kiho 테이블 전체 데이터 출력하는 쿼리
				ResultSet rset1 = stmt.executeQuery(Querytxt1); // 쿼리 실행

				while (rset1.next()) { // rset이 있으면
					int id = rset1.getInt(1); // id에 getInt(1)값 대입
					String name = rset1.getString(2); // name에 getString(2)값 대입
				%>
				<form method='post'> <!-- post방식 form 태그 -->
					<tr class='table-row'> <!-- table row -->
						<td style='width: 150px;'>기호번호 : <%=id%></td> <!-- 기호번호 -->
						<td style='width: 150px;'>후보명 : <%=name%></td> <!-- 후보명 -->
						<td><input type='hidden' name='deleteId' value='<%=id%>' /></td> <!-- deleteID를 전달하는 hidden타입 input태그 -->
						<td><input type='hidden' name='deleteName' value='<%=name%>' /></td> <!-- deleteName을 전달하는 hidden타입 input태그 -->
						<td style='display: flex; justify-content: flex-end;'><input
							style='cursor: pointer;' class='button' type='submit' value='삭제'
							formaction='./A_02.jsp' /></td> <!-- A_02 파일에 데이터를 전달하는 삭제 버튼 input태그 -->
					</tr> <!-- table row -->
				</form> <!--  form 태그 닫힘 -->
				<%
				}
				%>
				<form> <!-- form 태그 열림 -->
					<tr> <!-- table row -->
						<td style='width: 140px;'>기호번호 : <input type='text'
							name='addId' value='자동입력' style='width: 50px; font-size: 12px;' readonly></td> <!-- 기호번호 --> <!-- A_03에서 계산 후 자동입력됨 -->
						<td colspan='3' style='width: 180px;'>후보명 : <input
							type='text' name='addName' value='' style='width: 100px;'
							onkeyup="nameCheck(this)" maxlength="10" required></td> <!-- 후보명 --> <!-- addName을 전달하는 input태그 -->
						<td style='display: flex; justify-content: flex-end;'><input
							style='cursor: pointer;' class='button' type='submit' value='추가'
							formaction='./A_03.jsp' /></td> <!-- A_03파일에 데이터를 전달하는 추가 버튼 input 태그 -->
					</tr> <!-- table row -->
				</form> <!-- form 태그 닫힘 -->
			</table> <!-- table 닫음 -->

		</div>
	</div>
</body>
</html>