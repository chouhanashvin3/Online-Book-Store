package com.book;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.book.daoImpl.CustomerDAOImpl;
import com.book.pojo.Customer;

/**
 * Servlet implementation class CustomerServletController
 */
@WebServlet(description = "Controller for all Customer related operations", urlPatterns = { "/CustomerServletController" })
public class CustomerServletController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private Integer customerId;
	private String firstName;
	private String lastName;
	private String address;
	private String address2;
	private String contact;
	// login details
	private String emailId;
	private String password;
	
	RequestDispatcher rd;
	CustomerDAOImpl customerDAOImpl;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CustomerServletController() {
        super();
        customerDAOImpl = new CustomerDAOImpl();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action =request.getParameter("action");
		HttpSession session=request.getSession();
		
		if("updateProfile".equals(action)) {
			if(null != session) {
				Customer customer=(Customer) session.getAttribute("customer");
				if(null != customer) {
					request.setAttribute("customer", customer);
					rd=request.getRequestDispatcher("Register.jsp");
					rd.forward(request, response);
				}else {
					request.setAttribute("errorMessage", "Please Login");
					rd=request.getRequestDispatcher("Login.jsp");
					rd.forward(request, response);
				}
			}
		}else if("viewCustomers".equals(action)) {//admin operation
			List<Customer> customersList=customerDAOImpl.getAllCustomers();
			
			if(customersList.isEmpty()|| null == customersList) {
				request.setAttribute("message", "No  Customers Registered with us till now.");
				rd=request.getRequestDispatcher("Home.jsp");
				rd.forward(request, response);
				
			}else {
				request.setAttribute("customersList", customersList);
				rd=request.getRequestDispatcher("ViewCustomers.jsp");
				rd.forward(request, response);
			}
			
		}else if("deleteCustomer".equals(action)) {//admin operation
			String id = request.getParameter("customerId");
			boolean deleteCustomer = customerDAOImpl.deleteCustomer(Integer.parseInt(id));
			if(deleteCustomer) {
				request.setAttribute("message", "Customer with Customer ID - "+ id + " is deleted successfully.");
				rd=request.getRequestDispatcher("CustomerServletController?action=viewCustomers");
				rd.forward(request, response);
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		String action =request.getParameter("action");
		firstName =request.getParameter("firstName").trim();
		lastName =request.getParameter("lastName").trim();
		address =request.getParameter("address").trim();
		address2 =request.getParameter("address2").trim();
		contact =request.getParameter("contact").trim();
		emailId =request.getParameter("emailId").trim();
		password =request.getParameter("password").trim();
		if((null !=firstName ||"" != firstName) ||(null !=lastName ||"" != lastName)||(null !=address ||"" != address)||(null !=contact ||"" != contact)||(null !=emailId ||"" != emailId)||(null !=password ||"" != password)) {
			Customer newCustomer = new Customer();
			newCustomer.setFirstName(firstName);
			newCustomer.setLastName(lastName);
			newCustomer.setAddress(address);
			newCustomer.setAddress2(address2);
			newCustomer.setContact(contact);
			newCustomer.setEmailId(emailId);
			newCustomer.setPassword(password);
			
		if("addCustomer".equals(action)) {
				
			boolean addCustomer =customerDAOImpl.addCustomer(newCustomer );
				if(addCustomer) {
					request.setAttribute("message","Thank you for registering with us. ");
					rd=request.getRequestDispatcher("Login.jsp");
					rd.forward(request, response);
				}else {
					request.setAttribute("errorMessage","Error occured while Registering.Please try again later..");
					rd=request.getRequestDispatcher("Register.jsp");
					rd.forward(request, response);
				}
				
			}else if("editCustomer".equals(action)) {
				customerId = Integer.parseInt(request.getParameter("customerId"));
				newCustomer.setCustomerId(customerId);
				
				boolean updateCustomer = customerDAOImpl.updateCustomer(newCustomer);
				if(updateCustomer) {
					request.setAttribute("message", "Profile Updated Successfully!!");
					session.setAttribute("customer", newCustomer);
					rd=request.getRequestDispatcher("Home.jsp");
					rd.forward(request, response);
				}else {
					request.setAttribute("errorMessage", "Error occured while Updating Profile.Please try again later.");
					if(null != session) {
						Customer customer=(Customer) session.getAttribute("customer");
						if(null !=customer) {
							request.setAttribute("customer", customer);
							rd=request.getRequestDispatcher("Register.jsp");
							rd.forward(request, response);
						}else {
							request.setAttribute("errorMessage", "Please Login");
							rd=request.getRequestDispatcher("Login.jsp");
							rd.forward(request, response);
						}
					}
				}
				}
			}
		
		
		else {
				request.setAttribute("errorMessage", "firstName,lastName,Address,Contact,Email ID,Password fields are required.");
			rd =request.getRequestDispatcher("Register.jsp");
			rd.forward(request, response);
			}
		}
		
	}


