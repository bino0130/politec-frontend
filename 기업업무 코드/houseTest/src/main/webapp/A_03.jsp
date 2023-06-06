<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import = "java.sql.*, javax.sql.*,java.io.*,java.util.*" %>
<%
request.setCharacterEncoding("utf-8"); // 인코딩 utf-8로 설정
String name = request.getParameter("addName"); // input받은 addName 값 변수에 저장
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후보등록 - 등록결과(추가)</title>
<style>
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
	int min = 1; // int형 정수 min 0으로 초기화
	try { // try catch
		Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/kopo10", "root", "kopoctc");
	 	// localhost : 서버 IP주소, 3306 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
		// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	    Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	    
	    String Querytxt = "select id from kiho"; // kiho 테이블 전체 출력하는 쿼리
		ResultSet rset = stmt.executeQuery(Querytxt); // 쿼리 실행
		int cnt = 0; // cnt = 0으로 초기화
		while (rset.next()) { // rset이 있으면
			cnt++; // cnt + 1
		}
		
		if (cnt == 0) { // cnt가 0이면
			// kiho 테이블에서 비어있는 값의 최소값을 찾는 쿼리. 비어있지 않으면 마지막 데이터 + 1
			ResultSet idcount = stmt.executeQuery("select min(id) as minNum from kiho where (id+1) not in (select id from kiho);");
			while(idcount.next()){ // idcount가 있으면
	            min = idcount.getInt(1)+1; // min = getInt(1) + 1
	         }
	      }else{  // cnt가 0이 아닐때(값이 들어있다는 뜻)
	         // id 전체 값 조회
	         ResultSet idcount2 = stmt.executeQuery("select id from kiho");
	         while (idcount2.next()) { // idcount2가 있으면
	             int currentID = idcount2.getInt("id"); // getInt(id)값 currentID에 대입
	            // id 값과 currentID의 값이 일치하면 통과
	             if (min == currentID) { // min과 currentID가 같다면
	                min++; // min + 1
	             } else { // min과 currentID가 다르면
	                 break; // break
	             }
	         }
	      }
	
	// kiho테이블에 기호 n번, 후보자 이름 입력하는 쿼리
	String Querytxt2 = String.format("insert into kiho value (%d, '%s')", min, name);
	stmt.execute(Querytxt2); // 쿼리 실행
	%>
	<!-- border: 1px solid black, width : 900px, height : 800px, margin:auto인 div태그 -->
	<div style="border:1px solid black; width : 900px; height : 800px; margin: auto;">
		<div id=down> <!-- id가 down인 div 태그 -->
		
		<form method='post'> <!-- post방식 form 태그 -->
			<table class="blue1"> <!-- 클래스명이 blue1인 테이블 태그 -->
				<tr> <!-- table row -->
					<%-- 후보등록, 투표, 개표결과 메뉴 출력 --%>
					<td><input class="menu" style='background-color: yellow; cursor: pointer;' type='submit' value='후보등록' formaction="./A_01.jsp" /></td>
					<td><input class="menu" style='background-color: white; cursor: pointer;' type='submit' value='투표' formaction="./B_01.jsp" /></td>
					<td><input class="menu" style='background-color: white; cursor: pointer;' type='submit' value='개표결과' formaction="./C_01.jsp" /></td>
				</tr> <!-- table row -->
			</table> <!-- table close -->
		</form> <!-- form태그 닫힘 -->
		
		<span style="margin-left: 140px;"> <!-- margin-left가 140ox인 span 태그 -->
		<%
		out.println("후보등록 결과 : 기호 " + min + "번 " + name + " 후보가 추가되었습니다."); // 안내 메세지 출력
	} catch (SQLIntegrityConstraintViolationException e) {
	    out.println("기호번호 " + min +"번이 중복됩니다. 다른 기호번호를 선택해주세요."); // 에러 발생 시 에러 메세지 출력
	}
		%>
		</span>
		</div>
	</div>
</body>
</html>