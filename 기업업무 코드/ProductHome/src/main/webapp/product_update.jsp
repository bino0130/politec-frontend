<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*, java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 정보 업데이트</title>
<style>
table {
	width: 600px;
	height: 600px;
	border: 1px solid black;
	border-collapse: collapse;
	table-layout:fixed; 
}

td {
	border: 1px solid black;
	padding-left: 15px;
}

.two {
	width : 20%;
}

#all {
	width : 800px;
	height : 800px;
	border : 1px solid black;
	border-collapse : collapse;
	margin-top : 30px;
	margin-left : 75px;
}

#twice {
	width : 100%;
	text-align : center;
	border-bottom : 1px solid black;
	font-weight : 600
}

#area {
	overflow: auto; 
	border: 1px solid black; 
	resize: none; 
	width: 95%; 
	height: 85%;
}
</style>
<script>
//특수문자, 한글, 영어 입력 방지
function characterCheck(obj) {
  var regExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=\s]/gi;
  var hanExp = /[ㄱ-ㅎㅏ-ㅣ]/g; // 한글 입력 방지
  var engExp = /[a-zA-Z]/g; // 영어 입력 방지
  var numExp = /^[0-9]+$/; // 숫자 패턴 추가
  var num = parseInt(obj.value);

  if (regExp.test(obj.value)) {
   		alert("특수문자와 공백은 입력하실 수 없습니다.");
    	obj.value = obj.value.replace(regExp, ""); // 특수문자 제거
	} else if (hanExp.test(obj.value)) {
	  	alert("한글은 사용하실 수 없습니다.");
	  	obj.value = obj.value.replace(hanExp, ""); // 한글 제거
	} else if (engExp.test(obj.value)) {
	  	alert("영어는 사용하실 수 없습니다.");
	    obj.value = obj.value.replace(engExp, ""); // 영어 제거
	} else if (obj.value !== "" && (!numExp.test(obj.value) || num < 0 || num > 999999)) {
	    alert("숫자는 0부터 999,999 사이의 값을 입력해야 합니다.");
	    obj.value = ""; // 숫자 제거
	}
}
</script>
</head>
<body>
<div id="all">
	<div id="twice"><p>(주)트와이스 재고 현황 - 재고수정</p></div>
<%
try {
	request.setCharacterEncoding("utf-8"); // 인코딩 utf-8로 설정
	int ckey = Integer.parseInt(request.getParameter("key")); // "key"를 parameter로 받는 String변수 ckey 생성

	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Calendar c1 = Calendar.getInstance();
	String strToday = sdf.format(c1.getTime());
	
	String Querytxt = String.format("select * from product where id = %d", ckey);
	ResultSet rset = stmt.executeQuery(Querytxt);
	
	int itemNum = 0;
	String itemName = "";
	int itemCount = 0;
	String itemCheckDate = "";
	String itemRegiDate = "";
	String itemContent = "";
	String imgUrl = "";
	
	while(rset.next()) {
		itemNum = rset.getInt(1);
		itemName = rset.getString(2);
		itemCount = rset.getInt(3);
		itemCheckDate = strToday;
		itemRegiDate = strToday;
		itemContent = rset.getString(6);
		imgUrl = rset.getString(7);
	}
	conn.close();
	stmt.close();
%>
<form method="post">
			<table style="margin-top:30px; margin-left:120px;">
				<tr>
					<td class="two" style="height:15px;">상품 번호</td>
					<td><%=itemNum%><input type="hidden" name="updateId" value="<%=itemNum%>"></td>
				</tr>
				<tr>
					<td class="two" style="height:10%;">상품명</td>
					<td><p><%=itemName%><input type="hidden" name="updateName" value="<%=itemName%>"></p></td>
				</tr>
				<tr>
					<td class="two" style="height: 10%;;">재고 현황</td>
					<td><input type="text" name="updateCount" onkeydown="characterCheck(this)" value="<%=itemCount%>"></td>
				</tr>
				<tr>
					<td class="two" style="height:20px;">상품등록일</td>
					<td><p><%=itemCheckDate%><input type="hidden" name="updateCheckDate" value="<%=itemCheckDate%>"></p></td>
				</tr>
				<tr>
					<td class="two" style="height:15px;">재고등록일</td>
					<td><p><%=itemRegiDate%><input type="hidden" name="updateRegiDate" value="<%=itemRegiDate%>"></p></td>
				</tr>
				<tr>
					<td class="two" style="height: 15px;">상품설명</td>
					<td><textarea id="area" name="itemDescribe" maxlength="600" readonly><%=itemContent%></textarea></td>
				</tr>
				<tr>
					<td class="two">상품사진</td>
					<td><div class="image-container">
    					<img style="width: 300px;" id="photo" src='<%= request.getContextPath() + "/image/" + imgUrl %>'>
					</div></td>
				</tr>
			</table>
			<table style="height:30px; border:0px; margin-top:30px; margin-left:120px;">
				<tr>
					<td style="border:0px; text-align:right;">
						<input type="submit" value="재고 수정" formaction="product_write.jsp">
					</td>
				</tr>
			</table>
	<%
} catch (NumberFormatException e) {
	%>
		<div><p style="text-align : center;">key 값이 비어있거나 key값에 정수가 들어오지 않았습니다.</p></div>
	<%
}
	%>
</form>
</div>
</body>
</html>