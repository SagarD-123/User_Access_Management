package com.accessmanagement.servlet;

import com.accessmanagement.model.User;
import com.accessmanagement.model.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class SignUpServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/signup.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User user = new User(username, password, role);
        UserDAO userDAO = new UserDAO();

        if (userDAO.addUser(user)) {
            response.sendRedirect("login");
        } else {
            request.setAttribute("errorMessage", "User already exists.");
            request.getRequestDispatcher("/jsp/signup.jsp").forward(request, response);
        }
    }
}
