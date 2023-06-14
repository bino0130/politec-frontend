<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*, java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>상품 상세페이지</title>
<style>
table { /* table태그에 css 적용 */
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

.two { /* class가 two인 태그에 css 적용 */
	width : 20%;
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
</head>
<body>
<div id="all">
	<div id="twice"><p>(주)트와이스 재고 현황 - 상품상세</p></div> <%-- 제목 출력 --%>
<%
try{
	//product_insert로부터 "autoId"를 parameter로 받는 int형 변수 autoId 생성
	request.setCharacterEncoding("utf-8"); // 인코딩 utf-8로 설정
	String ckey = request.getParameter("key"); // "key"를 parameter로 받는 String변수 ckey 생성
	
	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성

	ResultSet rset1 = stmt.executeQuery("select id from product"); // product테이블에서 id값 출력
	List<String> idList = new ArrayList<String>(); // id 담는 idList
	while(rset1.next()) {
		idList.add(rset1.getString(1)); // idList에 출력된 id값 넣음
	}

	if (idList.contains(ckey)) { // idList가 ckey를 포함한다면
	
	String Querytxt = String.format("select * from product where id = '%s'", ckey); // product테이블에서 id가 ckey인 데이터 출력
	ResultSet rset2 = stmt.executeQuery(Querytxt); // 쿼리 실행
	
	String itemNum = ""; // int 변수 itemNum = 0으로 초기화
	String itemName = ""; // String변수 itemName = ""으로 초기화
	int itemCount = 0; // int변수 itemCount = 0으로 초기화
	String itemCheckDate = ""; // String변수 itemCheckDate = ""으로 초기화
	String itemRegiDate = ""; // String변수 itemRegiDate = ""으로 초기화
	String itemContent = ""; // String변수 itemContent = ""으로 초기화
	String imgUrl = ""; // String변수 imgUrl = ""으로 초기화
	
	while(rset2.next()) {
		itemNum = rset2.getString(1); // itemNum에 값 대입
		itemName = rset2.getString(2); // itemName에 값 대입
		itemCount = rset2.getInt(3); // itemCount에 값 대입
		itemCheckDate = rset2.getString(4); // itemCheckDate에 값 대입
		itemRegiDate = rset2.getString(5); // itemRegiDate에 값 대입
		itemContent = rset2.getString(6); // itemContent에 값 대입
		imgUrl = rset2.getString(7); // imgUrl에 값 대입
	}
%>
<form method="post"> <%-- 데이터 전달하는 form태그 --%>
			<table>
				<tr>
					<td class="two" style="height:15px;">상품 번호</td> <%-- 상품 번호 --%>
					<td><%=itemNum%><input type="hidden" name="key" value="<%=itemNum%>"></td> <%-- 상품번호 출력, input hidden으로 값 전달 --%>
				</tr>
				<tr>
					<td class="two" style="height:15px;">상품명</td> <%-- 상품명 --%>
					<td><%=itemName%><input type="hidden" name="itemName" value="<%=itemName%>"></td> <%-- 상품명 출력, input hidden으로 값 전달 --%>
				</tr>
				<tr>
					<td class="two" style="height:15px;">재고 현황</td> <%-- 재고 현황 --%>
					<td><%=itemCount%></td> <%-- 재고 현황 출력 --%>
				</tr>
				<tr>
					<td class="two" style="height:15px;">상품등록일</td> <%-- 상품등록일 --%>
					<td><p style="margin:5px 0px;"><%=itemCheckDate%></p></td> <%-- 상품등록일 출력 --%>
				</tr>
				<tr>
					<td class="two" style="height:15px;">재고등록일</td> <%-- 재고등록일 --%>
					<td><p style="margin:5px 0px;"><%=itemRegiDate%></p></td> <%-- 재고등록일 출력 --%>
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
					<td style="border:0px; text-align:right;"> <%-- 오른쪽 정렬 --%>
						<input type="submit" value="게시판으로 이동" formaction="product_list.jsp">
						<input type="submit" value='상품 삭제' formaction="product_delete.jsp"> <%-- 상품 삭제버튼, product_delete에 값 전달 --%>
						<input type="submit" value="재고 수정" formaction="product_update.jsp"> <%-- 재고 수정버튼, product_update에 값 전달 --%>
					</td>
				</tr>
			</table>
	<%
		} else { // ckey가 idList에 포함되지 않는다면
	%>
	<form method="post" action="product_list.jsp">
		<div><p style="text-align:center;">데이터가 일치하지 않습니다.</p></div> <%-- 안내문구 출력 --%>
		<div style="text-align:center;"><input type="submit" value="게시판으로 이동"></div> <%-- 게시판 이동 버튼 --%>
	</form>
	<%
	}
} catch (NumberFormatException e) { // 에러 발생시
	%>
	<form method="post" action="product_list.jsp">
		<div><p style="text-align : center;">key 값이 비어있거나 key값에 정수가 들어오지 않았습니다.</p></div> <%--안내문구 출력--%>
		<div style="text-align:center;"><input type="submit" value="게시판으로 이동"></div> <%-- 게시판 이동 버튼 --%>
	</form>
	<%
}
	%>
</form>
</div>
</body>
</html>