package com.trainticket.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.trainticket.dao.TicketDAO;
import com.trainticket.dao.UserDAO;
import com.trainticket.model.Ticket;
import com.trainticket.model.User;
import com.trainticket.util.PasswordUtil;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private UserDAO userDAO = new UserDAO();
    private TicketDAO ticketDAO = new TicketDAO();

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        // Get user's tickets
        List<Ticket> userTickets = ticketDAO.getTicketsByUserId(user.getId());
        request.setAttribute("tickets", userTickets);

        // Forward to profile page
        request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
    }

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");

        if ("updateProfile".equals(action)) {
            updateProfile(request, response, user);
        } else if ("changePassword".equals(action)) {
            changePassword(request, response, user);
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

            request.setAttribute("error", "All required fields must be filled");
            doGet(request, response);
            return;
        }

        // Update user object
        user.setUsername(username.trim());
        user.setEmail(email.trim());
        user.setFullName(fullName.trim());
        user.setPhone(phone != null ? phone.trim() : null);

        // Update in database
        boolean success = userDAO.updateUser(user);

        if (success) {
            // Update session
            request.getSession().setAttribute("user", user);
            request.setAttribute("success", "Profile updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update profile. Please try again.");
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

            request.setAttribute("error", "All password fields must be filled");
            doGet(request, response);
            return;
        }

        // Verify current password
        if (!PasswordUtil.verifyPassword(currentPassword, user.getPassword())) {
            request.setAttribute("error", "Current password is incorrect");
            doGet(request, response);
            return;
        }

        // Check if new passwords match
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "New passwords do not match");
            doGet(request, response);
            return;
        }

        // Validate new password strength
        if (newPassword.length() < 6) {
            request.setAttribute("error", "New password must be at least 6 characters long");
            doGet(request, response);
            return;
        }

        // Hash new password and update
        String hashedPassword = PasswordUtil.hashPassword(newPassword);
        boolean success = userDAO.updatePassword(user.getId(), hashedPassword);

        if (success) {
            user.setPassword(hashedPassword);
            request.getSession().setAttribute("user", user);
            request.setAttribute("success", "Password changed successfully!");
        } else {
            request.setAttribute("error", "Failed to change password. Please try again.");
        }

        doGet(request, response);
    }
}
