package com.accessmanagement.servlet;

import com.accessmanagement.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("user");

        if (admin == null || !"Admin".equals(admin.getRole())) {
            response.sendRedirect("login");
            return;
        }

        // Fetch software created by this admin
        SoftwareDAO softwareDAO = new SoftwareDAO();
        List<Software> adminSoftwareList = softwareDAO.getAdminSoftware(admin.getId());

        // Fetch all requests for approval/rejection
        RequestDAO requestDAO = new RequestDAO();
        List<Request> allRequests = requestDAO.getAllRequests();

        // Fetch all software for the admin to request access
        List<Software> allSoftware = softwareDAO.getAllSoftware();

        // Set attributes and forward to admin dashboard
        request.setAttribute("softwareList", adminSoftwareList);
        request.setAttribute("allRequests", allRequests);
        request.setAttribute("allSoftware", allSoftware);
        request.getRequestDispatcher("/jsp/adminDashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("createSoftware".equals(action)) {
            createSoftware(request, response);
        } else if ("requestAccess".equals(action)) {
            requestAccess(request, response);
        } else if ("approveReject".equals(action)) {
            approveRejectRequest(request, response);
        }
    }

    private void createSoftware(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String softwareName = request.getParameter("name");
        String description = request.getParameter("description");
        String accessLevels = request.getParameter("access_levels");

        Software newSoftware = new Software(softwareName, description, accessLevels);
        SoftwareDAO softwareDAO = new SoftwareDAO();

        if (softwareDAO.addSoftware(newSoftware)) {
            request.setAttribute("message", "Software created successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to create software.");
        }

        doGet(request, response);
    }

    private void requestAccess(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("user");

        int softwareId = Integer.parseInt(request.getParameter("software_id"));
        String accessType = request.getParameter("access_type");
        String reason = request.getParameter("reason");

        Request accessRequest = new Request();
        accessRequest.setUserId(admin.getId()); // admin.getId() already returns an int
        accessRequest.setSoftwareId(softwareId);
        accessRequest.setAccessType(accessType);
        accessRequest.setReason(reason);
        accessRequest.setStatus("Pending");

        RequestDAO requestDAO = new RequestDAO();
        if (requestDAO.addRequest(accessRequest)) {
            request.setAttribute("message", "Access request submitted successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to submit access request.");
        }

        doGet(request, response);
    }

    private void approveRejectRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int requestId = Integer.parseInt(request.getParameter("request_id"));
        String status = request.getParameter("status");

        RequestDAO requestDAO = new RequestDAO();
        if (requestDAO.updateRequestStatus(requestId, status)) {
            request.setAttribute("message", "Request " + status + " successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to update request status.");
        }

        doGet(request, response);
    }
}
