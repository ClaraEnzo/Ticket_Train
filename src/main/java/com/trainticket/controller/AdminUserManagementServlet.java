package com.trainticket.controller;

import com.trainticket.dao.UserDAO;
import com.trainticket.model.User;
import com.trainticket.util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users")
public class AdminUserManagementServlet extends HttpServlet {
    
    private UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Vérifier les permissions admin
        if (!isAdmin(request, response)) return;
        
        String action = request.getParameter("action");
        
        if ("edit".equals(action)) {
            handleEditUser(request, response);
        } else if ("delete".equals(action)) {
            handleDeleteUser(request, response);
        } else {
            handleListUsers(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Vérifier les permissions admin
        if (!isAdmin(request, response)) return;
        
        String action = request.getParameter("action");
        
        if ("create".equals(action)) {
            handleCreateUser(request, response);
        } else if ("update".equals(action)) {
            handleUpdateUser(request, response);
        } else if ("toggleStatus".equals(action)) {
            handleToggleUserStatus(request, response);
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
    
    private void handleListUsers(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            List<User> users = userDAO.getAllUsers();
            request.setAttribute("users", users);
            request.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors du chargement des utilisateurs");
            request.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(request, response);
        }
    }
    
    private void handleCreateUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String role = request.getParameter("role");
        
        // Validation
        if (username == null || password == null || email == null || 
            fullName == null || role == null ||
            username.trim().isEmpty() || password.trim().isEmpty() || 
            email.trim().isEmpty() || fullName.trim().isEmpty()) {
            
            request.setAttribute("error", "Les champs obligatoires doivent être remplis");
            handleListUsers(request, response);
            return;
        }
        
        // Vérifier si l'utilisateur existe déjà
        if (userDAO.getUserByUsername(username) != null) {
            request.setAttribute("error", "Ce nom d'utilisateur existe déjà");
            handleListUsers(request, response);
            return;
        }
        
        // Créer le nouvel utilisateur
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(PasswordUtil.hashPassword(password));
        newUser.setEmail(email);
        newUser.setFullName(fullName);
        newUser.setPhone(phone);
        newUser.setRole(role);
        newUser.setActive(true);
        
        try {
            if (userDAO.addUser(newUser)) {
                request.setAttribute("success", "Utilisateur créé avec succès");
            } else {
                request.setAttribute("error", "Erreur lors de la création de l'utilisateur");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors de la création de l'utilisateur");
        }
        
        handleListUsers(request, response);
    }
    
    private void handleEditUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String userIdStr = request.getParameter("id");
        if (userIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }
        
        try {
            int userId = Integer.parseInt(userIdStr);
            User user = userDAO.getUserById(userId);
            
            if (user != null) {
                request.setAttribute("editUser", user);
            } else {
                request.setAttribute("error", "Utilisateur non trouvé");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID utilisateur invalide");
        }
        
        handleListUsers(request, response);
    }
    
    private void handleUpdateUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String userIdStr = request.getParameter("userId");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String role = request.getParameter("role");
        
        try {
            int userId = Integer.parseInt(userIdStr);
            User user = userDAO.getUserById(userId);
            
            if (user != null) {
                user.setEmail(email);
                user.setFullName(fullName);
                user.setPhone(phone);
                user.setRole(role);
                
                if (userDAO.updateUser(user)) {
                    request.setAttribute("success", "Utilisateur mis à jour avec succès");
                } else {
                    request.setAttribute("error", "Erreur lors de la mise à jour");
                }
            } else {
                request.setAttribute("error", "Utilisateur non trouvé");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors de la mise à jour");
        }
        
        handleListUsers(request, response);
    }
    
    private void handleToggleUserStatus(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String userIdStr = request.getParameter("userId");
        
        try {
            int userId = Integer.parseInt(userIdStr);
            User user = userDAO.getUserById(userId);
            
            if (user != null) {
                user.setActive(!user.isActive());
                
                if (userDAO.updateUser(user)) {
                    String status = user.isActive() ? "activé" : "désactivé";
                    request.setAttribute("success", "Utilisateur " + status + " avec succès");
                } else {
                    request.setAttribute("error", "Erreur lors du changement de statut");
                }
            } else {
                request.setAttribute("error", "Utilisateur non trouvé");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors du changement de statut");
        }
        
        handleListUsers(request, response);
    }
    
    private void handleDeleteUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String userIdStr = request.getParameter("id");
        
        try {
            int userId = Integer.parseInt(userIdStr);
            
            // Vérifier qu'on ne supprime pas le dernier admin
            User userToDelete = userDAO.getUserById(userId);
            if ("ADMIN".equals(userToDelete.getRole())) {
                List<User> allUsers = userDAO.getAllUsers();
                long adminCount = allUsers.stream().filter(u -> "ADMIN".equals(u.getRole())).count();
                
                if (adminCount <= 1) {
                    request.setAttribute("error", "Impossible de supprimer le dernier administrateur");
                    handleListUsers(request, response);
                    return;
                }
            }
            
            if (userDAO.deleteUser(userId)) {
                request.setAttribute("success", "Utilisateur supprimé avec succès");
            } else {
                request.setAttribute("error", "Erreur lors de la suppression");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors de la suppression");
        }
        
        handleListUsers(request, response);
    }
}