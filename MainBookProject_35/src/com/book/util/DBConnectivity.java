package com.book.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnectivity {
	/**
	 * This method is used to connect to database. It returns connection object if
	 * connected to database, null otherwise
	 * 
	 * @return connection
	 */
	public static Connection makeConnection() {
		Connection connection = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/BookStoreDB_CTOL35","root","root");
		} 
		catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		catch (SQLException e) {
			e.printStackTrace();
		} 
		
		return connection;
	}
}
