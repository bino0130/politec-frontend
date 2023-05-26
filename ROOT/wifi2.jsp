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
<% 
File f= new File("/var/lib/tomcat9/webapps/ROOT/전국무료와이파이표준데이터.txt");
BufferedReader br = new BufferedReader(new FileReader(f));

String readtxt;
String fromPT = request.getParameter("from");
String cntPT = request.getParameter("cnt");
int from = Integer.parseInt(fromPT);
int cnt = 30;


if((readtxt=br.readLine())==null) {
    out.println("빈 파일입니다.\n");
    return;
}
String[] field_name = readtxt.split("\t");
List<Integer> number = new ArrayList<Integer>();
List<String> address = new ArrayList<String>();
List<Double> lati = new ArrayList<Double>();
List<Double> lngi = new ArrayList<Double>();
List<Double> distance = new ArrayList<Double>();

double lat = 37.3860521;
double lng = 127.1214038;

int LineCnt = 0;
while((readtxt = br.readLine()) != null) {
    String[] field=readtxt.split("\t");
    double dist=Math.sqrt(Math.pow(Double.parseDouble(field[13])-lat,2)
                    + Math.pow(Double.parseDouble(field[14])-lng,2));
    number.add(LineCnt);
    address.add(field[9]);
    lati.add(Double.parseDouble(field[13]));
    lngi.add(Double.parseDouble(field[14]));
    distance.add(dist);
    LineCnt++;
}
for(int i = from; i < from+cnt; i++) {
%>
<tr>
<td><%=number.get(i) + 1%></td>
<td><%=address.get(i)%></td>
<td><%=lati.get(i)%></td>
<td><%=lngi.get(i)%></td>
<td><%=distance.get(i)%></td>
</tr>
<%
}
br.close();
%>
</table>
<table>
<tr>
    <%-- <td><a href="wifi2.jsp?from=0&cnt=30"><<</a></td>
    <td><a href="wifi2.jsp?from=0&cnt=30">1</a></td>
    <td><a href="wifi2.jsp?from=30&cnt=30">2</a></td>
    <td><a href="wifi2.jsp?from=60&cnt=30">3</a></td>
    <td><a href="wifi2.jsp?from=90&cnt=30">4</a></td>
    <td><a href="wifi2.jsp?from=120&cnt=30">5</a></td>
    <td><a href="wifi2.jsp?from=150&cnt=30">6</a></td>
    <td><a href="wifi2.jsp?from=180&cnt=30">7</a></td>
    <td><a href="wifi2.jsp?from=210&cnt=30">8</a></td> --%>
    <td><a href="wifi2.jsp?from=570&cnt=30">20</a></td>
</tr>
</table>