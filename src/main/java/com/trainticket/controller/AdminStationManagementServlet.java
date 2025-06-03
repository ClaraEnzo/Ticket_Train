package com.trainticket.controller;

import com.trainticket.dao.StationDAO;
import com.trainticket.model.Station;
import com.trainticket.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/stations")
public class AdminStationManagementServlet extends HttpServlet {
    
    private StationDAO stationDAO = new StationDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        if (!isAdmin(request, response)) return;
        
        String action = request.getParameter("action");
        
        if ("edit".equals(action)) {
            handleEditStation(request, response);
        } else if ("delete".equals(action)) {
            handleDeleteStation(request, response);
        } else {
            handleListStations(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        if (!isAdmin(request, response)) return;
        
        String action = request.getParameter("action");
        
        if ("create".equals(action)) {
            handleCreateStation(request, response);
        } else if ("update".equals(action)) {
            handleUpdateStation(request, response);
        }
    }
    
    private boolean isAdmin(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equals(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Accès refusé");
            return false;
        }
        return true;
    }
    
    private void handleListStations(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            List<Station> stations = stationDAO.getAllStations();
            request.setAttribute("stations", stations);
            request.getRequestDispatcher("/WEB-INF/views/admin/stations.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors du chargement des stations");
            request.getRequestDispatcher("/WEB-INF/views/admin/stations.jsp").forward(request, response);
        }
    }
    
    private void handleCreateStation(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String city = request.getParameter("city");
        String address = request.getParameter("address");
        
        // Validation
        if (name == null || city == null || name.trim().isEmpty() || city.trim().isEmpty()) {
            request.setAttribute("error", "Le nom et la ville sont obligatoires");
            handleListStations(request, response);
            return;
        }
        
        Station station = new Station();
        station.setName(name.trim());
        station.setCity(city.trim());
        station.setAddress(address != null ? address.trim() : "");
        station.setActive(true);
        
        try {
            if (stationDAO.addStation(station)) {
                request.setAttribute("success", "Station créée avec succès");
            } else {
                request.setAttribute("error", "Erreur lors de la création de la station");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors de la création de la station");
        }
        
        handleListStations(request, response);
    }
    
    private void handleEditStation(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String stationIdStr = request.getParameter("id");
        if (stationIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/admin/stations");
            return;
        }
        
        try {
            int stationId = Integer.parseInt(stationIdStr);
            Station station = stationDAO.getStationById(stationId);
            
            if (station != null) {
                request.setAttribute("editStation", station);
            } else {
                request.setAttribute("error", "Station non trouvée");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID station invalide");
        }
        
        handleListStations(request, response);
    }
    
    private void handleUpdateStation(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String stationIdStr = request.getParameter("stationId");
        String name = request.getParameter("name");
        String city = request.getParameter("city");
        String address = request.getParameter("address");
        
        try {
            int stationId = Integer.parseInt(stationIdStr);
            Station station = stationDAO.getStationById(stationId);
            
            if (station != null) {
                station.setName(name.trim());
                station.setCity(city.trim());
                station.setAddress(address != null ? address.trim() : "");
                
                if (stationDAO.updateStation(station)) {
                    request.setAttribute("success", "Station mise à jour avec succès");
                } else {
                    request.setAttribute("error", "Erreur lors de la mise à jour");
                }
            } else {
                request.setAttribute("error", "Station non trouvée");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors de la mise à jour");
        }
        
        handleListStations(request, response);
    }
    
    private void handleDeleteStation(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String stationIdStr = request.getParameter("id");
        
        try {
            int stationId = Integer.parseInt(stationIdStr);
            
            if (stationDAO.deleteStation(stationId)) {
                request.setAttribute("success", "Station supprimée avec succès");
            } else {
                request.setAttribute("error", "Erreur lors de la suppression");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors de la suppression");
        }
        
        handleListStations(request, response);
    }
}