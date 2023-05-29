<%@ page contentType="text/html; charset=UTF-8" %> <%--한글처리 1--%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<html>
<head>
<style>
    th, td { /* th, td 태그 셀렉터 */
        text-align: center; /* 텍스트 가운데 정렬 */
        border: 1px solid black; /* border : 1px solid black */
        border-collapse: separate; /* 표 테두리 분리 */
    }
    a { /* a 태그 셀렉터 */
        text-decoration-line : none; /* 밑줄 없애기 */
    }
    a:hover { /* a 태그에 마우스 커서 올렸을 때 */
        background-color : lightblue; /* 배경색상 : lightblue */
    }
    a:visited { /* 방문한 적 있는 a 태그 */
        color: magenta; /* 색상 : magenta */
    }
    table { /* 테이블 태그 셀렉터 */
        margin : auto; /* 가운데 정렬 */
        width : 1000px; /* 너비 1000px */
    }
</style>
</head>
<body>
<table>
<tr> <%-- table row --%>
    <th>번호</th> <%-- 번호 --%>
    <th>주소</th> <%-- 주소 --%>
    <th>위도</th> <%-- 위도 --%>
    <th>경도</th> <%-- 경도 --%>
    <th>거리</th> <%-- 거리 --%>
</tr> <%-- table row --%>
<% 
File f = new File("C:\\Users\\ska32\\OneDrive\\문서\\GitHub\\politec-frontend\\기업업무 코드\\JSP\\전국무료와이파이표준데이터.txt"); // root 디렉토리의 전국무료와이파이 표준 데이터를 경로로 하는 파일 객체 f
BufferedReader br = new BufferedReader(new FileReader(f)); // 생성한 객체 f 를 읽어주는 buffereader 객체 br 생성

String readtxt; // String타입 변수 readtxt 생성
if ((readtxt = br.readLine()) == null) { // readtxt를 읽은 값이 null이면
    out.println("빈 파일입니다.\n"); // 빈 파일입니다라고 출력
    return;
}

List<Integer> number = new ArrayList<Integer>(); // 번호를 담을 Integer입 리스트 number 생성
List<String> address = new ArrayList<String>(); // 주소를 담을 String타입 리스트 address 생성
List<Double> lati = new ArrayList<Double>(); //  위도를 담을 Double타입 리스트 lati 생성
List<Double> lngi = new ArrayList<Double>(); // 경도를 담을 Double타입 리스트 lngi 생성
List<Double> distance = new ArrayList<Double>(); // 거리를 담을 Double타입 리스트 distance 생성

double lat = 37.3860521; // 내 위치의 위도
double lng = 127.1214038; // 내 위치의 경도

int lineCnt = 0; // int형 변수 lineCnt = 0으로 선언
while ((readtxt = br.readLine()) != null) { // readtxt를 읽은 값이 null이 아니면
    String[] field = readtxt.split("\t"); // readtxt를 탭을 기준으로 나눠서 String타입 배열 field에 대입
    double dist = Math.sqrt(Math.pow(Double.parseDouble(field[13]) - lat, 2)
            + Math.pow(Double.parseDouble(field[14]) - lng, 2)); // 두 좌표 사이의 거리 구하는 변수 dist
    number.add(lineCnt); // number에 lineCnt add
    address.add(field[9]); // address에 field[9] add
    lati.add(Double.parseDouble(field[13])); // lati에 field[13] add
    lngi.add(Double.parseDouble(field[14])); // lngi에 field[14] add
    distance.add(dist); // distance에 dist add
    lineCnt++; // lineCnt++
}
String fromPT = request.getParameter("from"); // JSP 페이지에 url변수를 가져옴
String cntPT = request.getParameter("cnt"); // JSP 페이지에 url변수를 가져옴
int from = 0; // from = 0
if (fromPT != null) { // fromPT값이 null 이 아니면
    from = Integer.parseInt(fromPT); // from은 fromPT의 정수 형변환 값
    if (Integer.parseInt(fromPT) < 0) { // fromPT가 0보다 작으면
        from = 0; // from = 0
    } else if (Integer.parseInt(fromPT) > number.size()) { // fromPT가 총 데이터 개수보다 크면
        from = (number.size()/10) * 10; // 나누기 10 해준 다음 곱하기 10을 해서 1의 자리를 날림
    }
}

