package com.trainticket.controller;

import java.io.IOException;
import java.util.List;

import com.trainticket.dao.UserDAO;
import com.trainticket.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/users")
public class UserListServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    private static final int RECORDS_PER_PAGE = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
    	System.out.println("Début doGet UserListServlet");
    	HttpSession session = request.getSession(false);
        
        // Vérification de l'authentification et du rôle ADMIN
        if (session == null || session.getAttribute("user") == null) {
            System.out.println("Session nulle ou attribut 'user' non trouvé. Redirection vers login.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User loggedInUser = (User) session.getAttribute("user");
        if (!"ADMIN".equals(loggedInUser.getRole())) {
            System.out.println("Utilisateur non ADMIN (" + loggedInUser.getRole() + "). Redirection vers login.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String searchTerm = request.getParameter("search");
        
        int page = 1;
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException e) {
        }

        try {
            int totalUsers = userDAO.getUserCount(searchTerm);
            int totalPages = (int) Math.ceil(totalUsers * 1.0 / RECORDS_PER_PAGE);

            List<User> users = userDAO.getUsersWithPagination(
                (page - 1) * RECORDS_PER_PAGE, 
                RECORDS_PER_PAGE, 
                searchTerm
            );

            request.setAttribute("users", users);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors du chargement des utilisateurs");
            request.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(request, response);
        }
    }
}