package web.chuong8;

import java.io.*;
import java.util.ArrayList;
import java.util.Date;

import businessClass.User;
import jakarta.servlet.http.*;
import jakarta.servlet.*;

public class EmailListServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String url = "/index.jsp";

        // get current action
        String action = request.getParameter("action");
        if (action == null) {
            action = "join";  // default action
        }

        if (action.equals("join")) {
            url = "/index.jsp";
        }
        else if (action.equals("add")) {
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");

            User user = new User(firstName, lastName, email);

            // 1. Lưu user vào session để index.jsp hiển thị lại khi Return
            session.setAttribute("user", user);

            // 2. Lưu ArrayList<User> vào session (Yêu cầu Bước 5)
            @SuppressWarnings("unchecked")
            ArrayList<User> users = (ArrayList<User>) session.getAttribute("users");
            if (users == null) {
                users = new ArrayList<User>();
            }
            users.add(user);
            session.setAttribute("users", users);

            // 3. Lưu currentDate vào request (Yêu cầu Bước 5)
            Date currentDate = new Date();
            request.setAttribute("currentDate", currentDate);

            url = "/thanks.jsp";
        }

        getServletContext()
                .getRequestDispatcher(url)
                .forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
