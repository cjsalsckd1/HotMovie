package pds3;

import java.sql.*;
public class DBOpen {
	public Connection getConnection() {
		Connection con = null;
		String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver"; 
		String url = "jdbc:oracle:thin:@127.0.0.1:1521:XE";
		String id = "scott";
		String passwd= "tiger";
		
		try {
			Class.forName(JDBC_DRIVER);
			con = DriverManager.getConnection(url,id,passwd);
			
		}catch(ClassNotFoundException e) {
			System.out.println("oracle jdbc driver를 찾을수 없습니다.");
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return con;
	}
}
