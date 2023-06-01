<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import = "java.sql.*, javax.sql.*,java.io.*, java.util.*" %>
<%
request.setCharacterEncoding("utf-8");
String name = request.getParameter("name");
String changeID = request.getParameter("studentID"); // input받은 searchID 값 변수에 저장
String kor = request.getParameter("korean");
String eng = request.getParameter("english");
String mat = request.getParameter("math");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	table {
		width : 600px;
		border : 1px solid black;
	}
	
	p {
		text-align : center;
	}
	
	td {
		border : 1px solid black;
		border-collapse : collapse;
	}
</style>
</head>
<body>
<h1>데이터 수정</h1> <%-- h1태그 사용 --%>
<table cellspacing=1>
	<%-- cellspacing=1, 너비 600px. border : 1px solid black인 테이블 생성 --%>
		<tr> <%-- table row --%>
			<td><p>이름</p></td> <%-- 이름 --%>
			<td><p>학번</p></td> <%-- 학번 --%>
			<td><p>국어</p></td> <%-- 국어 --%>
			<td><p>영어</p></td> <%-- 영어 --%>
			<td><p>수학</p></td> <%-- 수학 --%>
			<td><p>총합</p></td> <%-- 총합 --%>
			<td><p>평균</p></td> <%-- 평균 --%>
			<td><p>등수</p></td> <%-- 등수 --%>
		</tr>
