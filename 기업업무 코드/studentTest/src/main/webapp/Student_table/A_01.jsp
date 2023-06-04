<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.sql.*, javax.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후보등록 - 등록</title>
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

.printKiho {
	border: 1px solid black;
	width: 500px;
	margin: auto;
	border-collapse: collapse;
}

#up {
	width: 700px;
	height: 350px;
	border: 1px solid green;
	margin: auto;
}

/*td {
	border : 1px solid black;
}*/
</style>
<script>
//특수문자 입력 방지
function characterCheck(obj) {
  var regExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
  var hanExp = /[ㄱ-ㅎㅏ-ㅣ]/g;
  var engExp = /[a-zA-Z]/g;
  var numExp = /^[0-9]+$/; // 숫자 패턴 추가
  var num = parseInt(obj.value);

  if (regExp.test(obj.value)) {
    alert("특수문자는 입력하실 수 없습니다.");
    obj.value = obj.value.replace(regExp, ""); // 특수문자 제거
  } else if (hanExp.test(obj.value)) {
    alert("한글은 사용하실 수 없습니다.");
    obj.value = obj.value.replace(hanExp, ""); // 한글 제거
  } else if (engExp.test(obj.value)) {
    alert("영어는 사용하실 수 없습니다.");
    obj.value = obj.value.replace(engExp, ""); // 영어 제거
  } else if (obj.value !== "" && (!numExp.test(obj.value) || num < 1 || num > 100)) {
    alert("숫자는 1부터 100 사이의 값을 입력해야 합니다.");
    obj.value = "";
  }
}

function nameCheck(obj) {
	  var regExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=0-9]/gi;

	  if (obj.value.length > 10) {
	    alert("이름은 최대 10자까지 입력할 수 있습니다.");
	    obj.value = obj.value.substring(0, 10); // 최대 길이만큼 잘라내기
	  }

	  if (regExp.test(obj.value)) {
	    alert("이름에는 특수문자와 숫자를 사용할 수 없습니다.");
	    obj.value = obj.value.replace(regExp, ""); // 특수문자 제거
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
	<div
		style="border: 1px solid black; width: 900px; height: 800px; margin: auto;">
		<div id=up>

			<form method='post'>
				<table class="blue1">
					<tr>
						<td><input class="menu"
							style='background-color: yellow; cursor: pointer;' type='submit'
							value='후보등록' formaction="./A_01.jsp" /></td>
						<td><input class="menu"
							style='background-color: white; cursor: pointer;' type='submit'
							value='투표' formaction="./B_01.jsp" /></td>
						<td><input class="menu"
							style='background-color: white; cursor: pointer;' type='submit'
							value='개표결과' formaction="./C_01.jsp" /></td>
					</tr>
				</table>
			</form>

			<table class="printKiho">
				<%
				String Querytxt1 = "select * from kiho";
				ResultSet rset1 = stmt.executeQuery(Querytxt1);

				while (rset1.next()) {
					int id = rset1.getInt(1);
					String name = rset1.getString(2);
				%>
				<form method='post'>
					<tr class='table-row'>
						<td style='width: 150px;'>기호번호 : <%=id%></td>
						<td style='width: 150px;'>후보명 : <%=name%></td>
						<td><input type='hidden' name='deleteId' value='<%=id%>' /></td>
						<td><input type='hidden' name='deleteName' value='<%=name%>' /></td>
						<td style='display: flex; justify-content: flex-end;'><input
							style='cursor: pointer;' class='button' type='submit' value='삭제'
							formaction='./A_02.jsp' /></td>
					</tr>
				</form>
				<%
				}
				%>
				<form>
					<tr>
						<td style='width: 140px;'>기호번호 : <input type='text'
							name='addId' value='' style='width: 50px;'
							onkeyup="characterCheck(this)" onkeydown="characterCheck(this)"
							required></td>
						<td colspan='3' style='width: 180px;'>후보명 : <input
							type='text' name='addName' value='' style='width: 100px;'
							onkeyup="nameCheck(this)" onkeydown="nameCheck(this)" required></td>
						<td style='display: flex; justify-content: flex-end;'><input
							style='cursor: pointer;' class='button' type='submit' value='추가'
							formaction='./A_03.jsp' /></td>
					</tr>
				</form>
			</table>

		</div>
	</div>
</body>
</html>