<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*, java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>상품 상세페이지</title>
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
</head>
<body>
<div id="all">
	<div id="twice"><p>(주)트와이스 재고 현황 - 상품상세</p></div>
<%
try {
	//product_insert로부터 "autoId"를 parameter로 받는 int형 변수 autoId 생성
	request.setCharacterEncoding("utf-8"); // 인코딩 utf-8로 설정
	int ckey = Integer.parseInt(request.getParameter("key")); // "key"를 parameter로 받는 String변수 ckey 생성
	
	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성

	ResultSet rset1 = stmt.executeQuery("select id from product");
	List<Integer> idList = new ArrayList<Integer>();
	while(rset1.next()) {
		idList.add(rset1.getInt(1));
	}

	if (idList.contains(ckey)) {
	
	String Querytxt = String.format("select * from product where id = %d", ckey);
	ResultSet rset2 = stmt.executeQuery(Querytxt);
	
	int itemNum = 0;
	String itemName = "";
	int itemCount = 0;
	String itemCheckDate = "";
	String itemRegiDate = "";
	String itemContent = "";
	String imgUrl = "";
	
	while(rset2.next()) {
		itemNum = rset2.getInt(1);
		itemName = rset2.getString(2);
		itemCount = rset2.getInt(3);
		itemCheckDate = rset2.getString(4);
		itemRegiDate = rset2.getString(5);
		itemContent = rset2.getString(6);
		imgUrl = rset2.getString(7);
	}
%>
<form method="post">
			<table style="margin-top:30px; margin-left:120px;">
				<tr>
					<td class="two" style="height:15px;">상품 번호</td>
					<td><%=itemNum%><input type="hidden" name="key" value="<%=itemNum%>"></td>
				</tr>
				<tr>
					<td class="two" style="height:10%;">상품명</td>
					<td><%=itemName%><input type="hidden" name="itemName" value="<%=itemName%>"></td>
				</tr>
				<tr>
					<td class="two" style="height: 10%;;">재고 현황</td>
					<td><p><%=itemCount%></p></td>
				</tr>
				<tr>
					<td class="two" style="height:15px;">상품등록일</td>
					<td><p><%=itemCheckDate%></p></td>
				</tr>
				<tr>
					<td class="two" style="height:15px;">재고등록일</td>
					<td><p><%=itemRegiDate%></p></td>
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
						<input type="submit" value='상품 삭제' formaction="product_delete.jsp">
						<input type="submit" value="재고 수정" formaction="product_update.jsp">
					</td>
				</tr>
			</table>
	<%
		} else {
			out.println("데이터가 일치하지 않습니다.");
	%>
		<input type="submit" value="뒤로가기" onclick="history_back()">
		<script>
			function history_back() {
				history.back();
			}
		</script>
	<%
		}
				conn.close();
		    	stmt.close();
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