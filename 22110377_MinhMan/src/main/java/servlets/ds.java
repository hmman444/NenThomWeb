package servlets;

import java.io.IOException;
import java.util.List;

import dao.PetDao;
import entities.Pet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/ds", name = "ds")
public class ds extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ds() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<Pet> list = PetDao.getAllPets();
        request.setAttribute("list", list);
        request.getRequestDispatcher("ds.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
