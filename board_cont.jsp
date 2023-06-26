<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	int no = Integer.parseInt(request.getParameter("no"));
	
	String driver="oracle.jdbc.OracleDriver";
	String url="jdbc:oracle:thin:@localhost:1521:XE";
	String user="day";
	String password="day";
	
	Connection con = null;
	PreparedStatement pstmt=null;
	ResultSet rs =null;
	String sql = null;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 내용보기와 조회수 증가</title>
</head>
<body>
<%
  try{
	  Class.forName(driver);
	  con = DriverManager.getConnection(url, user, password);
	  sql = "update boardT7 set bhit=bhit+1 where bno=?";
	  pstmt=con.prepareStatement(sql);
	  pstmt.setInt(1,no);
	  pstmt.executeUpdate();
	  
	  sql="select * from boardT7 where bno=?";
	  pstmt=con.prepareStatement(sql);
	  pstmt.setInt(1,no);
	  rs=pstmt.executeQuery();
	  if(rs.next()){
 %>
 <script src="../js/jquery.js"></script>
<script type="text/javascript">
	function check() {
		if (!confirm("삭제하시겠습니까?")) {
			alert("취소되었습니다.");
			location = board_list.jsp;
		} else {
			alert("삭제되었습니다.");
			location = board_del.jsp?no=<%=rs.getInt("bno")%>;
		}
	}
</script>
 	<table border="1">
 		<tr>
 			<th colspan="2">게시판 내용보기</th>
 		</tr>
 		<tr>
 			<th>제목</th> <td><%=rs.getString("btitle") %></td>
 		</tr>
 		<tr>
 			<th>글내용</th> 
 			<td>
 			<%=rs.getString("bcont").replace("\n","<br>") %>
 			</td>
 		</tr>
 		<tr>
 			<th>조회수</th> <td><%=rs.getInt("bhit") %></td>
 		</tr>
 		<tr>
 			<th colspan="2">
 			 <input type="button" value="수정" onclick="location='board_edit.jsp?no=<%=rs.getInt("bno")%>'">
 			 <input type="button" value="삭제" onclick="check()">
 			 <input type="button" value="목록" onclick="location='board_list.jsp';">
 			</th> 
 		</tr>
 		
 	</table>
 <%}
 }catch(Exception e){e.printStackTrace();}
 	finally{
 		try{
 			if(rs != null) rs.close();
 			if(pstmt != null) pstmt.close();
 			if(con != null) con.close();
 		}catch(Exception e){e.printStackTrace();}
 	}
 %>
</body>
</html>