package servlets;

import java.io.IOException;

import dao.XeHoiDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/xoa", name = "xoa")
public class XoaXHServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public XoaXHServlet() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String ma = request.getParameter("maXH");
		XeHoiDao.xoa(ma);
		response.sendRedirect("/22110377_HuynhMinhMan/danhSachXH");
	}

}