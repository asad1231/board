<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>

<%

	String driver="oracle.jdbc.OracleDriver";
	String url="jdbc:oracle:thin:@localhost:1521:XE";
	String user="day";
	String password="day";
	
	Connection con = null;
	PreparedStatement pstmt=null;
	ResultSet rs =null;
	String sql = null;
	int rowcount = 0;
	try{
		Class.forName(driver);
		con=DriverManager.getConnection(url, user, password);
		sql="select * from boardT7 order by bno desc";
		pstmt=con.prepareStatement(sql);
		rs=pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
</head>
<body>

	<table border="1">
	 <tr>
	  <th colspan="5">게시판 목록보기</th>
	 </tr>
	 <tr>
	  <th>번호</th><th>글제목</th><th>글쓴이</th><th>조회수</th><th>등록날짜</th>
	 </tr>
	 <% while(rs.next()){%>
	 <tr>
	  <th><%=rs.getInt(1) %></th>
	  
	  <th><a href="board_cont.jsp?no=<%=rs.getInt(1)%>"><%=rs.getString("btitle") %></a></th>
	  <th><%=rs.getString("bname") %></th>
	  <th><%=rs.getInt("bhit") %></th>
	  <th><%=rs.getString("bdate").substring(0, 10) %></th>
	 </tr>
	 <%}%>
	 <tr>
	  <th colspan="5"><input type="button" value="게시판 글쓰기" onclick="location='board_write.jsp';"></th>
	 </tr>
	</table>
</body>
</html>
<%
	}catch(Exception e){e.printStackTrace();}
	finally{
		try{
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(con != null) con.close();
		}catch(Exception e){e.printStackTrace();}
	}
%>