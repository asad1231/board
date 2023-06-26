<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	int no=Integer.parseInt(request.getParameter("no"));
	
	String driver="oracle.jdbc.OracleDriver";
	String url="jdbc:oracle:thin:@localhost:1521:XE";
	String user="day";
	String password="day";
	
	Connection con = null;
	PreparedStatement pstmt=null;
	ResultSet rs =null;
	String sql = null;
	
	try{
		Class.forName(driver);
		con=DriverManager.getConnection(url, user, password);
		sql="select * from boardT7 where bno=?";
		pstmt= con.prepareStatement(sql);
		pstmt.setInt(1,no);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="../js/jquery.js"></script>
<script type="text/javascript">
function check() {

	if ($.trim($("#bname").val()) == "") {
		alert("글쓴이를 입력하세요!");
		$('#bname').val("").focus();
		return false;
	}
	if ($.trim($("#btitle").val()) == "") {
		alert("글제목을 입력하세요!");
		$('#btitle').val("").focus();
		return false;
	}
	if ($.trim($("#bcont").val()) == "") {
		alert("글내용을 입력하세요!");
		$('#bcont').val("").focus();
		return false;
	}
}
</script>
</head>
<body>
<form action="board_edit_ok.jsp" method="post" onsubmit="return check();">
	<input type="hidden" name="bno" value="<%=no%>">
		 <table border="1">
	  <tr>
	   <th colspan="2">게시판 글수정폼 </th>
	  </tr>
	  <tr>
	   <th>글쓴이</th>
	   <td><input name="bname" id="bname" size="14" value="<%=rs.getString("bname")%>"></td>
	  </tr>
	  
	  <tr>
	   <th>글제목</th>
	    <td><input name="btitle" id="btitle" size="36"value="<%=rs.getString("btitle")%>"></td>
	  </tr>
	   <tr>
	   <th>글내용</th>
	    <td>
	     <textarea rows="10" cols="36" name="bcont" id="bcont"><%=rs.getString("bcont")%></textarea>
	    </td>
	  </tr>
	  <tr>
	  	<th colspan="2"> 
	  	 <input type="submit" value="방명록수정">
	  	 <input type="reset" value="취소" onclick="$('#bname').focus();">
	  	</th>
	  </tr>
	 </table>
	</form>
</body>
</html>
<%} //if end
	}catch(Exception e){e.printStackTrace();}
	finally{
		try{
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(con != null) con.close();
		}catch(Exception e){e.printStackTrace();}
	}
%>