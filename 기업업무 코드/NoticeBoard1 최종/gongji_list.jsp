<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 리스트 페이지</title>
<style>
table { /* table태그에 css 적용 */
	width: 600px;
	border: 1px solid black;
	border-collapse: collapse;
	margin : auto;
}

#first td { /* id가 first인 태그의 자손 td태그에 css 적용 */
	border: 1px solid black;
}

#third { /* id가 third인 태그에 css 적용 */
	border : none;
	width : 300px;
}

#third td { /* id가 third인 태그의 자손 td태그에 css 적용 */
	text-align : center;
}

.one { /* 클래스명이 one인 태그에 css 적용 */
	width: 10%;
	text-align : center;
}

.two { /* 클래스명이 two인 태그에 css 적용 */
	width: 20%;
	text-align : center;
}

.seven { /* 클래스명이 seven인 태그에 css 적용 */
	width: 70%;
}

.submit { /* class가 submit인 태그에 css 적용 */
	background-color : skyblue;
	border-color : skyblue;
	border-radius : 5px;
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
	<%
	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성

	ResultSet rset = stmt.executeQuery("select id, title, date from gongji order by id desc"); // gongji테이블에서 id, title, date 출력
	
	List<Integer> gongjiId = new ArrayList<Integer>(); // id 담는 리스트 gongjiId
	List<String> gongjiName = new ArrayList<String>(); // 이름 리스트 gongjiName
	List<String> registerDateList = new ArrayList<String>(); // 등록일 담는 리스트 checkDateList
	%>
	<form method="post"> <%-- 데이터 제출하는 form태그 --%>
		<table id="first">
			<tr>
				<td class="one" style="background-color : skyblue;">번호</td> <%-- 번호 --%>
				<td class="seven" style="text-align: center; background-color : skyblue;">제목</td> <%-- 제목 --%>
				<td class="two" style="background-color : skyblue;">등록일</td> <%-- 등록일 --%>
			</tr>

			<%
				while (rset.next()) {
					gongjiId.add(rset.getInt(1)); // 리스트에 id 넣기
					gongjiName.add(rset.getString(2)); // 리스트에 title 넣기
					registerDateList.add(rset.getString(3)); // 리스트에 date 넣기
				}
				String fromPT = request.getParameter("from"); // 페이지네이션 시 필요한 from 받아오는 변수 fromPT
				String cntPT = request.getParameter("cnt"); // 페이지네이션 시 필요한 cnt 받아오는 변수 cntPT
			
				int from = 0; // from = 0으로 초기화
				if (fromPT != null) { // fromPT값이 null 이 아니면
				    from = Integer.parseInt(fromPT); // from은 fromPT의 정수 형변환 값
			    	if (Integer.parseInt(fromPT) < 0) { // fromPT가 0보다 작으면
			        	from = 0; // from = 0
			    	} else if (Integer.parseInt(fromPT) > gongjiName.size()) { // fromPT가 총 데이터 개수보다 크면
			        	from = (gongjiName.size()/10) * 10; // 나누기 10 해준 다음 곱하기 10을 해서 1의 자리를 날림
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
			
				for (int i = from; i < from + cnt && i < gongjiName.size(); i++) { // i가 from부터 from + cnt - 1까지 +1씩 증가하는 반복문
			%>
			<tr>
				<td class="one"><%=gongjiId.get(i)%></td> <%-- id출력 --%>
				<td class="seven"><a href='gongji_view.jsp?key=<%=gongjiId.get(i)%>'><%=gongjiName.get(i)%></a></td> <%-- title출력 --%>
				<td class="two"><%=registerDateList.get(i)%></td> <%-- date 출력 --%>
			</tr>
			<%
			}
			%>
		</table>
		<table style="border:0px">
			<tr>
				<td style="border:none; text-align:right;">
					<input class="submit" type="submit" value='신규' formaction="gongji_insert.jsp">
				</td>
			</tr> <%-- 신규버튼 --%>
		</table>
	</form>
		<table id="third">
			<%
				int totpageNum = (int) Math.ceil((double)gongjiName.size() / cnt); // 총 페이지 수 구하는 변수 totpageNum
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
					<td><a href="gongji_list.jsp?from=0&cnt=<%=cnt%>">&lt;&lt;</a></td> <%-- << : 1페이지로 이동 --%>
					<td><a href="gongji_list.jsp?from=0&cnt=<%=cnt%>">&lt;</a></td>  <%-- < : 1페이지로 이동 --%>
			<%
				} else if (from != 0) {
			%>
			
					<td><a href="gongji_list.jsp?from=0&cnt=<%=cnt%>">&lt;&lt;</a></td> <%-- << : 1페이지로 이동 --%>
					<td><a href="gongji_list.jsp?from=<%=beforePage%>&cnt=<%=cnt%>">&lt;</a></td> <%-- << : 1페이지 앞으로 이동 --%>
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
						<td><a href="gongji_list.jsp?from=<%=nowFrom%>&cnt=<%=cnt%>" style="color:skyblue"><%=nowPage%></a></td>
		    			<%--현재 페이지 출력하고 알아볼 수 있게 css 입힘--%>
		    <%
					} else { // nowPage가 현재페이지와 다르다면
		    %>
		    			<td><a href="gongji_list.jsp?from=<%=nowFrom%>&cnt=<%=cnt%>"><%=nowPage%></a></td>
		    			<%-- 페이지 출력 --%>
		    <%
					}
				}
				
				// 데이터 개수 % cnt의 나머지가 0이면 maxPage를 데이터 개수 / cnt로 설정하고, 0이 아니면 데이터 개수 / cnt + 1로 설정한다.
				int maxPage = (gongjiName.size() % cnt == 0) ? (gongjiName.size() / cnt) : (gongjiName.size() / cnt) + 1;
				
				int nextPage = from + (cnt * 10); // 다음 페이지 구하는 변수 nextPage
				if (nextPage > (maxPage - 1) * cnt) { // 다음 페이지가 최대 페이지보다 클때
					nextPage = (maxPage - 1) * cnt; // 다음 페이지를 최대 페이지로 설정
				}
		    %>
		    	<td><a href="gongji_list.jsp?from=<%=nextPage%>&cnt=<%=cnt%>">&gt;</a></td> <%-- > 출력 --%>
				<td><a href="gongji_list.jsp?from=<%=maxPage * cnt - cnt%>&cnt=<%=cnt%>">&gt;&gt;</a></td> <%-- >> 출력 --%>
			</tr>
			<%
				conn.close(); // 리소스 누설 방지
		    	stmt.close(); // 리소스 누설 방지
	 		%>
	 	</table>
</body>
</html>