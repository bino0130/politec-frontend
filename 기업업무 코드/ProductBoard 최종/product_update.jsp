<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*, java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 정보 업데이트</title>
<style>
table { /* table태그에 css적용 */
	width: 700px;
	height: 600px;
	border: 1px solid black;
	border-collapse: collapse;
	table-layout:fixed; 
	margin : auto;
}

td { /* td태그에 css 적용 */
	border: 1px solid black;
	padding-left: 15px;
}

.submit { /* class가 submit인 태그에 css 적용 */
	background-color : skyblue;
	border-color : skyblue;
	border-radius : 5px;
}

.two { /* class가 two인 태그에 css 적용 */
	width : 20%;
	background-color : skyblue;
}

#all { /* id가 all인 태그에 css 적용 */
	width : 800px;
	height : 930px;
	border : 1px solid black;
	border-collapse : collapse;
	margin : auto;
}

#twice { /* id가 twice인 태그에 css 적용 */
	width : 100%;
	text-align : center;
	border-bottom : 1px solid black;
	font-weight : 600;
	margin-bottom : 45px;
}

#area { /* id가 area인 태그에 css 적용 */
	overflow: auto; 
	border: 1px solid black; 
	resize: none; 
	width: 95%; 
	height: 95%;
}
</style>
<script>
function characterCheck(obj) { // 문자 체크하는 함수
  var regExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=\s]/gi; // 특수기호 체크
  var hanExp = /[ㄱ-ㅎㅏ-ㅣ]/g; // 한글 체크
  var engExp = /[a-zA-Z]/g; // 영어 체크
  var numExp = /^\d+$/; // 숫자 체크
  var num = parseInt(obj.value); // obj.value를 정수형으로 변경

  if (regExp.test(obj.value)) {
    alert("특수문자와 공백은 입력하실 수 없습니다."); // 특수문자, 공백 안내문구 출력
    obj.value = obj.value.replace(regExp, ""); // 입력값 초기화
  } else if (hanExp.test(obj.value)) {
    alert("한글은 사용하실 수 없습니다."); // 한글 안내문구 출력
    obj.value = obj.value.replace(hanExp, ""); // 입력값 초기화
  } else if (engExp.test(obj.value)) {
    alert("영어는 사용하실 수 없습니다."); // 영어 안내문구 출력
    obj.value = obj.value.replace(engExp, ""); // 입력값 초기화
  } else if (obj.value !== "" && (!numExp.test(obj.value) || num < 0 || num > 999999)) {
    alert("숫자는 0부터 999,999 사이의 값을 입력해야 합니다."); // 숫자 안내문구 출력
    obj.value = oobj.value.substring(0, 6); // 입력값 6자리까지만 substring
  }
}

function validateInput(element) { // 공백 체크하는 함수
  var value = element.value.trim(); // 양 끝 공백 제거
  
  if (value === '') { // 입력값이 공백이면
    element.setCustomValidity('공백만으로 이루어진 문자는 사용할 수 없습니다.'); // 안내문구 출력
  } else {
    var words = value.split(' '); // 공백을 기준으로 value를 나눠서 words에 대입
    var isValid = true; // boolean변수 isValid = true로 초기화
    
    for (var i = 0; i < words.length; i++) {
      if (words[i].trim() === '') {
        continue; // 공백만 있는 단어는 건너뛰고 다음 단어로 이동
      }
      isValid = true; // 유효한 단어를 발견한 경우 isValid 값을 true로 설정
      break; // 유효한 단어를 발견했으므로 반복문 종료
    }
    
    if (isValid) { // true라면
      element.setCustomValidity(''); // 유효성 검사 통과
    } else { // false라면
      element.setCustomValidity('공백만으로 이루어진 문자는 사용할 수 없습니다.'); // 안내문구 출력
    }
  }
}
</script>
</head>
<body>
<div id="all">
	<div id="twice"><p>(주)트와이스 재고 현황 - 재고수정</p></div>
