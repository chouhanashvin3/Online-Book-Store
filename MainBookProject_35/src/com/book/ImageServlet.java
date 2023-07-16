package com.book;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;

import com.book.daoImpl.BookDAOImpl;


/**
 * Servlet implementation class ImageServlet
 */
@WebServlet(description = "ImageServlet related to upload image", urlPatterns = { "/ImageServlet" })
public class ImageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       HttpSession session;
       String bookImage;
       Integer bookId;
       BookDAOImpl bookDAOImpl=null;
       RequestDispatcher requestDispatcher;
   
    public ImageServlet() {
        super();
        bookDAOImpl =new BookDAOImpl();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ServletFileUpload sf=new ServletFileUpload(new org.apache.commons.fileupload.disk.DiskFileItemFactory());
		session =request.getSession();
		try {
		List<FileItem> files=sf.parseRequest(request);
		if(files != null && files.isEmpty() != true) {
			System.out.println(files);
			for(FileItem f :files) {
				bookImage=f.getName();
				System.out.println(bookImage);
				File file=new File("C:\\Users\\KHUSHI\\eclipse-workspace\\MainBookProject_35\\WebContent\\images",bookImage);
				System.out.println(file);
						f.write(file);
		}
			
			String Id=(String) session.getAttribute("bookId");
			bookId=Integer.parseInt(Id);
			boolean updateImage =bookDAOImpl.updateImage(bookImage,bookId);
			if(updateImage) {
				session.setAttribute("message", "Book Image Updated Successfully.");
				response.sendRedirect("BookServletController?action=viewAllBooks");
			}else {
				session.setAttribute("errorMessage", "Error while updating Book Image.");
				response.sendRedirect("BookServletController?action=updateImage&bookId="+bookId);
			}
			
	}
	}catch(FileUploadException e) {
		e.printStackTrace();
	}catch(Exception e) {
		e.printStackTrace();
	}

}
}
