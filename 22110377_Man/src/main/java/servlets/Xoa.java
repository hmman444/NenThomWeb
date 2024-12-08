package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.XeHoiDao;

@WebServlet(urlPatterns = "/xoa",name = "xoa")
public class Xoa extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Xoa() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String ma =request.getParameter("maXH");
		XeHoiDao.Xoa(ma);
		response.sendRedirect("/laptrinh/ds");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}