<%
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo10","root","kopoctc");
		// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
		// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
		Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
		List<String> stuName = new ArrayList<String>();
		List<Integer> stuId = new ArrayList<Integer>();
		List<Integer> stuKor = new ArrayList<Integer>();
		List<Integer> stuEng = new ArrayList<Integer>();
		List<Integer> stuMat = new ArrayList<Integer>();
		List<Integer> stuSum = new ArrayList<Integer>();
		List<Integer> stuAvg = new ArrayList<Integer>();
		List<Integer> stuRnk = new ArrayList<Integer>();
		
		String Querytxt1 = String.format("delete from anotherTwice where studentid=%d",Integer.parseInt(changeID));
		stmt.execute(Querytxt1);
		
		String Querytxt2 = "select *, kor + eng + mat as sum , (kor + eng + mat) / 3 as avg , " +
                "(select count(*) + 1 from anotherTwice as r1 where r1.kor+r1.eng+r1.mat > r.kor + r.eng + r.mat) as rnk " +
                "from anotherTwice as r order by rnk";
		ResultSet rset = stmt.executeQuery(Querytxt2);
		// 해당 쿼리를 실행하기 위해 executeQuery를 호출하고 그 결과를 rset에 저장한다.
		while(rset.next()){ // rset이 있으면
			stuName.add(rset.getString(1));
			stuId.add(rset.getInt(2));
			stuKor.add(rset.getInt(3));
			stuEng.add(rset.getInt(4));
			stuMat.add(rset.getInt(5));
			stuSum.add(rset.getInt(6));
			stuAvg.add(rset.getInt(7));
			stuRnk.add(rset.getInt(8));
		}
		
		String fromPT = request.getParameter("from");
		String cntPT = request.getParameter("cnt");
		
		int from = 0;
		if (fromPT != null) { // fromPT값이 null 이 아니면
		    from = Integer.parseInt(fromPT); // from은 fromPT의 정수 형변환 값
		    if (Integer.parseInt(fromPT) < 0) { // fromPT가 0보다 작으면
		        from = 0; // from = 0
		    } else if (Integer.parseInt(fromPT) > stuName.size()) { // fromPT가 총 데이터 개수보다 크면
		        from = (stuName.size()/10) * 10; // 나누기 10 해준 다음 곱하기 10을 해서 1의 자리를 날림
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
		
		for (int i = from; i < from + cnt && i < stuName.size(); i++) { // i가 from부터 from + cnt - 1까지 +1씩 증가하는 반복문
%>
			<tr> <%-- table row --%>
			<td><%=stuName.get(i)%></td> <%-- stuName의 i번째 인덱스 + 1 --%>
			<td><%=stuId.get(i)%></td> <%-- stuId의 i번째 인덱스 --%>
			<td><%=stuKor.get(i)%></td> <%-- stuKor의 i번째 인덱스 --%>
			<td><%=stuEng.get(i)%></td> <%-- stuEng의 i번째 인덱스 --%>
			<td><%=stuMat.get(i)%></td> <%-- stuMat의 i번째 인덱스 --%>
			<td><%=stuSum.get(i)%></td> <%-- stuSum의 i번째 인덱스 --%>
			<td><%=stuAvg.get(i)%></td> <%-- stuAvg의 i번째 인덱스 --%>
			<td><%=stuRnk.get(i)%></td> <%-- stuRnk의 i번째 인덱스 --%>
			</tr> <%-- table row --%>
<%
		}
%>
</table>
<table>
<%
		int totpageNum = (int) Math.ceil((double)stuName.size() / cnt);
		int showPageNum = 10; // 페이지 번호 보여주는 범위 : 10
		int currentPage = 1; // 현재 페이지 : 1로 초기화
		if (cnt > 0) { // cnt가 0보다 크다면
		    currentPage = (from / cnt) + 1; // 현재 페이지 = from / cnt + 1
		}
		
		// startPage부터 endPage까지 계산, 출력하기
		int startPage = ((currentPage - 1) / showPageNum) * showPageNum + 1; // 시작 페이지 구하는 변수 startPage
		int endPage = startPage + showPageNum - 1; // 끝 페이지 구하는 변수 endPage
		int beforePage = from - (cnt * 10);
	    if (beforePage < 0) {
	        beforePage = 0;
	}
		
		// <<, < 계산, 출력하는 부분
		if (from == 0) { // from이 0이라면
		%>
	<tr>
		<td><a href="AllviewDB.jsp?from=0&cnt=<%=cnt%>">&lt;&lt;</a></td> <%-- << : 1페이지로 이동 --%>
		<td><a href="AllviewDB.jsp?from=0&cnt=<%=cnt%>">&lt;</a></td>  <%-- < : 1페이지로 이동 --%>
		<%
		} else if (from!=0) { // from이 0이 아니면
		%>
		<td><a href="AllviewDB.jsp?from=0&cnt=<%=cnt%>">&lt;&lt;</a></td> <%-- << : 1페이지로 이동 --%>
		<td><a href="AllviewDB.jsp?from=<%=beforePage%>&cnt=<%=cnt%>">&lt;</a></td> <%-- << : 1페이지 앞으로 이동 --%>
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
		    <td><a href="AllviewDB.jsp?from=<%=nowFrom%>&cnt=<%=cnt%>" style="background-color:red; color:white"><%=nowPage%></a></td>
		    <%--현재 페이지 출력하고 알아볼 수 있게 css 입힘--%>
		<%
		    } else { // nowPage가 현재페이지와 다르다면
		%>
		    <td><a href="AllviewDB.jsp?from=<%=nowFrom%>&cnt=<%=cnt%>"><%=nowPage%></a></td>
		    <%-- 페이지 출력 --%>
		<%
		    }
		%>
		<%  
		}
		int nextPage = from + (cnt * 10); // 다음 페이지 구하는 변수 nextPage
		if (nextPage > stuName.size()) { // nextPage가 총 데이터 개수보다 크다면
		    nextPage = (stuName.size() / cnt) * cnt; // nextPage = (numbersize / 10) * 10
		}
		//int nextPage = from + (cnt * 10) - cnt; // 다음 페이지 구하는 변수 nextPage
		//if (nextPage >= stuName.size()) {
	    //	nextPage = (stuName.size() / cnt) * cnt - cnt;
		//}		
		%>
		<td><a href="AllviewDB.jsp?from=<%=nextPage%>&cnt=<%=cnt%>">&gt;</a></td> <%-- > 출력 --%>
		<td><a href="AllviewDB.jsp?from=<%=(stuName.size()/cnt)*cnt%>&cnt=<%=cnt%>">&gt;&gt;</a></td> <%-- >> 출력 --%>
	</tr>
		
<%
		rset.close(); // 리소스 정리
		stmt.close(); // 리소스 정리
		conn.close(); // 리소스 정리

		//int totpageNum = 
	} catch (Exception e) {
		e.printStackTrace();	
	}
%>
</table>
</body>
</html>