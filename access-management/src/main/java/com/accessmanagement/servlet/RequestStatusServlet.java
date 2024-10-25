package com.accessmanagement.servlet;

import com.accessmanagement.model.Request;
import com.accessmanagement.model.RequestDAO;
import com.accessmanagement.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class RequestStatusServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null) {
            RequestDAO requestDAO = new RequestDAO();
            List<Request> userRequests = requestDAO.getUserRequests(user.getId());

            request.setAttribute("userRequests", userRequests);
            request.getRequestDispatcher("/jsp/requestTable.jsp").forward(request, response);
        } else {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        }
    }
}
