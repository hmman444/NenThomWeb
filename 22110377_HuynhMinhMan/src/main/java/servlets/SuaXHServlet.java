package servlets;

import java.io.IOException;
import java.util.List;

import dao.XeHoiDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.ThuongHieu;
import models.XeHoi;

@WebServlet(urlPatterns = "/suaThongTinXe", name = "suaThongTinXe")
public class SuaXHServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public SuaXHServlet() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String maXH = request.getParameter("maXH");
		XeHoi xh = XeHoiDao.chonXeTheoID(maXH);
		List<ThuongHieu> listTH = XeHoiDao.danhSachThuongHieu();
		request.setAttribute("xh", xh);
		request.setAttribute("listTH", listTH);
		request.getRequestDispatcher("suaThongTinXe.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String maXH = request.getParameter("maXH");
		XeHoi xh = XeHoiDao.chonXeTheoID(maXH);
		if (xh != null) {
			int idth = Integer.parseInt(request.getParameter("thuongHieuId"));
			float giaBan = Float.parseFloat(request.getParameter("giaBan"));
			int namXX = Integer.parseInt(request.getParameter("namXX"));
			XeHoiDao.sua(idth, giaBan, namXX, maXH);
			response.sendRedirect("/22110377_HuynhMinhMan/danhSachXH");
		} else {
			int idth = Integer.parseInt(request.getParameter("thuongHieuId"));
			float giaBan = Float.parseFloat(request.getParameter("giaBan"));
			int namXX = Integer.parseInt(request.getParameter("namXX"));
			XeHoiDao.them(idth, giaBan, namXX, maXH);
			response.sendRedirect("/22110377_HuynhMinhMan/danhSachXH");
		}
	}

}