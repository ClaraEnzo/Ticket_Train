package com.trainticket.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.trainticket.dao.UserDAO;
import com.trainticket.model.User;
import com.trainticket.util.PasswordUtil;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Récupérer les informations utilisateur mises à jour depuis la base de données
        try {
            User updatedUser = userDAO.getUserById(user.getUserId());
            if (updatedUser != null) {
                session.setAttribute("user", updatedUser);
                request.setAttribute("user", updatedUser);
            } else {
                request.setAttribute("user", user);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("user", user);
        }

        // Forward to profile page
        request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        if ("updateProfile".equals(action)) {
            updateProfile(request, response, user);
        } else if ("changePassword".equals(action)) {
            changePassword(request, response, user);
        } else {
            doGet(request, response);
        }
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");

        // Validate input
        if (username == null || username.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            fullName == null || fullName.trim().isEmpty()) {

            request.setAttribute("error", "Tous les champs obligatoires doivent être remplis");
            doGet(request, response);
            return;
        }

        // Vérifier si le nom d'utilisateur est déjà pris par un autre utilisateur
        User existingUser = userDAO.getUserByUsername(username.trim());
        if (existingUser != null && existingUser.getUserId() != user.getUserId()) {
            request.setAttribute("error", "Ce nom d'utilisateur est déjà utilisé");
            doGet(request, response);
            return;
        }

        // Update user object
        user.setUsername(username.trim());
        user.setEmail(email.trim());
        user.setFullName(fullName.trim());
        user.setPhone(phone != null ? phone.trim() : "");

        // Update in database
        boolean success = userDAO.updateUser(user);

        if (success) {
            // Update session
            request.getSession().setAttribute("user", user);
            request.setAttribute("success", "Profil mis à jour avec succès !");
        } else {
            request.setAttribute("error", "Échec de la mise à jour du profil. Veuillez réessayer.");
        }

        doGet(request, response);
    }

    private void changePassword(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate input
        if (currentPassword == null || currentPassword.trim().isEmpty() ||
            newPassword == null || newPassword.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {

            request.setAttribute("error", "Tous les champs de mot de passe doivent être remplis");
            doGet(request, response);
            return;
        }

        // Verify current password
        if (!PasswordUtil.verifyPassword(currentPassword, user.getPassword())) {
            request.setAttribute("error", "Le mot de passe actuel est incorrect");
            doGet(request, response);
            return;
        }

        // Check if new passwords match
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Les nouveaux mots de passe ne correspondent pas");
            doGet(request, response);
            return;
        }

        // Validate new password strength
        if (newPassword.length() < 6) {
            request.setAttribute("error", "Le nouveau mot de passe doit contenir au moins 6 caractères");
            doGet(request, response);
            return;
        }

        // Hash new password and update
        String hashedPassword = PasswordUtil.hashPassword(newPassword);
        boolean success = userDAO.updatePassword(user.getUserId(), hashedPassword);

        if (success) {
            user.setPassword(hashedPassword);
            request.getSession().setAttribute("user", user);
            request.setAttribute("success", "Mot de passe modifié avec succès !");
        } else {
            request.setAttribute("error", "Échec de la modification du mot de passe. Veuillez réessayer.");
        }

        doGet(request, response);
    }
}