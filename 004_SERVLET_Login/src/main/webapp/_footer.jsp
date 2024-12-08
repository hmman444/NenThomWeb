<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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