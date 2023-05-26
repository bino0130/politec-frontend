<%@ page contentType="text/html; charset=UTF-8" %> <%--한글처리 1--%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<html>
<head>
<style>
    th,td {
        text-align:center;
        border : 1px solid black;
        border-collapse: separate;
    }
</style>
</head>
<body>
<table>
<tr>
    <th id="num">번호</th>
    <th>주소</th>
    <th>위도</th>
    <th>경도</th>
    <th>거리</th>
</tr>
<% File f= new File("/var/lib/tomcat9/webapps/ROOT/전국무료와이파이표준데이터.txt");
BufferedReader br = new BufferedReader(new FileReader(f));

String readtxt;

if((readtxt=br.readLine())==null) {
    out.println("빈 파일입니다.\n");
    return;
}
String[] field_name = readtxt.split("\t");

double lat = 37.3860521;
double lng = 127.1214038;

int LineCnt = 0;
while((readtxt = br.readLine()) != null) {
    String[] field=readtxt.split("\t");
    double dist=Math.sqrt(Math.pow(Double.parseDouble(field[13])-lat,2)
                    + Math.pow(Double.parseDouble(field[14])-lng,2));
%>
<tr>
<td><%= LineCnt %></td>
<td><%=field[9]%></td>
<td><%=field[13]%></td>
<td><%=field[14]%></td>
<td><%=dist%></td>
</tr>
<%
LineCnt++;
}
br.close();
%>
</table>