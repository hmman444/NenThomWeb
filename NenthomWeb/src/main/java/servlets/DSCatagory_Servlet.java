package servlets;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.AccessControlUtil;

@WebServlet("/servlets/DSCatagory_Servlet")
public class DSCatagory_Servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DSCatagory_Servlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Chỉ cho phép manager truy cập
        if (!AccessControlUtil.requireManager(request, response)) return;

        // Tạm thời chưa có xử lý gì
    }
}
