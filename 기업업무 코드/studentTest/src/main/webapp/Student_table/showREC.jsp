<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import = "java.sql.*, javax.sql.*,java.io.*" %>
<%
request.setCharacterEncoding("utf-8");
String searchID = request.getParameter("searchID"); // input받은 searchID 값 변수에 저장
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
	table {
		width : 400px;
	}
	
	p {
		text-align : center;
	}
	
	.one {
		width : 100px;
	}
	
	.two {
		width : 200px;
	}
	
	.three {
		width : 300px;
	}
	
	.gray {
		background-color : lightgray;
	}
	
	.right {
		text-align : right;
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
	String Querytxt = String.format("select * from anotherTwice where studentid = %d", Integer.parseInt(searchID));
	ResultSet rset = stmt.executeQuery(Querytxt);
	int LineCnt = 0;
	String name = "";
	int id = 0;
	int kor = 0;
	int eng = 0;
	int mat = 0;
	
	while (rset.next()) {
		name = rset.getString(1);
		id = rset.getInt(2);
		kor = rset.getInt(3);
		eng = rset.getInt(4);
		mat = rset.getInt(5);
		LineCnt++;
	}
	
	if (LineCnt == 0) {
%>
	<table cellspacing=1 border=0>
		<tr>
			<td class="one"><p>조회할 학번</p></td>
			<td class="two"><p><input type='text' name='searchID' value='해당학번없음' readonly></p></td>
			<td class="one"><input type="submit" value="조회"></td>
		</tr>
	</table>
	<table cellspacing=1 border=1>
		<tr>
			<td class="one"><p>이름</p></td>
			<td class="three"><p><input class="gray" type='text' name='' value='' readonly></p></td>
		</tr>
		<tr>
			<td class="one"><p>학번</p></td>
			<td class="three"><p><input class="gray" type='text' name='' value='' readonly></p></td>
		</tr>
		<tr>
			<td class="one"><p>국어</p></td>
			<td class="three"><p><input class="gray" type='text' name='korean' value='' readonly></p></td>
		</tr>
		<tr>
			<td class="one"><p>영어</p></td>
			<td class="three"><p><input class="gray" type='text' name='english' value='' readonly></p></td>
		</tr>
		<tr>
			<td class="one"><p>수학</p></td>
			<td class="three"><p><input class="gray" type='text' name='math' value='' readonly></p></td>
		</tr>
	</table>
	<table border=0>
		<tr class="right">
			<td><input type="submit" value="수정"></td>
			<td><input type="submit" value="삭제"></td>
		</tr>
	</table>
<%
	} else if (LineCnt != 0) {
%>
	<table cellspacing=1 border=0>
		<tr>
			<td class="one"><p>조회할 학번</p></td>
			<td class="two"><p><input type='text' name='searchID' value='<%=searchID%>'></p></td>
			<td class="one"><input type="submit" value="조회"></td>
		</tr>
	</table>
	<table cellspacing=1 border=1>
		<tr>
			<td class="one"><p>이름</p></td>
			<td class="three"><p><input type='text' name='name' value='<%=name%>'></p></td>
		</tr>
		<tr>
			<td class="one"><p>학번</p></td>
			<td class="three"><p><input type='text' name='studentID' value='<%=id%>'></p></td>
		</tr>
		<tr>
			<td class="one"><p>국어</p></td>
			<td class="three"><p><input type='text' name='korean' value='<%=kor%>'></p></td>
		</tr>
		<tr>
			<td class="one"><p>영어</p></td>
			<td class="three"><p><input type='text' name='english' value='<%=eng%>'></p></td>
		</tr>
		<tr>
			<td class="one"><p>수학</p></td>
			<td class="three"><p><input type='text' name='math' value='<%=mat%>'></p></td>
		</tr>
	</table>
	<table border=0>
		<tr class="right">
			<td><input type="submit" value="수정"></td>
			<td><input type="submit" value="삭제"></td>
		</tr>
	</table>
<%
	}
%>
</body>
</html>