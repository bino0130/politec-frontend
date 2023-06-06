<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*"%>
<%
request.setCharacterEncoding("utf-8"); // 인코딩 utf-8로 설정
String name = request.getParameter("name"); // input받은 username 값 변수에 저장
String kor = request.getParameter("korean"); // input받은 korean 값 변수에 저장
String eng = request.getParameter("english"); // input받은 english 값 변수에 저장
String mat = request.getParameter("math"); // input받은 mat 값 변수에 저장
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
table { /*table 태그에 너비 400px 적용 */
	width: 400px;
}

.one { /* class가 one인 태그에 너비 100px 적용 */
	width: 100px;
}

.three { /* class가 three인 태그에 너비 300px 적용 */
	width: 300px;
}

p { /* p 태그에 텍스트 가운데정렬 margin:auto로 p태그 자체 가운데정렬 */
	text-align: center;
	margin: auto;
}

input { /* input태그에 텍스트 가운데정렬 */
	text-align: center
}
</style>
</head>
<body>
<h1>성적입력추가완료</h1> <%-- h1태그 사용 --%>
	<%
	try { // try catch
	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	
	int min = 0; // int형 정수 min 0으로 초기화
	
	// 비어있는 학번 확인하고 해당 값 채우거나 학번이 비어있지 않은 경우 최대값 + 1 하는 쿼리
	ResultSet settotal = stmt.executeQuery("select min(studentid) as minNum from anotherTwice where (studentid+1) not in (select studentid from anotherTwice);");
	while(settotal.next()) { // settotal이 있을떄 작동하는 반복문
		min = settotal.getInt(1) + 1; // min = getInt(1) + 1
		if (min == 1) { // 데이터가 아무것도 없을 경우에 min은 1로 설정된다
			min = 209901; // 이때 min을 209901로 설정
		}
	}
	
	// 테이블에 값 추가하는 쿼리
	String insertQuery = String.format("insert into anotherTwice values ('%s', %d, %d, %d, %d)", name, min, Integer.parseInt(kor), Integer.parseInt(eng), Integer.parseInt(mat));
	stmt.executeUpdate(insertQuery); // 쿼리 실행
	%>
<form method="post" action="InputForm1.html"> <%-- 버튼을 눌렀을 때 InputForm1.html에 값을 전달하는 form태그 --%>
	<table cellspacing=1 border=0> <%-- 테이블 시작 --%>
		<tr>
			<td class="three"></td> <%-- class명이 three인 td태그 --%>
			<td class="one"><input type="submit" value="뒤로가기"></td> <%-- 클래스명이 one인 td태그 안에 뒤로가기 버튼 --%>
		</tr>
	</table> <%-- 테이블 끝 --%>

	<table cellspacing=1 border=1px solid black> <%-- 테이블 시작 --%>
		<tr>
			<td class="one"><p>이름</p></td> <%-- 클래스명이 one인 td 태그 --%>
			<td class="three"><p> <%-- 클래스명이 three인 td 태그 --%>
					<input type='text' name='name' value='<%=name%>' readonly> <!-- name을 전달하는 input태그 (readonly) -->
				</p></td>
		</tr>
		<tr>
			<td class="one"><p>학번</p></td> <%-- 클래스명이 one인 td 태그 --%>
			<td class="three"><p><%=min%></p></td> <%-- 클래스명이 three인 td 태그, 학번 출력 --%>
		</tr>
		<tr>
			<td class="one"><p>국어</p></td> <%-- 클래스명이 one인 td 태그 --%>
			<td class="three"><p> <%-- 클래스명이 three인 td 태그 --%>
					<input type='text' name='korean' value='<%=kor%>' readonly> <!-- korean을 전달하는 input태그 (readonly) -->
				</p></td>
		</tr>
		<tr>
			<td class="one"><p>영어</p></td> <%-- 클래스명이 one인 td 태그 --%>
			<td class="three"><p> <%-- 클래스명이 three인 td 태그 --%>
					<input type='text' name='english' value='<%=eng%>' readonly> <!-- english를 전달하는 input태그 (readonly) -->
				</p></td>
		</tr>
		<tr>
			<td class="one"><p>수학</p></td> <%-- 클래스명이 one인 td 태그 --%>
			<td class="three"><p> <%-- 클래스명이 three인 td 태그 --%>
					<input type='text' name='math' value='<%=mat%>' readonly> <!-- math를 전달하는 input태그 (readonly) -->
				</p></td>
		</tr>
	</table> <%-- 테이블 끝 --%>
</form>
<%
	stmt.close(); // 리소스 정리
	conn.close(); // 리소스 정리
	} catch (SQLSyntaxErrorException e) {
		out.println("테이블이 생성되지 않았습니다. 테이블을 생성해주세요."); // 에러 메세지 출력
	}
%>
</body>
</html>