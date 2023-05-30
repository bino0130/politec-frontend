<%@ page contentType="text/html; charset=UTF-8" %> <%--한글처리 1--%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<html>
<head>
<style>
    th,td { /* th, td 태그 셀렉터 */
        text-align:center; /* 텍스트 가운데 정렬 */
        border : 1px solid black; /* border : 1px solid black */
        border-collapse: separate; /* 표 테두리 분리 */
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
</tr>
<% 
File f = new File("/var/lib/tomcat9/webapps/ROOT/JSP-3/전국무료와이파이표준데이터.txt"); // root 디렉토리의 전국무료와이파이 표준 데이터를 경로로 하는 파일 객체 f
BufferedReader br = new BufferedReader(new FileReader(f)); // 생성한 객체 f 를 읽어주는 buffereader 객체 br 생성

String readtxt; // String타입 변수 readtxt 생성
String fromPT = request.getParameter("from"); // JSP 페이지에 url변수를 가져옴
String cntPT = request.getParameter("cnt"); // JSP 페이지에 url변수를 가져옴
int from = 20; // from = 0
if (fromPT != null) { // fromPT값이 null 이 아니면
    from = Integer.parseInt(fromPT); // from은 fromPT의 정수 형변환 값
}

int cnt = 30; // cnt = 10
if (cntPT != null) { // cntPT값이 null이 아니면
    cnt = Integer.parseInt(cntPT); // cnt = cntPT 정수 형변환
}


if((readtxt=br.readLine())==null) { // readtxt를 읽은 값이 null이면
    out.println("빈 파일입니다.\n"); // 빈 파일입니다라고 출력
    return;
}
String[] field_name = readtxt.split("\t"); // readtxt를 탭을 기준으로 나눈 String배열 field_name
List<Integer> number = new ArrayList<Integer>(); // 번호를 담을 Integer입 리스트 number 생성
List<String> address = new ArrayList<String>(); // 주소를 담을 String타입 리스트 address 생성
List<Double> lati = new ArrayList<Double>(); //  위도를 담을 Double타입 리스트 lati 생성
List<Double> lngi = new ArrayList<Double>(); // 경도를 담을 Double타입 리스트 lngi 생성
List<Double> distance = new ArrayList<Double>(); // 거리를 담을 Double타입 리스트 distance 생성

double lat = 37.3860521; // 위도
double lng = 127.1214038; // 경도

int LineCnt = 0; // int형 변수 lineCnt = 0으로 선언
while((readtxt = br.readLine()) != null) { // readtxt를 읽은 값이 null이 아니면
    String[] field=readtxt.split("\t"); // readtxt를 탭을 기준으로 나눠서 String타입 배열 field에 대입
    double dist=Math.sqrt(Math.pow(Double.parseDouble(field[13])-lat,2)
                    + Math.pow(Double.parseDouble(field[14])-lng,2)); // 두 좌표 사이의 거리 구하는 변수 dist
    number.add(LineCnt); // number에 lineCnt add
    address.add(field[9]); // address에 field[9] add
    lati.add(Double.parseDouble(field[13])); // lati에 field[13] add
    lngi.add(Double.parseDouble(field[14])); // lngi에 field[14] add
    distance.add(dist); // distance에 dist add
    LineCnt++; // lineCnt++
}
for(int i = from; i < from+cnt; i++) { // i가 from부터 from + cnt - 1까지 +1씩 증가하는 반복문
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
    <td><a href="wifi2.jsp?from=20&cnt=30">20</a></td>
    <!-- 20번째부터 30개 출력 -->
</tr>
</table>