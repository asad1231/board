<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String bname = request.getParameter("bname");
	String btitle = request.getParameter("btitle");
	String bcont = request.getParameter("bcont");
	
	String driver="oracle.jdbc.OracleDriver";
	String url="jdbc:oracle:thin:@localhost:1521:XE";
	String user="day";
	String password="day";
	
	Connection con = null;
	Statement stmt=null;
	String sql=null;
	
	
	try{
		Class.forName(driver);
		con=DriverManager.getConnection(url, user, password);
		stmt=con.createStatement();
		
		sql="insert into boardT7 (bno,bname,btitle,bcont)"
		+ " values(bno_seq.nextval,'"+bname+"','"+btitle+"','"+bcont+"')";
		
		int re=stmt.executeUpdate(sql);
		
		if(re == 1){
			out.println("<script>");
			out.println("alert('게시판 저장에 성공했습니다!');");
			out.println("location='board_list.jsp';");
			out.println("</script>");
		}
	}catch(Exception e){e.printStackTrace();}
	finally{
		try{
			if(stmt != null) stmt.close();
			if(con != null) con.close();
		}catch(Exception e){e.printStackTrace();}
	}
%>