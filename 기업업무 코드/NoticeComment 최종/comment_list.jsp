<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*,java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항/댓글 리스트 페이지</title>
<style>
table { /* table태그에 css 적용 */
	width: 600px;
	border: 1px solid black;
	border-collapse: collapse;
	margin : auto;
}

.one { /* class가 one인 태그에 css 적용 */
	width: 10%;
	text-align: center;
}

.two { /* class가 two인 태그에 css 적용 */
	width: 20%;
	text-align: center;
}

.six { /* class가 seven인 태그에 css 적용 */
	width: 60%;
}

.submit { /* class가 submit인 태그에 css 적용 */
	background-color : skyblue;
	border-color : skyblue;
	border-radius : 5px;
}

#first td { /* id가 first인 태그의 자손 td태그에 css 적용 */
	border: 1px solid black;
}

#third {
	border : none;
	width : 300px;
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

	// comment테이블에서 rootid는 내림차순, recnt는 오름차순으로 데이터 출력
	ResultSet rset = stmt.executeQuery("select id, title, date, recnt, viewcnt, relevel from comment order by rootid desc, recnt asc");
	
	List<Integer> commentId = new ArrayList<Integer>(); // id 담는 리스트 commentId
	List<String> commentName = new ArrayList<String>(); // 이름 리스트 commentName
	List<String> registerDateList = new ArrayList<String>(); // 등록일 담는 리스트 registerDateList
	List<Integer> recntList = new ArrayList<Integer>(); // recnt 담는 리스트 recntList
	List<Integer> viewcntList = new ArrayList<Integer>(); // viewcnt 담는 리스트 viewcntList
	List<Integer> relevelList = new ArrayList<Integer>(); // viewcnt 담는 리스트 relevelList
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	sdf.setTimeZone(TimeZone.getTimeZone("Asia/Seoul")); // 한국 시간대로 설정
	Calendar c1 = Calendar.getInstance();
	String strToday = sdf.format(c1.getTime()); // 오늘 날짜 구하는 String변수 strToday
	%>
	<form method="post"> <%-- 데이터 전달하는 form 태그 --%>
		<table id="first">
			<tr>
				<td class="one" style="background-color:skyblue;">번호</td> <%-- 번호 --%> 
				<td class="six" style="background-color:skyblue; text-align: center;">제목</td> <%-- 제목 --%> 
				<td class="one" style="background-color:skyblue;">조회수</td> <%-- 조회수 --%> 
				<td class="two" style="background-color:skyblue;">등록일</td> <%-- 등록일 --%> 
			</tr>

			<%
				while (rset.next()) {
					commentId.add(rset.getInt(1)); // commentId에 값 대입
					commentName.add(rset.getString(2)); // commentName에 값 대입
					registerDateList.add(rset.getString(3)); // registerDateList에 값 대입
					recntList.add(rset.getInt(4)); // recntList에 값 대입
					viewcntList.add(rset.getInt(5)); // viewcntList에 값 대입
					relevelList.add(rset.getInt(6)); // relevelList에 값 대입
				}
				String fromPT = request.getParameter("from"); // 페이지네이션 시 필요한 from 받아오는 변수 fromPT
				String cntPT = request.getParameter("cnt"); // 페이지네이션 시 필요한 cnt 받아오는 변수 cntPT
			
				int from = 0; // from = 0으로 초기화
				if (fromPT != null) { // fromPT값이 null 이 아니면
				    from = Integer.parseInt(fromPT); // from은 fromPT의 정수 형변환 값
			    	if (Integer.parseInt(fromPT) < 0) { // fromPT가 0보다 작으면
			        	from = 0; // from = 0
			    	} else if (Integer.parseInt(fromPT) > commentName.size()) { // fromPT가 총 데이터 개수보다 크면
			        	from = (commentName.size()/10) * 10; // 나누기 10 해준 다음 곱하기 10을 해서 1의 자리를 날림
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
			
				for (int i = from; i < from + cnt && i < commentName.size(); i++) { // i가 from부터 from + cnt - 1까지 +1씩 증가하는 반복문
					if (registerDateList.get(i).equals(strToday)) { // registerDateList의 날짜가 오늘 날짜와 일치하다면 뒤에 [New] 표시
						if (relevelList.get(i) > 0) { // relevelList의 relevel이 0보다 크면 ->[Re] 표시
							String hypen = ""; // String변수 hypen = ""로 초기화
							for (int j = 0; j <= relevelList.get(i); j++) {
								if (j> 0) { // i가 0보다 크다면
									hypen = hypen + "-"; // hypen 뒤에 '-'' 붙임
								}
							}
							
							if (viewcntList.get(i) == -1) { // 삭제된 댓글일 경우 클릭 불가능
			%>
								<tr>
									<td class="one"><%=commentId.get(i)%></td> <%-- commentId의 i번째 요소 출력 --%> 
									<td class="six"><%=hypen%>&gt;[Re]<%=commentName.get(i)%></td> <%-- commentName의 i번째 요소 출력 --%> 
									<td class="one">-</td> <%-- viewcntList의 i번째 요소 출력 --%> 
									<td class="two"><%=registerDateList.get(i)%></td> <%-- regusterDateList의 i번째 요소 출력 --%> 
								</tr>
			<%
							} else { // 그 외 클릭 가능
			%>
								<tr>
									<td class="one"><%=commentId.get(i)%></td> <%-- commentId의 i번째 요소 출력 --%> 
									<td class="six"><a href='comment_view.jsp?key=<%=commentId.get(i)%>'><%=hypen%>&gt;[Re]<%=commentName.get(i)%>[New]</a></td> <%-- commentName의 i번째 요소 출력 --%> 
									<td class="one"><%=viewcntList.get(i)%></td> <%-- viewcntList의 i번째 요소 출력 --%> 
									<td class="two"><%=registerDateList.get(i)%></td> <%-- regusterDateList의 i번째 요소 출력 --%> 
								</tr>
			<%
							}
						} else { // relevelList의 relevel이 0이면 댓글표시 안함
			%>
								<tr>
									<td class="one"><%=commentId.get(i)%></td> <%-- commentId의 i번째 요소 출력 --%> 
									<td class="six"><a href='comment_view.jsp?key=<%=commentId.get(i)%>'><%=commentName.get(i)%>[New]</a></td> <%-- commentName의 i번째 요소 출력 --%> 
									<td class="one"><%=viewcntList.get(i)%></td> <%-- viewcntList의 i번째 요소 출력 --%> 
									<td class="two"><%=registerDateList.get(i)%></td> <%-- regusterDateList의 i번째 요소 출력 --%> 
								</tr>
			<%			
						}
					} else { // registerDateList의 날짜가 오늘 날짜와 다르면 뒤에 [New]표시 안함
						if (relevelList.get(i) > 0) {  // relevelList의 relevel이 0보다 크면 ->[Re] 표시
							String hypen = ""; // String변수 hypen = ""로 초기화
							for (int j = 0; j <= relevelList.get(i); j++) {
								if (j > 0) { // i가 0보다 크다면
									hypen = hypen + "-"; // hypen 뒤에 '-'' 붙임
								}
							}
							
							if (viewcntList.get(i) == -1) { // 삭제된 댓글일 경우 클릭 불가능
			%>
								<tr>
									<td class="one"><%=commentId.get(i)%></td> <%-- commentId의 i번째 요소 출력 --%> 
									<td class="six"><%=hypen%>&gt;[Re]<%=commentName.get(i)%></td> <%-- commentName의 i번째 요소 출력 --%> 
									<td class="one">-</td> <%-- viewcntList의 i번째 요소 출력 --%> 
									<td class="two"><%=registerDateList.get(i)%></td> <%-- regusterDateList의 i번째 요소 출력 --%> 
								</tr>
			<%
							} else { // 그 외 클릭 가능
			%>
								<tr>
									<td class="one"><%=commentId.get(i)%></td> <%-- commentId의 i번째 요소 출력 --%> 
									<td class="six"><a href='comment_view.jsp?key=<%=commentId.get(i)%>'><%=hypen%>&gt;[Re]<%=commentName.get(i)%>[New]</a></td> <%-- commentName의 i번째 요소 출력 --%> 
									<td class="one"><%=viewcntList.get(i)%></td> <%-- viewcntList의 i번째 요소 출력 --%> 
									<td class="two"><%=registerDateList.get(i)%></td> <%-- regusterDateList의 i번째 요소 출력 --%> 
								</tr>
			<%
							}
						} else { // relevelList의 relevel이 0이면 댓글표시 안함
			%>
							<tr>
								<td class="one"><%=commentId.get(i)%></td> <%-- commentId의 i번째 요소 출력 --%> 
								<td class="six"><a href='comment_view.jsp?key=<%=commentId.get(i)%>'><%=commentName.get(i)%></a></td> <%-- commentName의 i번째 요소 출력 --%> 
								<td class="one"><%=viewcntList.get(i)%></td> <%-- viewcntList의 i번째 요소 출력 --%> 
								<td class="two"><%=registerDateList.get(i)%></td> <%-- regusterDateList의 i번째 요소 출력 --%> 
							</tr>
			<%
						}
					}
			}
			%>
		</table>
		<table style="border:0px">
			<tr>
				<td style="border:0px; text-align:right;"><input class="submit" type="submit" value='신규' formaction="comment_insert.jsp"></td> <%-- comment_insert에 값을 전달하는 신규 버튼 --%> 
			</tr>
		</table>
	</form>
		<table id="third">
			<%
				int totpageNum = (int) Math.ceil((double)commentName.size() / cnt); // 총 페이지 수 구하는 변수 totpageNum
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
					<td style="text-align:center;"><a href="comment_list.jsp?from=0&cnt=<%=cnt%>">&lt;&lt;</a></td> <%-- << : 1페이지로 이동 --%>
					<td style="text-align:center;"><a href="comment_list.jsp?from=0&cnt=<%=cnt%>">&lt;</a></td>  <%-- < : 1페이지로 이동 --%>
			<%
				} else if (from != 0) { // 0이 아니면
			%>
			
					<td style="text-align:center;"><a href="comment_list.jsp?from=0&cnt=<%=cnt%>">&lt;&lt;</a></td> <%-- << : 1페이지로 이동 --%>
					<td style="text-align:center;"><a href="comment_list.jsp?from=<%=beforePage%>&cnt=<%=cnt%>">&lt;</a></td> <%-- << : 1페이지 앞으로 이동 --%>
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
						<td style="text-align:center;"><a href="comment_list.jsp?from=<%=nowFrom%>&cnt=<%=cnt%>" style="color:skyblue"><%=nowPage%></a></td>
		    			<%--현재 페이지 출력하고 알아볼 수 있게 css 입힘--%>
		    <%
					} else { // nowPage가 현재페이지와 다르다면
		    %>
		    			<td style="text-align:center;"><a href="comment_list.jsp?from=<%=nowFrom%>&cnt=<%=cnt%>"><%=nowPage%></a></td>
		    			<%-- 페이지 출력 --%>
		    <%
					}
				}
				
				// 데이터 개수 % cnt의 나머지가 0이면 maxPage를 데이터 개수 / cnt로 설정하고, 0이 아니면 데이터 개수 / cnt + 1로 설정한다.
				int maxPage = (commentName.size() % cnt == 0) ? (commentName.size() / cnt) : (commentName.size() / cnt) + 1;
				
				int nextPage = from + (cnt * 10); // 다음 페이지 구하는 변수 nextPage
				if (nextPage > (maxPage - 1) * cnt) { // 다음 페이지가 최대 페이지보다 클때
					nextPage = (maxPage - 1) * cnt; // 다음 페이지를 최대 페이지로 설정
				}
		    %>
		    	<td style="text-align:center;"><a href="comment_list.jsp?from=<%=nextPage%>&cnt=<%=cnt%>">&gt;</a></td> <%-- > 출력 --%>
				<td style="text-align:center;"><a href="comment_list.jsp?from=<%=maxPage * cnt - cnt%>&cnt=<%=cnt%>">&gt;&gt;</a></td> <%-- >> 출력 --%>
			</tr>
			<%
				conn.close(); // 리소스 누설 방지
		    	stmt.close(); // 리소스 누설 방지
	 		%>
	 	</table>
</body>
</html>