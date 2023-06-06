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
	table { /* table 태그 셀렉터로 css 지정 */
		width : 600px;
	}
	
	p { /* p 태그 셀렉터로 css 지정 */
		text-align : center;
	}
	
	.one { /* 클래스명이 one인 태그에 css 지정 */
		width : 100px;
	}
	
	.two { /* 클래스명이 two인 태그에 css 지정 */
		width : 200px;
	}
	
	.three { /* 클래스명이 three인 태그에 css 지정 */
		width : 300px;
	}
	
	.gray { /* 클래스명이 gray인 태그에 css 지정 */
		background-color : lightgray;
	}
	
	.right { /* 클래스명이 right인 태그에 css 지정 */
		text-align : right;
	}
	
	input { /* input태그 셀렉터로 css 지정 */
		text-align : center
	}
</style>
<script>
// 특수문자, 한글, 영어 입력 방지
function characterCheck(obj) {
  var regExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
  var hanExp = /[ㄱ-ㅎㅏ-ㅣ]/g; // 한글 입력 방지
  var engExp = /[a-zA-Z]/g; // 영어 입력 방지
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
    obj.value = ""; // 숫자 제거
  }
}

function nameCheck(obj) {
	// 특수문자 및 공백 입력 방지
	var regExp = /[~`!@#$%^&*()\-_=+[{\]}\\|;:'",<.>/?\s]/gi;

	if (regExp.test(obj.value)) { // 특수문자나 공백이 입력되면
		alert("이름에는 특수문자와 공백을 사용할 수 없습니다."); // 안내메세지 출력
		obj.value = obj.value.replace(regExp, ""); // 특수문자와 공백 제거
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
	
	// 학번이 serachID와 일치하는 데이터 출력하는 쿼리
	String Querytxt = String.format("select * from anotherTwice where studentid = %d", Integer.parseInt(searchID));
	ResultSet rset = stmt.executeQuery(Querytxt); // 쿼리 실행
	int LineCnt = 0; // lineCnt = 0으로 초기화
	String name = ""; // name = ""으로 초기화
	int id = 0; // id = 0으로 초기화
	int kor = 0; // kor = 0으로 초기화
	int eng = 0; // eng = 0으로 초기화
	int mat = 0; // mat = 0으로 초기화
	
	while (rset.next()) { // rset이 있으면
		name = rset.getString(1); // name에 getString(1) 저장
		id = rset.getInt(2); // id에 getInt(2) 저장
		kor = rset.getInt(3); // kor에 getInt(3) 저장
		eng = rset.getInt(4); // eng에 getInt(4) 저장
		mat = rset.getInt(5); // mat에 getInt(5) 저장
		LineCnt++; // LineCnt + 1
	}
	
	if (LineCnt == 0) { // LineCnt가 0이면 (조회한 학번이 없으면)
%>
<form method='post' action="showREC.jsp"> <!-- 입력받은 데이터를 post형식으로 showREC에 전달 -->
	<table cellspacing=1 border=0>
		<tr> <!-- table row -->
			<td class="one"><p>조회할 학번</p></td> <!-- 조회할 학번 -->
			<td class="two"><p><input type="text" pattern="^(?:999999|[1-9][0-9]{0,8}?|0)$" name='searchID' value=''
							title="0~999999까지의 정수를 입력하세요" style="background-color:white" ; required></p></td> <!-- searchID값을 전달하는 input태그 -->
			<td class="one"><input type="submit" value="조회"></td> <!-- 조회 버튼 형태의 input 태그 -->
		</tr> <!-- table row -->
	</table>
</form>
	<table cellspacing=1 border=1>
		<tr> <!-- table row -->
			<td class="one"><p>이름</p></td> <!-- 이름 -->
			<td class="three"><p><input class="gray" type='text' name='' value='해당학번없음' readonly></p></td> <!-- value로 해당학번없음을 출력하는 input태그 (readonly) -->
		</tr> <!-- table row -->
		<tr> <!-- table row -->
			<td class="one"><p>학번</p></td> <!-- 학번 -->
			<td class="three"><p><input class="gray" type='text' name='' value='' readonly></p></td> <!-- 아무것도 출력되지않음 -->
		</tr> <!-- table row -->
		<tr> <!-- table row -->
			<td class="one"><p>국어</p></td> <!-- 국어 -->
			<td class="three"><p><input class="gray" type='text' name='korean' value='' readonly></p></td> <!-- 아무것도 출력되지않음 -->
		</tr> <!-- table row -->
		<tr> <!-- table row -->
			<td class="one"><p>영어</p></td> <!-- 영어 -->
			<td class="three"><p><input class="gray" type='text' name='english' value='' readonly></p></td> <!-- 아무것도 출력되지않음 -->
		</tr> <!-- table row -->
		<tr> <!-- table row -->
			<td class="one"><p>수학</p></td> <!-- 수학 -->
			<td class="three"><p><input class="gray" type='text' name='math' value='' readonly></p></td> <!-- 아무것도 출력되지않음 -->
		</tr> <!-- table row -->
	</table>
<%
	} else if (LineCnt != 0) { // LineCnt가 0이 아니면 (조회한 학번이 존재하면)
%>
<form method='post' action="showREC.jsp"> <!-- 입력받은 데이터를 post형식으로 showREC에 전달 -->
	<table cellspacing=1 border=0>
		<tr> <!-- table row -->
			<td class="one"><p>조회할 학번</p></td> <!-- 조회할 학번 -->
			<!-- parameter로 받은 searchID를 출력하고 searchID 값을 전달하는 input태그 (required) -->
			<td class="two"><p><input type="text" pattern="^(?:999999|[1-9][0-9]{0,8}?|0)$" name='searchID' value=''
							title="0~999999까지의 정수를 입력하세요" style="background-color:white" ; required></p></td>
			<td class="one"><input type="submit" value="조회"></td> <!-- 조회 버튼 형태의 input 태그 -->
		</tr> <!-- table row -->
	</table>
</form>
<form method='post'>
	<table cellspacing=1 border=1>
		<tr> <!-- table row -->
			<td class="one"><p>이름</p></td> <!-- 이름 -->
			<!-- parameter로 받은 name을 출력하고 name 값을 전달하는 input태그 (required) -->
			<td class="three"><p><input type='text' name='name' value='<%=name%>' onkeyup="nameCheck(this)" maxlength="10" required></p></td>
		</tr> <!-- table row -->
		<tr> <!-- table row -->
			<td class="one"><p>학번</p></td> <!-- 학번 -->
			<!-- parameter로 받은 id를 출력하고 studentID 값을 전달하는 input태그 (readonly) -->
			<td class="three"><p><input type='text' name='studentID' value='<%=id%>' readonly></p></td>
		</tr> <!-- table row -->
		<tr> <!-- table row -->
			<td class="one"><p>국어</p></td> <!-- 국어 -->
			<!-- parameter로 받은 korean을 출력하고 korean 값을 전달하는 input태그 (required) -->
			<td class="three"><p><input type='text' name='korean' value='<%=kor%>' onkeyup="characterCheck(this)" required></p></td>
		</tr> <!-- table row -->
		<tr> <!-- table row -->
			<td class="one"><p>영어</p></td> <!-- 영어 -->
			<!-- parameter로 받은 english를 출력하고 english 값을 전달하는 input태그 (required) -->
			<td class="three"><p><input type='text' name='english' value='<%=eng%>' onkeyup="characterCheck(this)" required></p></td>
		</tr> <!-- table row -->
		<tr> <!-- table row -->
			<td class="one"><p>수학</p></td> <!-- 수학 -->
			<!-- parameter로 받은 math를 출력하고 math 값을 전달하는 input태그 (required) -->
			<td class="three"><p><input type='text' name='math' value='<%=mat%>' onkeyup="characterCheck(this)" required></p></td>
		</tr> <!-- table row -->
	</table>
	<table border=0>
		<tr class="right"> <!-- table row -->
			<td style="width : 70%;"> <!-- 너비 70% td 태그 -->
				<input type="submit" value="수정" formaction="./updateDB.jsp"/> <!-- updateDB에 값을 전달하는 수정 버튼 input태그 -->
			</td>
			<td style="width : 30%;"> <!-- 너비 30% td 태그 -->
				<input type="submit" value="삭제" formaction="./deleteDB.jsp"/> <!-- deleteDB에 값을 전달하는 삭제 버튼 input태그 -->
			</td>
		</tr> <!-- table row -->
	</table>
</form>	
<%
	}
	rset.close();
	stmt.close(); // 리소스 정리
	conn.close(); // 리소스 정리
	} catch (SQLSyntaxErrorException e) {
		out.println("테이블이 생성되지 않았습니다. 테이블을 생성해주세요."); // 에러발생시 에러 메세지 출력
	}
%>
</body>
</html>