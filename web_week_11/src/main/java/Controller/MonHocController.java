package Controller;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import DBConnection.ConnectJDBC;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.MonHoc;
import utils.DBUtils;

@WebServlet("/MonHocController")
public class MonHocController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public MonHocController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        List<MonHoc> listMH = null;
        List<MonHoc> listTenMH = null;

        try {
            conn = new ConnectJDBC().getConnection();
            listMH = DBUtils.DanhSachMH(conn);
            listTenMH = DBUtils.DanhSachMH(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("ListMH", listMH);
        request.setAttribute("ListTenMH", listTenMH);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/home.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
