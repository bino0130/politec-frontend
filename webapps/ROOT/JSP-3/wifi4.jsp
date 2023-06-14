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
    a:hover {
        background-color : lightblue;
    }
    a:visited {
        color: magenta;
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
File f = new File("/var/lib/tomcat9/webapps/ROOT/JSP-3/전국무료와이파이표준데이터.txt");
BufferedReader br = new BufferedReader(new FileReader(f));

String readtxt;
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
String fromPT = request.getParameter("from");
String cntPT = request.getParameter("cnt");
int from = 0;
if (fromPT != null) {
    from = Integer.parseInt(fromPT);
    if (Integer.parseInt(fromPT) < 0) {
        from = 0;
    } else if (Integer.parseInt(fromPT) > number.size()) {
        from = (number.size()/10) * 10;
    }
}

int cnt = 10;
if (cntPT != null) {
    cnt = Integer.parseInt(cntPT);
    if (cnt < 0) {
        cnt = 20;
    } else if (cnt == 0) {
        cnt = 5;
    }
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
int totpageNum = (int) Math.ceil((double) number.size() / cnt);
int showPageNum = 10;

int currentPage = 1;
if (cnt > 0) {
    currentPage = (from / cnt) + 1;
}
int startPage = ((currentPage - 1) / showPageNum) * showPageNum + 1;
int endPage = startPage + showPageNum - 1;
int beforePage = from - (cnt * 10);
    if (beforePage < 0) {
        beforePage = 0;
}
if (from==0) {
%>
<td><a href="wifi4.jsp?from=0&cnt=<%=cnt%>"><<</a></td>
<td><a href="wifi4.jsp?from=0&cnt=<%=cnt%>"><</a></td>
<%
} else if (from!=0) {
%>
<td><a href="wifi4.jsp?from=0&cnt=<%=cnt%>"><<</a></td>
<td><a href="wifi4.jsp?from=<%=beforePage%>&cnt=<%=cnt%>"><</a></td>
<%
}
if (endPage > totpageNum) {
    endPage = totpageNum;
}

for (int i = startPage; i <= endPage; i++) {
    int nowFrom = (i - 1) * cnt;
    int nowPage = i;
if (nowPage == currentPage) {
%>
    <td><a href="wifi4.jsp?from=<%=nowFrom%>&cnt=<%=cnt%>" style="background-color:red; color:white"><%=nowPage%></a></td>
<%
    } else {
%>
    <td><a href="wifi4.jsp?from=<%=nowFrom%>&cnt=<%=cnt%>"><%=nowPage%></a></td>
<%
    }
%>
<%  
}
int nextPage = from + (cnt * 10);
if (nextPage > number.size()) {
    nextPage = (number.size() / cnt) * cnt;
}
%>
<td><a href="wifi4.jsp?from=<%=nextPage%>&cnt=<%=cnt%>">></a></td>
<td><a href="wifi4.jsp?from=<%=(number.size()/cnt)*cnt%>&cnt=<%=cnt%>">>></a></td>
</tr>
</table>
</body>
</html>