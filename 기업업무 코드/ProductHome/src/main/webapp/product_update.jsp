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
</style>
</head>
<body>
<div id="all">
	<div id="twice"><p>(주)트와이스 재고 현황 - 재고수정</p></div>
<%
	request.setCharacterEncoding("utf-8"); // 인코딩 utf-8로 설정
	int ckey = Integer.parseInt(request.getParameter("key")); // "key"를 parameter로 받는 String변수 ckey 생성

	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 3306 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
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
%>
<form method="post">
			<table style="margin-top:50px; margin-left:100px;">
				<tr>
					<td class="two" style="height:15px;">상품 번호</td>
					<td><%=itemNum%><input type="hidden" name="updateId" value="<%=itemNum%>"></td>
				</tr>
				<tr>
					<td class="two" style="height:15px;">상품명</td>
					<td><p><%=itemName%></p></td>
				</tr>
				<tr>
					<td class="two" style="height:15px;">재고 현황</td>
					<td><input type="text" name="updateCount" value="<%=itemCount%>"></td>
				</tr>
				<tr>
					<td class="two" style="height:15px;">상품등록일</td>
					<td><p><%=itemCheckDate%><input type="hidden" name="updateCheckDate" value="<%=itemCheckDate%>"></p></td>
				</tr>
				<tr>
					<td class="two" style="height:15px;">재고등록일</td>
					<td><p><%=itemRegiDate%><input type="hidden" name="updateRegiDate" value="<%=itemRegiDate%>"></p></td>
				</tr>
				<tr>
					<td class="two" style="height: 15px;">상품설명</td>
					<td><p><%=itemContent%></p></td>
				</tr>
				<tr>
					<td class="two">상품사진</td>
					<td><div class="image-container">
    					<img style="width: 300px;" id="photo" src="<%=imgUrl%>">
					</div></td>
				</tr>
				<%
				conn.close();
		    	stmt.close();
				%>
			</table>
			<table style="height:30px; border:0px; margin-top:30px; margin-left:75px;">
				<tr>
					<td style="border:0px; text-align:right;">
						<input type="submit" value="재고 수정" formaction="product_write.jsp">
					</td>
				</tr>
			</table>
</form>
</div>
</body>
</html>