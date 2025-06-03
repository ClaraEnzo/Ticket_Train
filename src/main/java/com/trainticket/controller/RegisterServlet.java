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

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");

        // Validate input
        if (username == null || password == null || confirmPassword == null || 
            email == null || fullName == null || 
            username.trim().isEmpty() || password.trim().isEmpty() ||
            confirmPassword.trim().isEmpty() || email.trim().isEmpty() || 
            fullName.trim().isEmpty()) {

            request.setAttribute("error", "Tous les champs obligatoires doivent être remplis");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        // Validate password length
        if (password.length() < 6) {
            request.setAttribute("error", "Le mot de passe doit contenir au moins 6 caractères");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Les mots de passe ne correspondent pas");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        // Check if username already exists
        if (userDAO.getUserByUsername(username.trim()) != null) {
            request.setAttribute("error", "Ce nom d'utilisateur existe déjà");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        // Check if email already exists
        if (userDAO.emailExists(email.trim())) {
            request.setAttribute("error", "Cette adresse email est déjà utilisée");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        // Create new user
        User user = new User();
        user.setUsername(username.trim());
        user.setPassword(PasswordUtil.hashPassword(password));
        user.setEmail(email.trim());
        user.setFullName(fullName.trim());
        user.setPhone(phone != null ? phone.trim() : "");
        user.setRole("USER");
        user.setActive(true);

        try {
            if (userDAO.addUser(user)) {
                // Auto-login after registration
                User registeredUser = userDAO.getUserByUsername(username.trim());
                if (registeredUser != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user", registeredUser);
                    
                    // Redirect to dashboard with success message
                    session.setAttribute("registrationSuccess", "Inscription réussie ! Bienvenue " + fullName.trim());
                    response.sendRedirect(request.getContextPath() + "/dashboard");
                } else {
                    request.setAttribute("error", "Erreur lors de la connexion automatique. Veuillez vous connecter manuellement.");
                    request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Échec de l'inscription. Veuillez réessayer.");
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Une erreur s'est produite lors de l'inscription. Veuillez réessayer.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
        }
    }
}