<%
try { // 에러 처리
	request.setCharacterEncoding("utf-8"); // 인코딩 utf-8로 설정
	String ckey = request.getParameter("key"); // "key"를 parameter로 받는 String변수 ckey 생성

	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	sdf.setTimeZone(TimeZone.getTimeZone("Asia/Seoul")); // 한국 시간대로 설정
	Calendar c1 = Calendar.getInstance();
	String strToday = sdf.format(c1.getTime()); // 오늘 날짜구하는 String변수 strToday
	
	String Querytxt = String.format("select * from product where id = '%s'", ckey); // id가 ckey인 product테이블의 데이터 삭제
	ResultSet rset = stmt.executeQuery(Querytxt); // 쿼리 실행
	
	String itemNum = ""; // int변수 itemNum = 0으로 초기화
	String itemName = ""; // String변수 itemName = ""으로 초기화
	int itemCount = 0; // int변수 itemCount = 0으로 초기화
	String itemCheckDate = ""; // String변수 itemCheckDate = ""으로 초기화
	String itemRegiDate = ""; // String변수 itemRegiDate = ""으로 초기화
	String itemContent = ""; // String변수 itemContent = ""으로 초기화
	String imgUrl = ""; // String변수 imgUrl = ""으로 초기화
	
	while(rset.next()) {
		itemNum = rset.getString(1); // itemNum에 값 대입
		itemName = rset.getString(2); // itemName에 값 대입
		itemCount = rset.getInt(3); // itemCount에 값 대입
		itemCheckDate = strToday; // itemCheckDate에 값 대입
		itemRegiDate = rset.getString(5); // itemRegiDate에 값 대입
		itemContent = rset.getString(6); // itemContent에 값 대입
		imgUrl = rset.getString(7); // imgUrl에 값 대입
	}
	conn.close(); // 리소스 누설 방지
	stmt.close(); // 리소스 누설 방지
%>
<form method="post"> <%-- 데이터 값을 전달하는 form태그 --%>
			<table>
				<tr>
					<td class="two" style="height:15px;">상품 번호</td> <%-- 상품번호 --%>
					<td><%=itemNum%><input type="hidden" name="updateId" value="<%=itemNum%>"></td> <%-- 상품번호 출력, input hidden으로 값 전달 --%>
				</tr>
				<tr>
					<td class="two" style="height:15px;">상품명</td> <%-- 상품명 --%>
					<td><%=itemName%><input type="hidden" name="updateName" value="<%=itemName%>"></td> <%-- 상품명 출력, input hidden으로 값 전달 --%>
				</tr>
				<tr>
					<td class="two" style="height: 15px;">재고 현황</td> <%-- 재고 현황 --%>
					<td>
						<%-- 재고 현황 출력 --%>
						<input type="text" name="updateCount" oninput="characterCheck(this)" pattern="([1-9][0-9]{0,5}|1000000)|0" title="1부터 100만까지 입력가능" value="<%=itemCount%>" required>
					</td>
				</tr>
				<tr>
					<td class="two" style="height:15px;">상품등록일</td> <%-- 상품등록일 --%>
					<td><p style="margin:5px 0px;"><%=itemCheckDate%><input type="hidden" name="updateCheckDate" value="<%=itemCheckDate%>"></p></td> <%-- 상품등록일 출력, input hidden으로 값 전달 --%>
				</tr>
				<tr>
					<td class="two" style="height:15px;">재고등록일</td> <%-- 재고등록일 --%>
					<td><p style="margin:5px 0px;"><%=itemRegiDate%><input type="hidden" name="updateRegiDate" value="<%=itemRegiDate%>"></p></td> <%-- 재고등록일 출력, input hidden으로 값 전달 --%>
				</tr>
				<tr>
					<td class="two" style="height: 350px;">상품설명</td> <%-- 상품설명 --%>
					<td><textarea id="area" name="itemDescribe" readonly><%=itemContent%></textarea></td> <%-- 상품설명 출력 --%>
				</tr>
				<tr>
					<td class="two">상품사진</td> <%-- 상품사진 --%>
					<td>
						<div class="image-container">
    					<img style="width: 200px;" id="photo" src='<%= request.getContextPath() + "/image/" + imgUrl %>'> <%-- 상품사진 출력 --%>
						</div>
					</td>
				</tr>
			</table>
			<table style="height:30px; border:0px;">
				<tr>
					<td style="border:0px; text-align:right;">
						<input class="submit" type="submit" value="게시판으로 이동" formaction="product_list.jsp">
						<input class="submit" type="submit" value="재고 수정" formaction="product_write.jsp"> <%-- 재고 수정 버튼, product_write에 데이터 전달 --%>
					</td>
				</tr>
			</table>
	<%
} catch (NumberFormatException e) { // 에러 발생시
	%>
	<form method="post" action="product_list.jsp">
		<div><p style="text-align : center;">key 값이 비어있거나 key값에 정수가 들어오지 않았습니다.</p></div> <%-- 안내문구 출력 --%>
		<div style="text-align:center;"><input type="submit" value="게시판으로 이동"></div> <%-- 게시판 이동 버튼 --%>
	</form>
	<%
}
	%>
</form>
</div>
</body>
</html>