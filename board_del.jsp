<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<%

	request.setCharacterEncoding("UTF-8");
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
		sql="delete from boardT7 where bno=?";
		pstmt=con.prepareStatement(sql);
		pstmt.setInt(1,no);
		int re= pstmt.executeUpdate();
		if(re == 1){
			response.sendRedirect("board_list.jsp");
		}
	}catch(Exception e){e.printStackTrace();}
	finally{
		try{
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(con != null) con.close();
	}catch(Exception e){e.printStackTrace();}
}
%>