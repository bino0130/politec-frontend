<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>(주)트와이스 전체현황</title>
<style>
table { /* table태그에 css 적용 */
	width: 700px;
	border: 1px solid black;
	border-collapse: collapse;
	margin : auto;
}

.one { /* class가 one인 태그에 css 적용 */
	width: 10%;
	text-align: center;
}

.seven { /* class가 seven인 태그에 css 적용 */
	width: 70%;
}

.two { /* class가 two인 태그에 css 적용 */
	width: 20%;
	text-align: center;
}

.title { /* class가 title인 태그에 css 적용 */
	background-color : skyblue;
}

#all { /* id가 all인 태그에 css 적용 */
	width : 800px;
	height : 800px;
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

#submit { /* id가 submit인 태그에 css 적용 */
	background-color : skyblue;
	border-color: skyblue;
    border-radius: 5px;
}

#first td { /* id가 first인 태그의 자손 td태그에 css 적용 */
	border: 1px solid black;
	padding-left: 15px;
}

#third { /* id가 third인 태그에 css 적용 */
	border : none;
	width : 300px;
}

#third td { /* id가 third인 태그의 자손 td태그에 css 적용 */
	text-align : center;
}

a { /* a태그에 css 적용 */
	text-decoration: none; 
	color: black;
}

