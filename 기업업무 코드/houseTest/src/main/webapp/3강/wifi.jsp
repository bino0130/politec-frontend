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
File f = new File("C:\\Users\\ska32\\OneDrive\\문서\\GitHub\\politec-frontend\\기업업무 코드\\JSP\\전국무료와이파이표준데이터.txt"); // root 디렉토리의 전국무료와이파이 표준 데이터를 경로로 하는 파일 객체 f
BufferedReader br = new BufferedReader(new FileReader(f)); // 생성한 객체 f 를 읽어주는 buffereader 객체 br 생성

String readtxt; // String타입 변수 readtxt 생성

if((readtxt=br.readLine())==null) { // readtxt를 읽은 값이 null이면
    out.println("빈 파일입니다.\n"); // 빈 파일입니다라고 출력
    return;
}
String[] field_name = readtxt.split("\t"); // readtxt를 탭을 기준으로 나눈 String배열 field_name

double lat = 37.3860521; // 위도
double lng = 127.1214038; // 경도

int LineCnt = 0; // int형 변수 LineCnt = 0으로 초기화
while((readtxt = br.readLine()) != null) { // readtxt를 읽은 값이 null이 아니면
    String[] field=readtxt.split("\t"); // readtxt를 탭을 기준으로 나눈 String배열 field
    double dist=Math.sqrt(Math.pow(Double.parseDouble(field[13])-lat,2)
                    + Math.pow(Double.parseDouble(field[14])-lng,2)); // 두 좌표간 거리 구하는 변수 idst 
%>
<tr>
<td><%= LineCnt %></td> <!-- LineCnt 출력 -->
<td><%=field[9]%></td> <!-- 주소 출력 -->
<td><%=field[13]%></td> <!-- 위도 출력 -->
<td><%=field[14]%></td> <!-- 경도 출력 -->
<td><%=dist%></td> <!-- 거리 출력 -->
</tr>
<%
LineCnt++; // LineCnt +1씩 증가
}
br.close(); // 리소스 누수 방지
%>
</table>