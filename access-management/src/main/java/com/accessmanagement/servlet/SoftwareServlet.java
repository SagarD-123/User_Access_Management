package com.accessmanagement.servlet;

import com.accessmanagement.model.Software;
import com.accessmanagement.model.SoftwareDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

public class SoftwareServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String role = (String) session.getAttribute("role");

        SoftwareDAO softwareDAO = new SoftwareDAO();
        List<Software> softwareList = softwareDAO.getAllSoftware();

        // Add this debug line
        System.out.println("Software list size: " + softwareList.size());

        request.setAttribute("softwareList", softwareList);

        if ("Admin".equals(role)) {
            request.getRequestDispatcher("/WEB-INF/jsp/adminDashboard.jsp").forward(request, response);
        } else if ("User".equals(role)) {
            request.getRequestDispatcher("/WEB-INF/jsp/userDashboard.jsp").forward(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    // @Override
    // protected void doPost(HttpServletRequest request, HttpServletResponse response)
    //         throws ServletException, IOException {
    //     String action = request.getParameter("action");

    //     if ("createSoftware".equals(action)) {
    //         String name = request.getParameter("name");
    //         String description = request.getParameter("description");
    //         String accessLevel = request.getParameter("access_levels"); // Correct parameter name

    //         Software software = new Software(name, description, accessLevel);
    //         SoftwareDAO softwareDAO = new SoftwareDAO();

    //         if (softwareDAO.addSoftware(software)) {
    //             response.sendRedirect("software"); // Redirect to the software list
    //         } else {
    //             request.setAttribute("errorMessage", "Failed to create software.");
    //             request.getRequestDispatcher("/jsp/adminDashboard.jsp").forward(request, response);
    //         }
    //     }
    // }
}
