package com.book;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.book.daoImpl.BookDAOImpl;
import com.book.pojo.Book;
import com.book.pojo.Customer;

/**
 * Servlet implementation class BookServletController
 */
@WebServlet(description = "Controller for all book related operations", urlPatterns = { "/BookServletController" })
public class BookServletController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 Integer bookId;
	 String bookName;
	 String description;
	 String author;
	 String publisher;
	 String category;
	 String isbn;
	 Double price;
	 Integer quantityOfAvailableBooks;
	 Double bookRating;
	 String bookImage;
       BookDAOImpl bookDAOImpl;
       RequestDispatcher requestDispatcher;
       String page ="";
       List<Book> bookList=new ArrayList<>();
       Book book=null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookServletController() {
        super();
        bookDAOImpl =new BookDAOImpl();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action=request.getParameter("action");
		if("viewBookDetails".equals(action)) {
			String bookId=request.getParameter("bookId");
			Book book=bookDAOImpl.viewBookByBookId(Integer.parseInt(bookId));
			request.setAttribute("bookDetail", book);
			page ="BookDetails.jsp";
		}else if("viewBookByCategory".equals(action)) {
			 category=request.getParameter("category");
			
			List<Book> bookByCategory =bookDAOImpl.viewAllBooksByCategory(category);
			if(null != bookByCategory && !bookByCategory.isEmpty() ) {
			request.setAttribute("bookList", bookByCategory);
			page="Books.jsp";
			}else {
				request.setAttribute("message","No books In This category-"+category);
				page="Home.jsp";
			}
		}else if("viewBookByAuthor".equals(action)){
			author =request.getParameter("author");
			List<Book> bookByAuthor =bookDAOImpl.viewBooksByAuthor(author);
			if(null != bookByAuthor && !bookByAuthor.isEmpty()) {
				request.setAttribute("bookList", bookByAuthor);
				page="Books.jsp";
			}else {
				request.setAttribute("errorMessage", "No Books By Author-"+author);
				page ="Home.jsp";
			}
			
		}else if("viewAllBooks".equals(action)) {
			bookList =bookDAOImpl.viewAllBooks();
			if(null !=bookList && !bookList.isEmpty()) {
				request.setAttribute("bookList", bookList);
				page="AllBooks.jsp";
			}else {
				request.setAttribute("errorMessage", "No Books");
				page="AllBooks.jsp";
			}
		}else if("addBook".equals(action)) {
			page="AddBook.jsp";
		}else if("updateBook".equals(action)){
			bookId =Integer.parseInt(request.getParameter("bookId"));
			book=bookDAOImpl.viewBookByBookId(bookId);
			request.setAttribute("book", book);
			page="AddBook.jsp";
		}else if("deleteBook".equals(action)) {
			bookId =Integer.parseInt(request.getParameter("bookId"));
			boolean deleteBook =bookDAOImpl.deleteBook(bookId);
			if(deleteBook) {
				request.setAttribute("message", "Book deleted Successfully.");
				page="BookServletController?action=viewAllBooks";
				
			}else {
				request.setAttribute("errorMessage", "Error while deleting book");
				page="BookServletController?action=viewAllBooks";
			}
		}else if("updateImage".equals(action)) {
			bookId=Integer.parseInt(request.getParameter("bookId"));
			
			page="UpdateImage.jsp?bookId="+ bookId;
		}
		requestDispatcher=request.getRequestDispatcher(page);
		requestDispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		String action =request.getParameter("action");
		bookName =request.getParameter("bookName").trim();
		description =request.getParameter("description").trim();
		author =request.getParameter("author").trim();
		publisher =request.getParameter("publisher").trim();
		category =request.getParameter("category").trim();
		isbn =request.getParameter("isbn").trim();
		price =Double. parseDouble(request.getParameter("price").trim());
		quantityOfAvailableBooks =Integer.parseInt( request.getParameter("quantityOfAvailableBooks").trim());
		bookRating =Double. parseDouble(request.getParameter("bookRating").trim());
		if((null !=bookName ||"" != bookName) ||(null !=description ||"" !=description)||(null !=author ||"" != author)||(null !=publisher ||"" != publisher)||(null !=category ||"" != category)||(null !=isbn ||"" != isbn)||(null !=price ||0 != price)||(null !=quantityOfAvailableBooks ||0 != quantityOfAvailableBooks)||(null !=bookRating ||0 != bookRating)) {
			Book newBook = new Book();
			newBook.setBookName(bookName);
			newBook.setDescription(description);
			newBook.setAuthor(author);
			newBook.setPublisher(publisher);
			newBook.setCategory(category);
			newBook.setIsbn(isbn);
			newBook.setPrice(price);
			newBook.setQuantityOfAvailableBooks(quantityOfAvailableBooks);
			newBook.setBookRating(bookRating);
			if("addBook".equals(action)) {
				
				boolean addBook =bookDAOImpl.addBook(newBook);
					if(addBook) {
						request.setAttribute("message","Book Added Successfully. ");
						response.sendRedirect("BookServletController?action=viewAllBooks");
						
					}else {
						request.setAttribute("errorMessage","Error occured while Adding Book.Please try again later..");
						requestDispatcher=request.getRequestDispatcher("AddBook.jsp");
						requestDispatcher.forward(request, response);
					}
					
				}else if("editBook".equals(action)) {
					bookId = Integer.parseInt(request.getParameter("bookId"));
					newBook.setBookId(bookId);
					
					boolean updateBook = bookDAOImpl.updateBook(newBook);
					if(updateBook) {
						request.setAttribute("message", "Book Updated Successfully!!");
						session.setAttribute("book", newBook);
						response.sendRedirect("BookServletController?action=viewAllBooks");
					}else {
						request.setAttribute("errorMessage", "Error occured while Updating Book.Please try again later.");
						
								requestDispatcher=request.getRequestDispatcher("AddBook.jsp");
								requestDispatcher.forward(request, response);
							}
						
					
					}
				}
			
			
			else {
					request.setAttribute("errorMessage", "bookName,description,author,publisher,category ,isbn,price,quantityOfAvailableBooks,bookRating fields are required.");
					requestDispatcher =request.getRequestDispatcher("AddBook.jsp");
					requestDispatcher.forward(request, response);
				}
	}

}
