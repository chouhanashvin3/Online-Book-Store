package com.book;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.book.daoImpl.CustomerDAOImpl;
import com.book.daoImpl.LoginDAOImpl;
import com.book.pojo.Customer;
import com.book.util.DBConnectivity;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet(description = "This will validate username and password for login", urlPatterns = { "/LoginServlet" })
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	LoginDAOImpl loginDao =new LoginDAOImpl();
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action =request.getParameter("action");
		if("logout".equals(action)) {
			HttpSession session=request.getSession(false);
			if(null != session) {
				session.invalidate();
				request.setAttribute("message", "You have logged out Successfully! Thankyou for using our service.");
				
				RequestDispatcher rd=request.getRequestDispatcher("Home.jsp");
				rd.forward(request, response);
			}
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		HttpSession session=request.getSession();
		
		
		boolean validateLogin = loginDao.validateLoginCustomer(email, password);
		if (validateLogin) {
			Customer customer=new  CustomerDAOImpl().viewCustomerByEmailId(email);
			String message = "Login Successfull....Welcome "+customer.getFirstName() + "  " + customer.getLastName();
			
			request.setAttribute("message", message);
			
			session.setAttribute("customer", customer);			
			RequestDispatcher rd =request.getRequestDispatcher("Home.jsp");
			rd.forward(request, response);
		} else {
			validateLogin=loginDao.validateLoginAdmin(email,password);
			if(validateLogin) {
				session.setAttribute("admin", email);
				request.setAttribute("message", "Login Successful!!! You have logged in as Admin.");
				
				
				RequestDispatcher rd =request.getRequestDispatcher("Home.jsp");
				rd.forward(request, response);
				
			}
			else {
			String errorMessage="You have entered wrong email id or password! Please try again.";
			request.setAttribute("errorMessage", errorMessage);
			
			RequestDispatcher rd = request.getRequestDispatcher("Login.jsp");
			rd.include(request, response);
		}
		}
	}

	
}
