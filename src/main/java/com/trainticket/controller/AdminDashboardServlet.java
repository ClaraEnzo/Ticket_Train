package com.trainticket.controller;

import com.trainticket.dao.UserDAO;
import com.trainticket.dao.JourneyDAO;
import com.trainticket.dao.TicketDAO;
import com.trainticket.dao.StationDAO;
import com.trainticket.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    
    private UserDAO userDAO = new UserDAO();
    private JourneyDAO journeyDAO = new JourneyDAO();
    private TicketDAO ticketDAO = new TicketDAO();
    private StationDAO stationDAO = new StationDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Vérifier l'authentification et les permissions admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equals(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Accès refusé");
            return;
        }
        
        // Récupérer les statistiques pour le dashboard
     // Dans la méthode doGet de AdminDashboardServlet
        try {
            // Statistiques générales
            List<User> allUsers = userDAO.getAllUsers();
            List<String> allCities = stationDAO.getAllCities();
            
            // Compter les utilisateurs par rôle
            long totalUsers = allUsers.size();
            long adminCount = allUsers.stream().filter(u -> "ADMIN".equals(u.getRole())).count();
            long clientCount = allUsers.stream().filter(u -> "USER".equals(u.getRole())).count();
            
            // Nouvelles statistiques
            int activeTrains = journeyDAO.getActiveTrainsCount();
            int ticketsSoldToday = ticketDAO.getTicketsSoldToday();
            
            // Ajouter les données aux attributs de requête
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("adminCount", adminCount);
            request.setAttribute("clientCount", clientCount);
            request.setAttribute("totalCities", allCities.size());
            request.setAttribute("activeTrains", activeTrains);
            request.setAttribute("ticketsSoldToday", ticketsSoldToday);
            
            // Récupérer les derniers utilisateurs inscrits
            List<User> recentUsers = userDAO.getRecentUsers(5);
            request.setAttribute("recentUsers", recentUsers);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors du chargement des statistiques");
        }
        
        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }
}