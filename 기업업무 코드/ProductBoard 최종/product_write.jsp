<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*, 
java.text.*, com.oreilly.servlet.MultipartRequest, com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>등록 완료</title>
<style>
table { /* table태그에 css 적용 */
	border-collapse : collapse;
	border : 1px solid black;
	width : 500px;
	height : 400px;
	margin : auto;
}

td { /* td태그에 css 적용 */
	border : 1px solid black;
}
</style>
</head>
<body>
<%
try {
	request.setCharacterEncoding("utf-8"); // 인코딩 utf-8로 설정
	//product_update로부터 "updateId"를 parameter로 받는 int형 변수 printId 생성
	String updateId = request.getParameter("updateId");

	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	
	if (updateId == null) { // 만약 updateId가 null이라면 -> autoId에 값이 전달되었다면
		int sizeLimit = 100 * 500 * 500; // 이미지 사이즈 100*500*500으로 설정
		String path = "./image"; // String변수 path에 이미지 저장할 경로 설정
		String directory = request.getServletContext().getRealPath(path); // String변수 directory에 실제 저장 경로 대입
		// Multipart form data를 파싱하는 MultipartRequest
		MultipartRequest multi = new MultipartRequest(request, directory, sizeLimit, "UTF-8", new DefaultFileRenamePolicy());
		
		request.setCharacterEncoding("utf-8"); // 인코딩 utf-8로 설정

		//product_insert로부터 "newId"를 parameter로 받는 String 변수 id 생성
		String newId = multi.getParameter("newId");
		
		String filename = multi.getFilesystemName("imgFile"); // "imgFile"을 parameter로 받는 String변수 filename 설정

		String itemName = multi.getParameter("itemName"); // 전달받은 데이터 가져오기
		itemName = itemName.replace("&","&amp;").replace("<", "&lt;").replace(">", "&gt;"); // &, <, > 문자 대체

		int itemCount = Integer.parseInt(multi.getParameter("itemCount")); // "itemCount"를 parameter로 받는 int변수 itemCount 설정
		String checkDay = multi.getParameter("checkDay"); // "checkDay"를 parameter로 받는 String 변수 checkDay 설정

		String itemDescribe = multi.getParameter("itemDescribe"); // 전달받은 데이터 가져오기
		itemDescribe = itemDescribe.replace("&","&amp;").replace("<", "&lt;").replace(">", "&gt;"); // &, <, > 문자 대체
		
		// String변수 Querytxt에 product에 데이터를 입력하는 쿼리 대입
		String Querytxt = String.format("insert into product values ('%s', '%s', %d, '%s', '%s', '%s', '%s')"
		,newId,itemName, itemCount, checkDay, checkDay, itemDescribe, "./"+filename);
		
		stmt.execute(Querytxt); // 쿼리 실행
		
%>
<form method="post" action="product_list.jsp"> <%-- product_list에 값을 전달하는 form태그 --%>
	<table>
		<tr>
			<td style="height : 10%;"><p style="text-align : center; font-weight: 600;">신규 상품 등록</p></td> <%-- 신규상품 등록 --%>
		</tr>
		<tr>
			<td style="text-align : center;">
				<div style="margin-bottom : 10px; font-weight: 600;"><%=newId%>번 신규 상품 <%=itemName%>이(가) 등록되었습니다.</div> <%-- 안내문구 출력 --%>
				<input type="submit" value="재고 현황"> <%-- 재고 현황 버튼 --%>
			</td>
		</tr>
	</table>
</form>
<%
	} else if (updateId != null) { // updateId에 전달받은 값이 있다면
		String updateCount = request.getParameter("updateCount"); // updateCount를 parameter로 받는 String변수 updateCount
		String updateCheckDate = request.getParameter("updateCheckDate"); // updateCheckDate를 parameter로 받는 String변수 updateCheckDate
		String updateRegiDate = request.getParameter("updateRegiDate"); // updateRegiDate를 parameter로 받는 String변수 updateRegiDate
		String updateItemName = request.getParameter("updateName"); // updateItemName을 parameter로 받는 String변수 updateItemName
		updateItemName = updateItemName.replace("&","&amp;").replace("<", "&lt;").replace(">", "&gt;"); // &, <, > 문자 대체
		
		// id가 updateId인 product 테이블의 데이터 업데이트하는 쿼리
		String Querytxt = String.format("update product set num=%d, checkDate='%s', registerDate='%s' where id='%s'"
								, Integer.parseInt(updateCount), updateCheckDate, updateRegiDate, updateId);
		stmt.executeUpdate(Querytxt); // 쿼리 실행
		
%>
<form method="post" action="product_list.jsp"> <%-- product_list에 값을 전달하는 form태그 --%>
	<table>
		<tr>
			<td style="height : 10%;"><p style="text-align : center;">상품 수정</p></td> <%-- 상품 수정 --%>
		</tr>
		<tr>
			<td style="text-align : center;">
				<div style="margin-bottom : 10px; font-weight: 600;"><%=updateId%>번 상품 <%=updateItemName%>이(가) 수정되었습니다.</div> <%-- 안내문구 출력 --%>
				<input type="submit" value="재고 현황"> <%-- 재고현황 버튼 --%>
			</td>
		</tr>
	</table>
</form>
<%
	}
	conn.close(); // 리소스 누설 방지
    stmt.close(); // 리소스 누설 방지
} catch (SQLIntegrityConstraintViolationException e) {
%>
<form method="post" action="product_list.jsp"> <%-- product_list에 값을 전달하는 form태그 --%>
	<div><p style="text-align:center;">중복키가 입력되었습니다.</p></div> <%-- 안내문구 출력 --%>
	<div style="text-align:center;"><input type="submit" value="게시판으로 이동"></div> <%-- 게시판 이동 버튼 --%>
</form>
<%
}
%>
</body>
</html>