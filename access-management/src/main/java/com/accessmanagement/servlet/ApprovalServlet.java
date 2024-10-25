package com.accessmanagement.servlet;

import com.accessmanagement.model.RequestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class ApprovalServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int requestId = Integer.parseInt(request.getParameter("request_id"));
            String action = request.getParameter("action");

            RequestDAO requestDAO = new RequestDAO();
            boolean success = false;

            if ("approve".equals(action)) {
                success = requestDAO.updateRequestStatus(requestId, "Approved");
            } else if ("reject".equals(action)) {
                success = requestDAO.updateRequestStatus(requestId, "Rejected");
            }

            if (success) {
                request.getSession().setAttribute("message", "Request " + action + "d successfully.");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to update request status.");
            }

            // Redirect back to the manager dashboard
            response.sendRedirect(request.getContextPath() + "/manager");

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Invalid request ID.");
            response.sendRedirect(request.getContextPath() + "/manager");
        }
    }
}