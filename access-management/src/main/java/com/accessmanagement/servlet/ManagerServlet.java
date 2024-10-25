package com.accessmanagement.servlet;

import com.accessmanagement.model.Request;
import com.accessmanagement.model.RequestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class ManagerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Fetch pending requests
        RequestDAO requestDAO = new RequestDAO();
        List<Request> pendingRequests = requestDAO.getPendingRequests();

        // Set attributes
        request.setAttribute("pendingRequests", pendingRequests);

        // Check for messages in the session
        HttpSession session = request.getSession();
        String message = (String) session.getAttribute("message");
        String errorMessage = (String) session.getAttribute("errorMessage");

        if (message != null) {
            request.setAttribute("message", message);
            session.removeAttribute("message");
        }
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            session.removeAttribute("errorMessage");
        }

        // Forward to manager dashboard
        request.getRequestDispatcher("/jsp/managerDashboard.jsp").forward(request, response);
    }

    // Remove the doPost method as it's no longer needed
}
