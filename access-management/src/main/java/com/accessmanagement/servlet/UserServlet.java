package com.accessmanagement.servlet;

import com.accessmanagement.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

public class UserServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(UserServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        SoftwareDAO softwareDAO = new SoftwareDAO();
        List<Software> softwareList = softwareDAO.getAllSoftware();
        request.setAttribute("softwareList", softwareList);

        RequestDAO requestDAO = new RequestDAO();
        LOGGER.info("User ID: " + user.getId());
        List<Request> userRequests = requestDAO.getUserRequests(user.getId());
        LOGGER.info("Number of user requests: " + userRequests.size());
        request.setAttribute("userRequests", userRequests);

        request.getRequestDispatcher("/jsp/userDashboard.jsp").forward(request, response);
    }
}


//package com.accessmanagement.servlet;
//
//import com.accessmanagement.model.*;
//import jakarta.servlet.*;
//import jakarta.servlet.http.*;
//import java.io.IOException;
//import java.util.List;
//
//public class UserServlet extends HttpServlet {
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        User user = (User) session.getAttribute("user");
//        
//        if (user != null && user.getRole().equals("Employee")) {
//            // Fetch available software for the user
//            SoftwareDAO softwareDAO = new SoftwareDAO();
//            List<Software> softwareList = softwareDAO.getAllSoftware();
//            request.setAttribute("softwareList", softwareList);
//            
//            // Fetch user's pending requests
//            RequestDAO requestDAO = new RequestDAO();
//            List<Request> userRequests = requestDAO.getUserRequests(user.getId());
//            request.setAttribute("userRequests", userRequests);
//            
//            request.getRequestDispatcher("/jsp/userDashboard.jsp").forward(request, response);
//        } else {
//            response.sendRedirect("login");
//        }
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        // Handle access request submissions here (form submission)
//    }
//}
