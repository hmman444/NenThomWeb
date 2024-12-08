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

@WebServlet(urlPatterns = "/danhSachXH", name = "danhSachXH")
public class DanhSachXHServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public DanhSachXHServlet() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<ThuongHieu> thuongHieu = XeHoiDao.danhSachThuongHieu();
		request.setAttribute("thuongHieu", thuongHieu);
		if (request.getParameter("locid") != null) {
			if (!request.getParameter("locid").equals("Tất cả")) {
				request.setAttribute("kq", Integer.parseInt(request.getParameter("locid")));
				List<XeHoi> list = XeHoiDao.danhSachXHTheoThuongHieu(Integer.parseInt(request.getParameter("locid")));
				request.setAttribute("list", list);
			} else {
				List<XeHoi> list = XeHoiDao.dachSachXH();
				request.setAttribute("list", list);
			}
			request.getRequestDispatcher("danhSachXH.jsp").forward(request, response);
		} else {
			List<XeHoi> list = XeHoiDao.dachSachXH();
			request.setAttribute("list", list);
			request.getRequestDispatcher("danhSachXH.jsp").forward(request, response);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}