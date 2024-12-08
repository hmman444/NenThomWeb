package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import beans.ThuongHieu;
import beans.XeHoi;
import dao.XeHoiDao;

/**
 * Servlet implementation class DSservlet
 */
@WebServlet(urlPatterns = "/ds",name = "ds")
public class DSservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DSservlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<ThuongHieu> thuongHieu = XeHoiDao.DSThuongHieu();
		request.setAttribute("thuongHieu", thuongHieu);
		if(request.getParameter("locid")!=null) {
			if(!request.getParameter("locid").equals("Tất cả")) {
				request.setAttribute("kq", Integer.parseInt(request.getParameter("locid")));
				List<XeHoi> list = XeHoiDao.DSTheoTH(Integer.parseInt(request.getParameter("locid")));
				request.setAttribute("list", list);
			}else {
				List<XeHoi> list = XeHoiDao.DS();
				request.setAttribute("list", list);
			}
			request.getRequestDispatcher("ds.jsp").forward(request, response);
		}else {
			List<XeHoi> list = XeHoiDao.DS();
			request.setAttribute("list", list);
			request.getRequestDispatcher("ds.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
