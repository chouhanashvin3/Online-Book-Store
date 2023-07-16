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

import com.book.daoImpl.BookDAOImpl;
import com.book.daoImpl.CartDAOImpl;
import com.book.pojo.Book;
import com.book.pojo.Cart;
import com.book.pojo.Customer;

/**
 * Servlet implementation class CartServletController
 */
@WebServlet(description = "this is Controller to handle all cart related operation", urlPatterns = { "/CartServletController" })
public class CartServletController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
     Integer cartId;
   	 Integer bookId;
   	 Integer quantity;
   	 String emailId;
   	 Integer customerId;
       
   	 BookDAOImpl bookDAOImpl;
     CartDAOImpl cartDAOImpl;
      
     HttpSession session;
     
     Customer customer;
     Book book;
     String page="";
      
     RequestDispatcher requestDispatcher;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CartServletController() {
        super();
        bookDAOImpl =new  BookDAOImpl();
        cartDAOImpl =new CartDAOImpl();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		session=request.getSession();
		String action =request.getParameter("action");
		if(null != session) {
			customer=(Customer) session.getAttribute("customer");
			if(null != customer) {
		if("addToCart".equals(action)) {
			bookId=Integer.parseInt(request.getParameter("bookId"));
			
			boolean checkBookInCart =cartDAOImpl.checkBookInCart(bookId, customer.getEmailId());
			if(checkBookInCart) {
				request.setAttribute("message", "Book already present in your Cart,increment quantity by 1.");
				page="Home.jsp";
				
			}else {
				quantity =1;
				Cart cart=new Cart();
				cart.setBookId(bookId);
				cart.setCustomerId(customer.getCustomerId());
				cart.setEmailId(customer.getEmailId());
				cart.setQuantity(quantity);
				cart.setBook(bookDAOImpl.viewBookByBookId(bookId));
				
				boolean addToCart =cartDAOImpl.addToCart(cart);
				if(addToCart) {
					request.setAttribute("message", "Book added to your cart.");
					page ="Home.jsp";
				}else {
					request.setAttribute("errorMessage", "error while adding book into cart,Please try again!");
					page="Home.jsp";
				}
				
			}
				
			}else if("viewCart".equals(action)) {
				List<Cart> showMyCart =cartDAOImpl.showMyCart(customer.getEmailId());
				if(null != showMyCart && !showMyCart.isEmpty()) {
					session.setAttribute("cart", showMyCart);
					page ="MyCart.jsp";
				}else {
					request.setAttribute("message", "No Books in your cart.Please add books to view Cart.");
					page ="Home.jsp";
				}
				
				}else if("deleteItem".equals(action)) {
					cartId =Integer.parseInt(request.getParameter("cartId"));
					boolean removeCartItem =cartDAOImpl.removeCartItem(cartId);
					if(removeCartItem) {
						request.setAttribute("message", "Book from cart removed successfully");
						page="CartServletController?action=viewCart";
					}else {
						request.setAttribute("message", "Error while removing book from cart.Please try again!");
						page ="Home.jsp";
					}
				}
			}else {
				request.setAttribute("errorMessage", "Please Login first to add this book to cart");
				page="Login.jsp";
			}
			
		}
		requestDispatcher=request.getRequestDispatcher(page);
		requestDispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action =request.getParameter("action");
		if("updateQuantity".equals(action)) {
		quantity =Integer.parseInt(request.getParameter("quantity"));
		 cartId=Integer.parseInt( request.getParameter("cartId"));
		 cartDAOImpl.updateQuantity(cartId, quantity);
		}
		 
		
		
	}

}
