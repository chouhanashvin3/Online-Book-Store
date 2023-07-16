package com.book.dao;

public interface ILoginDAO {
	/**
	 * This method validates email id and password in database
	 * 
	 * @param emailId
	 * @param password
	 * @return true if login validated, false otherwise
	 */
	boolean validateLoginCustomer(String emailId, String password);
	boolean validateLoginAdmin(String emailId, String password);
}
