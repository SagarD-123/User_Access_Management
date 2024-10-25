package com.accessmanagement.servlet;
import com.accessmanagement.model.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

public class RequestServlet extends HttpServlet {
    
    private static final Logger LOGGER = Logger.getLogger(RequestServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Fetch list of software before showing the form
        SoftwareDAO softwareDAO = new SoftwareDAO();
        List<Software> softwareList = softwareDAO.getAllSoftware();
        request.setAttribute("softwareList", softwareList);
        
        // If user is logged in, get their requests
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null) {
            RequestDAO requestDAO = new RequestDAO();
            List<Request> userRequests = requestDAO.getUserRequests(user.getId());
            LOGGER.info("User ID: " + user.getId());
            LOGGER.info("Number of user requests: " + userRequests.size());
            request.setAttribute("userRequests", userRequests);
        }
        
        request.getRequestDispatcher("/jsp/requestAccess.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        
        try {
            int softwareId = Integer.parseInt(request.getParameter("software_id"));
            String accessType = request.getParameter("access_type");
            String reason = request.getParameter("reason");
            
            Request accessRequest = new Request();
            accessRequest.setUserId(user.getId());
            accessRequest.setSoftwareId(softwareId);
            accessRequest.setAccessType(accessType);
            accessRequest.setReason(reason);
            accessRequest.setStatus("Pending");
            
            RequestDAO requestDAO = new RequestDAO();
            if (requestDAO.addRequest(accessRequest)) {
                request.setAttribute("message", "Request submitted successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to submit request.");
            }
            
            // Redirect back to the same page with updated list
            doGet(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid input data.");
            doGet(request, response);
        }
    }
}
