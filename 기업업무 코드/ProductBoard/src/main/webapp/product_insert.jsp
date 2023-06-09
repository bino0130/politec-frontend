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

#all {
	width: 800px;
	height: 800px;
	border: 1px solid black;
	border-collapse: collapse;
	margin-top: 30px;
	margin-left: 75px;
}

#twice {
	width: 100%;
	text-align: center;
	border-bottom: 1px solid black;
	font-weight: 600
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
function readImage(input) {
	  // 인풋 태그에 파일이 있는 경우
	  if (input.files && input.files[0]) {
	    // 이미지 파일인지 검사 (생략)
	    // FileReader 인스턴스 생성
	    const reader = new FileReader();
	    // 이미지가 로드가 된 경우
	    reader.onload = (e) => {
	      const previewImage = document.getElementById("preview-image");
	      previewImage.src = e.target.result;

	      // 추가적인 동작 수행 함수 호출
	      validateFile(input);
	    };
	    // reader가 이미지 읽도록 하기
	    reader.readAsDataURL(input.files[0]);
	  }
	}

function validateFile(input) {gbbbhn
	  var fileInput = document.getElementById('input-image'); // 수정된 부분
	  var filePath = fileInput.value;
	  var allowedExtensions = /(\.jpg|\.jpeg|\.png|\.gif)$/i;
	  if (!allowedExtensions.exec(filePath)) {
	    alert('이미지 파일(.jpg, .jpeg, .png, .gif)만 선택할 수 있습니다.');
	    fileInput.value = '';
	    return false;
	  }
	  return true;
	}


	// input file에 change 이벤트 부여
	const inputImage = document.getElementById("input-image");
	inputImage.addEventListener("change", (e) => {
	  readImage(e.target);
	});

// 특수문자, 한글, 영어 입력 방지
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

var timer; // 전역 변수로 타이머 변수를 선언

function nameCheck(obj) {
  clearInterval(timer); // 이전에 실행 중이던 타이머를 중지
  timer = setInterval(function() {
    validateInput(obj);
  }, 200); // 200ms마다 입력 값을 체크하는 함수 호출
}

function validateInput(obj) {
  var regExp = /[ <>]/g;
  if (regExp.test(obj.value)) {
    alert("<, >, 공백은 입력하실 수 없습니다.");
    obj.value = obj.value.replace(regExp, ""); // 특수문자 제거
  }
}
</script>
</head>
<body>
	<div id="all">
		<div id="twice">
			<p>(주)트와이스 재고 현황 - 상품등록</p>
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
			String strToday = sdf.format(c1.getTime());

			String Querytxt = "select id from product"; // product 테이블 전체 id 출력하는 쿼리
			ResultSet rset = stmt.executeQuery(Querytxt); // 쿼리 실행
			int cnt = 0; // cnt = 0으로 초기화
			while (rset.next()) { // rset이 있으면
				cnt++; // cnt + 1
			}

			int min = 1; // int형 정수 min 0으로 초기화
			if (cnt == 0) { // cnt가 0이면
				// product 테이블에서 비어있는 값의 최소값을 찾는 쿼리. 비어있지 않으면 마지막 데이터 + 1
				ResultSet idcount = stmt.executeQuery("select min(id) as minNum from product where (id+1) not in (select id from kiho);");
				while (idcount.next()) { // idcount가 있으면
					min = idcount.getInt(1) + 1; // min = getInt(1) + 1
				}
			} else { // cnt가 0이 아닐때(값이 들어있다는 뜻)
				// id 전체 값 조회
				ResultSet idcount2 = stmt.executeQuery("select id from product");
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
			
			%>
			<form method="post" enctype="multipart/form-data">
				<table style="margin-top: 30px; margin-left: 120px;">
					<tr>
						<td style="height: 15px;">상품 번호</td>
						<td><input type="text" name="newId" value="<%=min%>" readonly></td>
					</tr>
					<tr>
						<td style="height: 15px;">상품명</td>
						<td><input type="text" name="itemName" maxlength="15" value="" pattern="^(?!.*[<> ]).*$" oninput="validateInput(this)" required></td>
					</tr>
					<tr>
						<td style="height: 15px;">재고 현황</td>
						<td><input type="text" name="itemCount" value=""
							onkeydown="characterCheck(this)" required></td>
					</tr>
					<tr>
						<td style="height: 15px;">상품등록일</td>
						<td><p><%=strToday%></p>
							<input type="hidden" name="checkDay" value="<%=strToday%>"></td>
					</tr>
					<tr>
						<td style="height: 30%;">재고등록일</td>
						<td><p><%=strToday%></p>
							<input type="hidden" name="regisDay" value="<%=strToday%>"></td>
					</tr>
					<tr>
						<td style="height: 30%;">상품설명</td>
						<td><textarea id="area" name="itemDescribe" maxlength="600" pattern="^(?!.*[<> ]).*$" oninput="validateInput(this)" required></textarea></td>
					</tr>
					<tr>
						<td>상품사진</td>
						<td><div class="image-container">
								<img style="width: 300px;" id="preview-image"
									src="https://dummyimage.com/300x300/ffffff/000000.png&text=preview+image">
								<input style="display: block;" type="file" name="imgFile"
									accept="image/*" onchange="readImage(this);" id="input-image"
									required>
							</div></td>
					</tr>
					<%
					conn.close();
					stmt.close();
					%>
				</table>
				<table
					style="height: 30px; border: 0px; margin-top: 30px; margin-left: 120px;">
					<tr>
						<td style="border: 0px; text-align: right;"><input
							type="submit" value='완료' formaction="product_write.jsp"></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>