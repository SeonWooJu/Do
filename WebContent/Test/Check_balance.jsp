<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	int no = Integer.parseInt(request.getParameter("no"));
	ResultSet rs = null;
	PreparedStatement stmt = null;
	String sql = "";
	String NUMBER = "";

	Class.forName("oracle.jdbc.driver.OracleDriver");

	String url = "jdb:oracle:thin:@localhost:1521:system";
	String id = "test20509";
	String pw = "20509";
	Connection conn = DriverManager.getConnection(url, id, pw);

	sql = "SELECT AC_NUMBER FROM USER_AC WHERE USER_CODE = ?";

	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, no);

	rs = stmt.executeQuery();

	if (rs.next()) {
		NUMBER = rs.getString("AC_NUMBER");
	}
	sql = "SELECT * FROM AC_INFO WHERE AC_NUMBER = ?";

	stmt = conn.prepareStatement(sql);
	stmt.setString(1, NUMBER);

	rs = stmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>잔액조회</title>
<style type="text/css">
.border {
	border: 1px solid black;
	text-align: center;
}
</style>
</head>
<body>

	<table class="border">
		<thead>
			<tr>
				<th class="border">계좌번호</th>
				<th class="border">보유금액</th>
				<th class="border">계좌종류</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<%
					while (rs.next()) {
						String AC_NUMBER = rs.getString("AC_NUMBER");
						int HOLDING_AMOUNT = rs.getInt("HOLDING_AMOUNT");
						int AC_TYPE = rs.getInt("AC_TYPE");
				%>
				<td class="border"><%=AC_NUMBER%></td>
				<td class="border"><%=HOLDING_AMOUNT%></td>
				<td class="border"><%=AC_TYPE%></td>
				<%
					}
				%>
			</tr>
		</tbody>
	</table>
</body>
</html>
<%
	rs.close();
	stmt.close();
	conn.close();
%>