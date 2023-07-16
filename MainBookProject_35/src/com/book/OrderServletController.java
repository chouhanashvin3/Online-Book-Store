package com.book;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.book.daoImpl.OrderDAOImpl;
import com.book.pojo.Customer;
import com.book.pojo.Order;

/**
 * Servlet implementation class OrderServletController
 */
@WebServlet(description = "it will describe the order related operation", urlPatterns = { "/OrderServletController" })
public class OrderServletController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 Integer orderId;
	// order from whom
	 String emailId;
	 Integer customerId;

	 String orderDate;
	 String status; // shipped, placed, delivered
	 String shippingAddress;
	 Double totalCost;

	 HttpSession session;
	 RequestDispatcher rd;
	 Customer customer;
	 String page;
	 DateTimeFormatter format = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	 Order order=null;
	 OrderDAOImpl orderDAOImpl = null;
	 List <Order> orderList=new ArrayList<>();
	 
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrderServletController() {
        super();
        orderDAOImpl =new OrderDAOImpl();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action =request.getParameter("action");
		session =request.getSession();
		
				if("orderHistory".equals(action)) {
					if(null !=session) {
						customer =(Customer) session.getAttribute("customer");
						if(null != customer) {
					orderList =orderDAOImpl.viewMyOrderHistory(customer.getEmailId());
					if(null != orderList && !orderList.isEmpty()) {
						session.setAttribute("orderList", orderList);
						page="OrderList.jsp";
					}else {
						request.setAttribute("message", "You have not ordered anything yet.Please Place Order to view ");
						page="Home.jsp";
					}
				}
			}
		}else if("cancelOrder".equals(action)) {
			if(null !=session) {
				customer =(Customer) session.getAttribute("customer");
				if(null != customer) {
					orderId=Integer.parseInt(request.getParameter("orderId"));
					boolean cancelOrder =orderDAOImpl.cancelOrder(orderId);
					if(cancelOrder) {
						request.setAttribute("message", "Order Cancelled Sucessfully.");
						page="OrderServletController?action=orderHistory";
					}else {
						request.setAttribute("errorMessage", "Error while cancelling the order.Please try again.");
						page="OrderServletController?action=orderHistory";
					}
				  }
				}
			}
			else if("allOrders".equals(action)) {
				orderList =orderDAOImpl.viewAllOrders();
				if(null != orderList && !orderList.isEmpty()) {
					session.setAttribute("orderList", orderList);
					page="OrderList.jsp";
				}else {
					request.setAttribute("message", "No Orders.");
					page="Home.jsp";
				}
				
			}else if("showDetails".equals(action))  {
				orderId=Integer.parseInt(request.getParameter("orderId"));
				List<Order> orderDetailsList =orderDAOImpl.viewOrderDetailsByOrderId(orderId);
				
				if(null != orderDetailsList && !orderDetailsList.isEmpty()) {
					session.setAttribute("orderDetails", orderDetailsList);
					page="OrderDetails.jsp";
				}else {
					request.setAttribute("message", "You have not ordered anything yet.Please Place Order.");
					page="Home.jsp";
				}
			}else if("updateStatus".equals(action)) {
				orderId=Integer.parseInt(request.getParameter("orderId"));
				status=request.getParameter("status");
				boolean updateStatus=orderDAOImpl.updateStatus(orderId, status);
				if(updateStatus) {
					request.setAttribute("message", "Status Updated Successfully");
					page="OrderServletController?action=allOrders";
				}else {
					request.setAttribute("errorMessage", "Error while updating status.Please try again.");
					page="OrderServletController?action=allOrders";
				}
			}
			
			else {
				request.setAttribute("errorMessage", "Please login first to view order history.");
				page="Login.jsp";
			}
	
		
		rd= request.getRequestDispatcher(page);
		rd.forward(request, response);
	
    } 

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action =request.getParameter("action");
		session = request.getSession();
		if(null != session) {
			customer=(Customer) session.getAttribute("customer");
			if(null != customer) {
		if("placeOrder".equals(action)) {
			totalCost = Double.parseDouble(request.getParameter("totalCost"));
			orderDate= LocalDateTime.now().format(format);
			status ="In Process";
			
			order =new Order();
			order.setEmailId(customer.getEmailId());
			order.setCustomerId(customer.getCustomerId());
			order.setOrderDate(orderDate);
			order.setStatus(status);
			order.setTotalCost(totalCost);
			
			session.setAttribute("orderObj", order);
			page="ConfirmOrder.jsp";
			
		}else if("confirmOrder".equals(action)) {
			shippingAddress=request.getParameter("shippingAddress");
			order=(Order) session.getAttribute("orderObj");
			order.setShippingAddress(shippingAddress);
			Order placedOrder = orderDAOImpl.placeOrder(order);
			if(null != placedOrder) {
				LocalDate parsedDate=LocalDate.parse(placedOrder.getOrderDate(),format);
				LocalDate deliveryDate = parsedDate.plusDays(5);
				
				format=DateTimeFormatter.ofPattern("dd- LLLL- yyyy");
				String delivery =deliveryDate.format(format);
				
				request.setAttribute("message", "Order Placed Successfully and will be delivered by "+ delivery);
				page="Home.jsp";
			}
		}
		
	}else {
		request.setAttribute("errorMessage", "Please Login first to add this book to cart.");
		page ="Login.jsp";
	}
		

}
		rd=request.getRequestDispatcher(page);
		rd.forward(request, response);
	}
}
