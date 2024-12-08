package servlets;

import java.io.IOException;

import beans.XeHoi;
import dao.XeHoiDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/sua",name = "sua")
public class Sua extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Sua() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String ma = request.getParameter("maXH");
		XeHoi item = XeHoiDao.layxe(ma);
		request.setAttribute("item", item);
		request.getRequestDispatcher("sua.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String ma = request.getParameter("maXH");
		XeHoi item = XeHoiDao.layxe(ma);
		if(item!=null) {
			int idth = Integer.parseInt(request.getParameter("thuongHieuId"));
			float giaBan = Float.parseFloat(request.getParameter("giaBan"));
			int namXX = Integer.parseInt(request.getParameter("namXX"));
			System.out.println(idth+" " +giaBan+" " +namXX+" "+ ma);
			XeHoiDao.Sua(idth, giaBan, namXX, ma);
			response.sendRedirect("/laptrinh/ds");
		}else {
			int idth = Integer.parseInt(request.getParameter("thuongHieuId"));
			float giaBan = Float.parseFloat(request.getParameter("giaBan"));
			int namXX = Integer.parseInt(request.getParameter("namXX"));
			XeHoiDao.Them(idth, giaBan, namXX, ma);
			response.sendRedirect("/laptrinh/ds");
		}
	}

}