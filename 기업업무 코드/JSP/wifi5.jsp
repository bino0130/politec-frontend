<%@ page contentType="text/html; charset=UTF-8" %> <%--한글처리 1--%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<html>
<head>
<style>
    th, td {
        text-align: center;
        border: 1px solid black;
        border-collapse: separate;
    }
    a {
        text-decoration-line : none;
    }
    table {
        margin : auto;
        width : 1000px;
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
File f = new File("/var/lib/tomcat9/webapps/ROOT/전국무료와이파이표준데이터.txt");
BufferedReader br = new BufferedReader(new FileReader(f));

String readtxt;
String fromPT = request.getParameter("from");
String cntPT = request.getParameter("cnt");
int from = 0;
if (fromPT != null) {
    from = Integer.parseInt(fromPT);
}
int cnt = 10;
if (cntPT != null) {
    cnt = Integer.parseInt(cntPT);
}

if ((readtxt = br.readLine()) == null) {
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

int lineCnt = 0;
while ((readtxt = br.readLine()) != null) {
    String[] field = readtxt.split("\t");
    double dist = Math.sqrt(Math.pow(Double.parseDouble(field[13]) - lat, 2)
            + Math.pow(Double.parseDouble(field[14]) - lng, 2));
    number.add(lineCnt);
    address.add(field[9]);
    lati.add(Double.parseDouble(field[13]));
    lngi.add(Double.parseDouble(field[14]));
    distance.add(dist);
    lineCnt++;
}
for (int i = from; i < from + cnt && i < number.size(); i++) {
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
<%
if (from==0) {
%>
<td><a href="wifi5.jsp?from=0&cnt=<%=cnt%>"><<</a></td>
<td><a href="wifi5.jsp?from=0&cnt=<%=cnt%>"><</a></td>
<%
} else if (from!=0) {
%>
<td><a href="wifi5.jsp?from=0&cnt=<%=cnt%>"><<</a></td>
<td><a href="wifi5.jsp?from=<%=from-cnt%>&cnt=<%=cnt%>"><</a></td>
<%
}
int totpageNum = (int) Math.ceil((double) number.size() / cnt);
int showPageNum = 10;

int currentPage = 1;
if (cnt > 0) {
    currentPage = (from / cnt) + 1;
}
int startPage = ((currentPage - 1) / showPageNum) * showPageNum + 1;
int endPage = startPage + showPageNum - 1;
if (endPage > totpageNum) {
    endPage = totpageNum;
}

for (int i = startPage; i <= endPage; i++) {
    int nowFrom = (i - 1) * cnt;
    int nowPage = i;
    %>
    <td><a href="wifi5.jsp?from=<%=nowFrom%>&cnt=<%=cnt%>"><%=nowPage%></a></td>
    <%
}
if(from<14800) {
%>
<td><a href="wifi5.jsp?from=<%=from+cnt%>&cnt=<%=cnt%>">></a></td>
<td><a href="wifi5.jsp?from=<%=(number.size()/10)*10%>&cnt=<%=cnt%>">>></a></td>
<% 
} else if (from >=14800 && from <14820) {
%>
<td><a href="wifi5.jsp?from=<%=from+cnt%>&cnt=<%=cnt%>">></a></td>
<td><a href="wifi5.jsp?from=<%=(number.size()/10)*10%>&cnt=<%=cnt%>">>></a></td>
<%
} else if (from >=14820) {
%>
<td><a href="wifi5.jsp?from=14820&cnt=<%=cnt%>">></a></td>
<td><a href="wifi5.jsp?from=<%=(number.size()/10)*10%>&cnt=<%=cnt%>">>></a></td>
<%
}
%>
</tr>
</table>
</body>
</html>