a:visited { /* 방문한 적 있는 a 태그 */
	color: black; /* 색상 : black */
}
</style>
</head>
<body>
<div id="all">
	<div id="twice"><p>(주)트와이스 재고 현황 - 전체현황</p></div> <%-- 제목 출력 --%>
	<div style="width:100%; height:80%;">
		<%
		Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo10", "root", "kopoctc");
		// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
		// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
		Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성

		ResultSet rset = stmt.executeQuery("select * from product order by registerDate desc, id desc"); // product 데이터 전체 출력
		
		List<String> productId = new ArrayList<String>(); // 물건id 담는 리스트 productId
		List<String> productName = new ArrayList<String>(); // 이름 리스트 productName
		List<Integer> countList = new ArrayList<Integer>(); // 물건 개수 담는 리스트 countList
		List<String> checkDateList = new ArrayList<String>(); // 현재 재고 체크날짜 담는 리스트 checkDateList
		List<String> registerDateList = new ArrayList<String>(); // 재고 파악일 담는 리스트 registerDateList
		%>
		<form method="post"> <%-- 값을 전달하는 form태그 --%>
			<table id="first">
				<tr>
					<td class="title">상품번호</td> <%-- 상품번호 --%>
					<td class="title" style="width: 150px;">상품명</td> <%-- 상품명 --%>
					<td class="title">현재 재고수</td> <%-- 현재 재고수 --%>
					<td class="title">재고 파악일</td> <%-- 재고 파악일 --%>
					<td class="title">상품 등록일</td> <%-- 상품 등록일 --%>
				</tr>

				<%
				while (rset.next()) {
					productId.add(rset.getString(1)); // productId에 id값 넣음
					productName.add(rset.getString(2)); // productName에 title값 넣음
					countList.add(rset.getInt(3)); // countList에 count값 넣음
					checkDateList.add(rset.getString(4)); // checkDateList에 checkDate값 넣음
					registerDateList.add(rset.getString(5)); // registerDateList에 registerDate값 넣음
				}
				
				String fromPT = request.getParameter("from"); // 페이지네이션 시 필요한 from 받아오는 변수 fromPT
				String cntPT = request.getParameter("cnt"); // 페이지네이션 시 필요한 cnt 받아오는 변수 cntPT
				
				int from = 0; // from = 0으로 초기화
				if (fromPT != null) { // fromPT값이 null 이 아니면
				    from = Integer.parseInt(fromPT); // from은 fromPT의 정수 형변환 값
				    if (Integer.parseInt(fromPT) < 0) { // fromPT가 0보다 작으면
				        from = 0; // from = 0
				    } else if (Integer.parseInt(fromPT) > productName.size()) { // fromPT가 총 데이터 개수보다 크면
				        from = (productName.size()/10) * 10; // 나누기 10 해준 다음 곱하기 10을 해서 1의 자리를 날림
				    }
				}
				
				int cnt = 10; // cnt = 10
				if (cntPT != null) { // cntPT값이 null이 아니면
				    cnt = Integer.parseInt(cntPT); // cnt = cntPT 정수 형변환
				    if (cnt < 0) { // cnt가 0보다 작으면
				        cnt = 20; // 20으로 설정
				    } else if (cnt == 0) { // cnt가 0이면
				        cnt = 5; // 5로 설정
				    }
				}
				
				for (int i = from; i < from + cnt && i < productName.size(); i++) { // i가 from부터 from + cnt - 1까지 +1씩 증가하는 반복문
				%>
				<tr>
					<td><%=productId.get(i)%></td> <%-- productId의 i번째 요소 출력 --%>
					<td><a href='product_view.jsp?key=<%=productId.get(i)%>'><%=productName.get(i)%></a></td> <%-- productName의 i번째 요소 출력 --%>
					<td><%=countList.get(i)%></td> <%-- countList의 i번째 요소 출력 --%>
					<td><%=checkDateList.get(i) %></td> <%-- checkDateList의 i번째 요소 출력 --%>
					<td><%=registerDateList.get(i)%></td> <%-- registerDateList의 i번째 요소 출력 --%>
				</tr>
			<%
				}
			%>
			</table>
			<table style="border:0px;">
				 <%-- 신규등록버튼, product_insert에 데이터 전달 --%>
				<tr><td style="border:0px; text-align:right;"><input id="submit" type="submit" value='신규등록' formaction="product_insert.jsp"></td></tr>
			</table>
		</form>
			<table id="third">
			<%
			int totpageNum = (int) Math.ceil((double)productName.size() / cnt); // 총 페이지 수 구하는 변수 totpageNum
			int showPageNum = 10; // 페이지 번호 보여주는 범위 : 10
			int currentPage = 1; // 현재 페이지 : 1로 초기화
			if (cnt > 0) { // cnt가 0보다 크다면
			    currentPage = (from / cnt) + 1; // 현재 페이지 = from / cnt + 1
			}
			
			// startPage부터 endPage까지 계산, 출력하기
			int startPage = ((currentPage - 1) / showPageNum) * showPageNum + 1; // 시작 페이지 구하는 변수 startPage
			int endPage = startPage + showPageNum - 1; // 끝 페이지 구하는 변수 endPage
			int beforePage = from - (cnt * 10); // 이전 페이지 구하는 변수 beforePage
		    if (beforePage < 0) { // beforePage가 0보다 작으면
		        beforePage = 0; // 0으로 설정
			}
			
		 	// <<, < 계산, 출력하는 부분
			if (from == 0) { // from이 0이라면
			%>
				<tr>
					<td><a href="product_list.jsp?from=0&cnt=<%=cnt%>">&lt;&lt;</a></td> <%-- << : 1페이지로 이동 --%>
					<td><a href="product_list.jsp?from=0&cnt=<%=cnt%>">&lt;</a></td>  <%-- < : 1페이지로 이동 --%>
			<%
				} else if (from != 0) {
			%>
					<td><a href="product_list.jsp?from=0&cnt=<%=cnt%>">&lt;&lt;</a></td> <%-- << : 1페이지로 이동 --%>
					<td><a href="product_list.jsp?from=<%=beforePage%>&cnt=<%=cnt%>">&lt;</a></td> <%-- << : 1페이지 앞으로 이동 --%>
			<%
				}
				if (endPage > totpageNum) { // endPage가 totpageNum보다 크다면
			   		endPage = totpageNum; // endPage = totpageNum
				}
				
				for (int i = startPage; i <= endPage; i++) { // i가 startPage부터 endPage까지 +1씩 증가하는 반복문
				    int nowFrom = (i - 1) * cnt; // nowFrom = (i - 1) * cnt
				    int nowPage = i; // nowPage = i
				if (nowPage == currentPage) { // nowPage가 현재페이지와 같다면
			%>
				<td><a href="product_list.jsp?from=<%=nowFrom%>&cnt=<%=cnt%>" style="color:skyblue"><%=nowPage%></a></td>
		    	<%--현재 페이지 출력하고 알아볼 수 있게 css 입힘--%>
			<%
		   		} else { // nowPage가 현재페이지와 다르다면
			%>
					<td><a href="product_list.jsp?from=<%=nowFrom%>&cnt=<%=cnt%>"><%=nowPage%></a></td>
		    		<%-- 페이지 출력 --%>
			<%
		   		}
			%>
			<%
				}
				// 데이터 개수 % cnt의 나머지가 0이면 maxPage를 데이터 개수 / cnt로 설정하고, 0이 아니면 데이터 개수 / cnt + 1로 설정한다.
				int maxPage = (productName.size() % cnt == 0) ? (productName.size() / cnt) : (productName.size() / cnt) + 1;
				
				int nextPage = from + (cnt * 10); // 다음 페이지 구하는 변수 nextPage
				if (nextPage > (maxPage - 1) * cnt) { // 다음 페이지가 최대 페이지보다 클때
					nextPage = (maxPage - 1) * cnt; // 다음 페이지를 최대 페이지로 설정
				}
			%>
			<td><a href="product_list.jsp?from=<%=nextPage%>&cnt=<%=cnt%>">&gt;</a></td> <%-- > 출력 --%>
			<td><a href="product_list.jsp?from=<%=maxPage * cnt - cnt%>&cnt=<%=cnt%>">&gt;&gt;</a></td> <%-- >> 출력 --%>
		</tr>
			<%
				rset.close(); // 리소스 누설 방지
				conn.close(); // 리소스 누설 방지
		    	stmt.close(); // 리소스 누설 방지
			%>
			</table>
	</div>
</div>
</body>
</html>