int cnt = 10; // cnt = 10
if (cntPT != null) { // cntPT값이 null이 아니면
    cnt = Integer.parseInt(cntPT); // cnt = cntPT 정수 형변환
}

for (int i = from; i < from + cnt && i < number.size(); i++) { // i가 from부터 from + cnt - 1까지 +1씩 증가하는 반복문
%>
<tr> <%-- table row --%>
<td><%=number.get(i) + 1%></td> <%-- number의 i번째 인덱스 + 1 --%>
<td><%=address.get(i)%></td> <%-- address의 i번째 인덱스 --%>
<td><%=lati.get(i)%></td> <%-- lati의 i번째 인덱스 --%>
<td><%=lngi.get(i)%></td> <%-- lngi의 i번째 인덱스 --%>
<td><%=distance.get(i)%></td> <%-- distance의 i번째 인덱스 --%>
</tr> <%-- table row --%>
<%
}
br.close(); // BufferedReader close
%>
</table>
<table>
<tr>
<%
// <<, < 계산, 출력하는 부분
if (from == 0) { // from이 0이라면
%>
<td><a href="wifi3.jsp?from=0&cnt=<%=cnt%>"><<</a></td> <%-- << : 1페이지로 이동 --%>
<td><a href="wifi3.jsp?from=0&cnt=<%=cnt%>"><</a></td>  <%-- < : 1페이지로 이동 --%>
<%
} else if (from!=0) { // from이 0이 아니면
%>
<td><a href="wifi3.jsp?from=0&cnt=<%=cnt%>"><<</a></td> <%-- << : 1페이지로 이동 --%>
<td><a href="wifi3.jsp?from=<%=from-cnt%>&cnt=<%=cnt%>"><</a></td> <%-- << : 1페이지 앞으로 이동 --%>
<%
}
int totpageNum = (int) Math.ceil((double) number.size() / cnt); // 총 페이지 수 : 총 데이터 개수 / cnt의 올림의 정수부분 값
int showPageNum = 10; // 페이지 번호 보여주는 범위 : 10

int currentPage = 1; // 현재 페이지 : 1로 초기화
if (cnt > 0) { // cnt가 0보다 크다면
    currentPage = (from / cnt) + 1; // 현재 페이지 = from / cnt + 1
}

// startPage부터 endPage까지 계산, 출력하기
int startPage = ((currentPage - 1) / showPageNum) * showPageNum + 1; // 시작 페이지 구하는 변수 startPage
int endPage = startPage + showPageNum - 1; // 끝 페이지 구하는 변수 endPage
if (endPage > totpageNum) { // endPage가 totpageNum보다 크다면
    endPage = totpageNum; // endPage = totpageNum
}

for (int i = startPage; i <= endPage; i++) { // i가 startPage부터 endPage까지 +1씩 증가하는 반복문
    int nowFrom = (i - 1) * cnt; // nowFrom = (i - 1) * cnt
    int nowPage = i; // nowPage = i
if (nowPage == currentPage) { // nowPage가 현재페이지와 같다면
%>
    <td><a href="wifi3.jsp?from=<%=nowFrom%>&cnt=<%=cnt%>" style="background-color:red; color:white"><%=nowPage%></a></td>
    <%--현재 페이지 출력하고 알아볼 수 있게 css 입힘--%>
<%
    } else { // nowPage가 현재페이지와 다르다면
%>
    <td><a href="wifi3.jsp?from=<%=nowFrom%>&cnt=<%=cnt%>"><%=nowPage%></a></td>
    <%-- 페이지 출력 --%>
<%
    }
%>
<%  
}
int nextPage = from + (cnt * 10); // 다음 페이지 구하는 변수 nextPage
if (nextPage > number.size()) { // nextPage가 총 데이터 개수보다 크다면
    nextPage = (number.size() / cnt) * cnt; // nextPage = (numbersize / 10) * 10
}
%>
<td><a href="wifi3.jsp?from=<%=nextPage%>&cnt=<%=cnt%>">></a></td> <%-- > 출력 --%>
<td><a href="wifi3.jsp?from=<%=(number.size()/cnt)*cnt%>&cnt=<%=cnt%>">>></a></td> <%-- >> 출력 --%>
</tr>
</table>
</body>
</html>