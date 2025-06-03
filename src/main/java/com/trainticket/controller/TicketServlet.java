package com.trainticket.controller;

import java.io.IOException;

import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.trainticket.dao.JourneyDAO;
import com.trainticket.dao.TicketDAO;
import com.trainticket.model.Ticket;
import com.trainticket.model.User;

@WebServlet("/my-tickets")
public class TicketServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private JourneyDAO journeyDAO;
    private TicketDAO ticketDAO;

    @Override
    public void init() throws ServletException {
        journeyDAO = new JourneyDAO();
        ticketDAO = new TicketDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Check if user is logged in
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            // Get user's tickets
            List<Ticket> userTickets = ticketDAO.getTicketsByUserId(user.getUserId());
            request.setAttribute("userTickets", userTickets);


            // Set user info
            request.setAttribute("user", user);

            // Forward to dashboard JSP
            request.getRequestDispatcher("/WEB-INF/views/my-tickets.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading tickets: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
