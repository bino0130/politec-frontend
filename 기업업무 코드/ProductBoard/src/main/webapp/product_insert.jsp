<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*, java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신규 상품 등록</title>
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
</style>
<script>
function readImage(input) {
    // 인풋 태그에 파일이 있는 경우
    if(input.files && input.files[0]) {
        // 이미지 파일인지 검사 (생략)
        // FileReader 인스턴스 생성
        const reader = new FileReader()
        // 이미지가 로드가 된 경우
        reader.onload = e => {
            const previewImage = document.getElementById("preview-image")
            previewImage.src = e.target.result
        }
        // reader가 이미지 읽도록 하기
        reader.readAsDataURL(input.files[0])
    }
}
// input file에 change 이벤트 부여
const inputImage = document.getElementById("input-image")
inputImage.addEventListener("change", e => {
    readImage(e.target)
})
</script>
</head>
<body>
<div style="width:800px; height:800px; border:1px solid black; border-collapse:collapse;">
	<div id="twice" style="width:100%;  border-bottom:1px solid black;"><p style="text-align:center;">(주)트와이스 재고 현황 - 상품등록</p></div>
	<div style="width:100%; height:80%;">
		<%
		Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo10", "root", "kopoctc");
		// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
		// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
		Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c1 = Calendar.getInstance();
		String strToday = sdf.format(c1.getTime());
		%>
		<form method="post" enctype="multipart/form-data">
			<table style="margin-top:30px; margin-left:75px;">
				<tr>
					<td style="height:15px;">상품 번호</td>
					<td><input type="text" name="newId" value="" required></td>
				</tr>
				<tr>
					<td style="height:15px;">상품명</td>
					<td><input type="text" name="itemName" value="" required></td>
				</tr>
				<tr>
					<td style="height:15px;">재고 현황</td>
					<td><input type="text" name="itemCount" value="" required></td>
				</tr>
				<tr>
					<td style="height:15px;">상품등록일</td>
					<td><p><%=strToday%></p><input type="hidden" name="checkDay" value="<%=strToday%>"></td>
				</tr>
				<tr>
					<td style="height:15px;">재고등록일</td>
					<td><p><%=strToday%></p><input type="hidden" name="regisDay" value="<%=strToday%>"></td>
				</tr>
				<tr>
					<td style="height: 15px;">상품설명</td>
					<td><input style="width:400px;" type="text" name="itemDescribe" value="" required></td>
				</tr>
				<tr>
					<td>상품사진</td>
					<td><div class="image-container">
    					<img style="width: 300px;" id="preview-image" src="https://dummyimage.com/300x300/ffffff/000000.png&text=preview+image">
    					<input style="display: block;" type="file" name="imgFile" accept="image/*" onchange="readImage(this);" id="input-image" required>
					</div></td>
				</tr>
				<%
				conn.close();
		    	stmt.close();
				%>
			</table>
			<table style="height:30px; border:0px; margin-top:30px; margin-left:75px;">
				<tr><td style="border:0px; text-align:right;"><input type="submit" value='완료' formaction="product_write.jsp"></td></tr>
			</table>
		</form>
	</div>
</div>
</body>
</html>