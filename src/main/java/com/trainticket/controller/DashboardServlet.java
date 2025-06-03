package com.trainticket.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.trainticket.dao.UserDAO;
import com.trainticket.model.User;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        
     // Vérifier s'il y a un message de succès d'inscription
        String registrationSuccess = (String) session.getAttribute("registrationSuccess");
        if (registrationSuccess != null) {
            request.setAttribute("success", registrationSuccess);
            session.removeAttribute("registrationSuccess");
        }
        // Check if user is logged in
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Récupérer les informations utilisateur mises à jour
            User updatedUser = userDAO.getUserById(user.getUserId());
            if (updatedUser != null) {
                session.setAttribute("user", updatedUser);
                request.setAttribute("user", updatedUser);
            } else {
                request.setAttribute("user", user);
            }

            // Ajouter des statistiques utilisateur si nécessaire
            request.setAttribute("welcomeMessage", "Bienvenue, " + user.getFullName());
            
            // Si l'utilisateur est admin, ajouter des informations spéciales
            if ("ADMIN".equals(user.getRole())) {
                request.setAttribute("isAdmin", true);
                request.setAttribute("adminMessage", "Vous avez accès à l'espace d'administration");
            }

            // Forward to dashboard JSP
            request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors du chargement du tableau de bord: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}