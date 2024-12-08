<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import = "beans.Products" %>
<%@page import = "servlets.CartServlet" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cửa hàng bán sách online</title>
<style>
    /* Styling for the header and footer */
    header {
        display: flex;
        justify-content: space-between;
        padding: 10px;
        background-color: #f1f1f1;
        height: 50px;
    }
    footer {
        display: flex;
        justify-content: flex-end; 
        padding: 10px;
        background-color: #f1f1f1;
        position: fixed;
        width: 100%;
        bottom: 0;
        right: 0;
        height: 50px;
    }
    .footer-content {
        text-align: right; /* Canh phải nội dung bên trong */
    }
    .right {
        text-align: right;
    }
    .container {
        margin-bottom: 50px; 
    }
</style>
</head>
<body>

    <!-- Header section with logo -->
    <header>
        <h1>Cửa hàng bán sách online</h1>
        <img src="images/cho.jpg" style="height:50px;"> 
    </header>
    
    <!-- Main content -->
    <div class="container">
        <table>
            <tr>
                <th>Mô tả</th>
                <th class="right">Giá</th>
                <th>&nbsp;</th>
            </tr>
            <tr>
                <td>Harry Potter</td>
                <td class="right">450.000</td>
                <td>
                    <form action="cart" method="post">
                        <input type="hidden" name="product" value="Harry Potter">
                        <input type="submit" value="Add to cart">
                    </form>
                </td>
            </tr>
            <tr>
                <td>Không phải sói, cũng chẳng phải cừu</td>
                <td class="right">130.000</td>
                <td>
                    <form action="cart" method="post">
                        <input type="hidden" name="product" value="Không phải sói, cũng chẳng phải cừu">
                        <input type="submit" value="Add to cart">
                    </form>
                </td>
            </tr>
        </table>
    </div>

    <!-- Footer section with current time and date -->
    <footer>
        <div class="footer-content">
            <%
                // Định dạng giờ với AM/PM
                SimpleDateFormat timeFormatter = new SimpleDateFormat("hh:mm a");
                String currentTime = timeFormatter.format(new Date());
                
                // Định dạng ngày tháng năm
                SimpleDateFormat dateFormatter = new SimpleDateFormat("dd/MM/yyyy");
                String currentDate = dateFormatter.format(new Date());
            %>
            <p><%= currentTime %><br><%= currentDate %></p>
        </div>
    </footer>

</body>
</html>
