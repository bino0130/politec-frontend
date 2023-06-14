<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.*, javax.sql.*,java.io.*,java.util.*, java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신규 상품 등록</title>
<style>
table { /* table 태그에 css 적용 */
	width: 700px;
	height: 600px;
	border: 1px solid black;
	border-collapse: collapse;
	margin : auto;
}

td { /* td태그에 css 적용 */
	border: 1px solid black;
	padding-left: 15px;
}

#all { /* id가 all인 태그에 css 적용 */
	width: 800px;
	height: 930px;
	border: 1px solid black;
	border-collapse: collapse;
	margin : auto;
}

#twice { /* id가 twice인 태그에 css 적용 */
	width: 100%;
	text-align: center;
	border-bottom: 1px solid black;
	font-weight: 600;
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
var errors = {   // 에러를 묶어놓음
    productID: true, // id 에러
    productName: true, // 이름 에러
    cnt: true,  // 재고 에러
    content: true,  // 내용 에러
    photo: true // 사진 업로드 에러
};

function readImage(input) { // 업로드한 파일 확장자명을 검사하는 함수
	  // 인풋 태그에 파일이 있는 경우
	  if (input.files && input.files[0]) {
	    // 이미지 파일인지 검사 (생략)
	    // FileReader 인스턴스 생성
	    const reader = new FileReader();
	    // 이미지가 로드가 된 경우
	    reader.onload = (e) => {
	      const previewImage = document.getElementById("preview-image"); // preview-image를 id로 가져오는 상수 previewImage
	      previewImage.src = e.target.result;

	      // 추가적인 동작 수행 함수 호출
	      validateFile(input);
	    };
	    // reader가 이미지 읽도록 하기
	    reader.readAsDataURL(input.files[0]);
	  }
	}

function validateFile(input) { // readImage함수에서 호출하는 이미지 검사 함수 validateFile
	  var fileInput = document.getElementById('input-image'); // 수정된 부분
	  var filePath = fileInput.value; // var 변수 filePath 선언
	  var allowedExtensions = /(\.jpg|\.jpeg|\.png|\.gif)$/i; // 허용된 이미지 타입 나열
	  if (!allowedExtensions.exec(filePath)) { // 업로드된 파일의 확장자명이 allowedExtensions와 일치하지 않는 경우
	    alert('이미지 파일(.jpg, .jpeg, .png, .gif)만 선택할 수 있습니다.'); // 안내문구 출력
	    fileInput.value = ''; // 초기화
	    return false;
	  }
	  return true;
}


// input file에 change 이벤트 부여
const inputImage = document.getElementById("input-image");
inputImage.addEventListener("change", (e) => {
	readImage(e.target);
});
	
function trimSpace(input) {
	return input.replace(/^\s+/, '');
}
    
function InputCheck(input) {
     var inputValue = input; // 입력 받는 변수 혹은 데이터베이스에서 가져온 값 등
     var pattern = /^(?!(\s)*$)$/;
     
     if(inputValue.trim().length === 0){
      alert("내용을 입력하세요");
        return false;
     }
 }
 
function validateForm() {
      var title = document.forms["myForm"]["itemName"].value;
      var content = document.forms["myForm"]["itemDescribe"].value;
      
      title = trimSpace(title);
      
      if (InputCheck(title) == false) {
         return false;
   	  }
}
</script>
</head>
<body>
	<div id="all">
		<div id="twice">
			<p>(주)트와이스 재고 현황 - 상품등록</p> <%-- 제목 출력 --%>
		</div>
		<div style="width: 100%; height: 80%;">
			<%
			Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo10", "root", "kopoctc");
			// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
			// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
			Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar c1 = Calendar.getInstance();
			String strToday = sdf.format(c1.getTime()); // 오늘 날짜 구하는 String 변수 strToday
			
			%>
			<form name="myForm" method="post" enctype="multipart/form-data" onsubmit="return validateForm()"> <%-- 데이터를 전송하는 form태그, 파일을 전송하므로 multipart/form-data 사용 --%>
				<table>
					<tr>
						<td style="height:15px;">상품 번호</td> <%-- 상품 번호 --%>
						<td><input id="newId" type="text" name="newId" pattern="[a-zA-Z0-9]{0,13}" title="문자 및 숫자, 최대 13자리까지 입력 가능" value="" required></td> <%-- 상품번호 출력 --%>
					</tr>
					<tr>
						<td style="height:15px;">상품명</td> <%-- 상품명 --%>
						<td><input id="itemName" type="text" name="itemName" maxlength="33" value="" required></td> <%-- 상품명 출력 --%>
					</tr>
					<tr>
						<td style="height:15px;">재고 현황</td> <%-- 재고현황 --%>
						<td>
							<%-- 재고현황 출력 --%>
							<input id="itemCount" type="text" name="itemCount" pattern="[1-9][0-9]{0,8}" title="8자리까지 입력가능" value="" required>
						</td>
					</tr>
					<tr>
						<td style="height:15px;">상품등록일</td> <%-- 상품등록일 --%>
						<td>
							 <%-- 상품등록일 출력, 값을 전달해야해므로 input hidden 사용 --%>
							<p style="margin:5px 0px;"><%=strToday%></p><input type="hidden" name="checkDay" value="<%=strToday%>">
						</td>
					</tr>
					<tr>
						<td style="height:15px;">재고등록일</td> <%-- 재고등록일 --%>
						<td>
							<p style="margin:5px 0px;"><%=strToday%></p> <%-- 재고등록일 출력 --%>
							<input type="hidden" name="regisDay" value="<%=strToday%>"> <%-- 값을 전달하기위해 input hidden 사용 --%>
						</td>
					</tr>
					<tr>
						<td style="height: 350px;">상품설명</td> <%-- 상품설명 --%>
						<td><textarea id="area" name="itemDescribe" maxlength="12000" required></textarea></td> <%-- 상품설명 출력 --%>
					</tr>
					<tr>
						<td>상품사진</td> <%-- 상품사진 --%>
						<td>
							<div class="image-container">
								<img style="width: 200px;" id="preview-image"
									src="https://dummyimage.com/300x300/ffffff/000000.png&text=preview+image"> <%-- 미리보기 이미지 --%>
								<input style="display: block;" type="file" name="imgFile"
									accept="image/*" onchange="readImage(this);" id="input-image" required> <%-- 파일 업로드하는 input태그 --%>
							</div>
						</td>
					</tr>
					<%
					conn.close(); // 리소스 누설 방지
					stmt.close(); // 리소스 누설 방지
					%>
				</table>
				<table style="height: 30px; border: 0px;">
					<tr>
						<td style="border: 0px; text-align: right;"> <%-- 오른쪽 정렬 --%>
							<input type="submit" value="게시판으로 이동" formaction="product_list.jsp" onclick="window.location.href = 'product_list.jsp';">
							<input type="submit" value='완료' formaction="product_write.jsp"> <%-- 완료 버튼, product_write에 값 전달 --%>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>