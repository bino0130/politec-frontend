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
		width : 600px;
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
	
	input {
		text-align : center
	}
</style>
<script>
// 특수문자 입력 방지
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
  } else if (obj.value !== "" && (!numExp.test(obj.value) || num < 0 || num > 100)) {
    alert("숫자는 0부터 100 사이의 값을 입력해야 합니다.");
    obj.value = "";
  }
}

function nameCheck(obj) {
	  var regExp = /[~`!@#$%^&*()\-_=+[{\]}\\|;:'",<.>/?]/gi;

	  if (obj.value.length > 10) {
	    alert("이름은 최대 10자까지 입력할 수 있습니다.");
	    obj.value = obj.value.substring(0, 10); // 최대 길이만큼 잘라내기
	  }

	  if (regExp.test(obj.value)) {
	    alert("이름에는 특수문자를 사용할 수 없습니다.");
	    obj.value = obj.value.replace(regExp, ""); // 특수문자 제거
	  }
}
</script>
</head>
<body>
<%
	try {
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
<form method='post' action="showREC.jsp">
	<table cellspacing=1 border=0>
		<tr>
			<td class="one"><p>조회할 학번</p></td>
			<td class="two"><p><input type='text' name='searchID' value='' ></p></td>
			<td class="one"><input type="submit" value="조회"></td>
		</tr>
	</table>
</form>
	<table cellspacing=1 border=1>
		<tr>
			<td class="one"><p>이름</p></td>
			<td class="three"><p><input class="gray" type='text' name='' value='해당학번없음' readonly></p></td>
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
<%
	} else if (LineCnt != 0) {
%>
<form method='post' action="showREC.jsp">
	<table cellspacing=1 border=0>
		<tr>
			<td class="one"><p>조회할 학번</p></td>
			<td class="two"><p><input type='text' name='searchID' value='<%=searchID%>' onkeyup="characterCheck(this)" onkeydown="characterCheck(this)" required></p></td>
			<td class="one"><input type="submit" value="조회"></td>
		</tr>
	</table>
</form>
<form method='post'>
	<table cellspacing=1 border=1>
		<tr>
			<td class="one"><p>이름</p></td>
			<td class="three"><p><input type='text' name='name' value='<%=name%>' onkeyup="nameCheck(this)" onkeydown="nameCheck(this)" required></p></td>
		</tr>
		<tr>
			<td class="one"><p>학번</p></td>
			<td class="three"><p><input type='text' name='studentID' value='<%=id%>' readonly></p></td>
		</tr>
		<tr>
			<td class="one"><p>국어</p></td>
			<td class="three"><p><input type='text' name='korean' value='<%=kor%>' onkeyup="characterCheck(this)" onkeydown="characterCheck(this)" required></p></td>
		</tr>
		<tr>
			<td class="one"><p>영어</p></td>
			<td class="three"><p><input type='text' name='english' value='<%=eng%>' onkeyup="characterCheck(this)" onkeydown="characterCheck(this)" required></p></td>
		</tr>
		<tr>
			<td class="one"><p>수학</p></td>
			<td class="three"><p><input type='text' name='math' value='<%=mat%>' onkeyup="characterCheck(this)" onkeydown="characterCheck(this)" required></p></td>
		</tr>
	</table>
	<table border=0>
		<tr class="right">
			<td style="width : 70%;">
				<input type="submit" value="수정" formaction="./updateDB.jsp"/>
			</td>
			<td style="width : 30%;">
				<input type="submit" value="삭제" formaction="./deleteDB.jsp"/>
			</td>
		</tr>
	</table>
</form>	
<%
	}
	rset.close();
	stmt.close(); // 리소스 정리
	conn.close(); // 리소스 정리
	} catch (SQLSyntaxErrorException e) {
		out.println("테이블이 생성되지 않았습니다. 테이블을 생성해주세요.");
	}
%>
</body>
</html>