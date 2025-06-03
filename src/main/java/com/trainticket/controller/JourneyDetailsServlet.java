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
import com.trainticket.model.Journey;
import com.trainticket.model.User;

@WebServlet("/journey-details")
public class JourneyDetailsServlet extends HttpServlet {

    private JourneyDAO journeyDAO = new JourneyDAO();
    private TicketDAO ticketDAO = new TicketDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String journeyIdStr = request.getParameter("id");

        if (journeyIdStr == null || journeyIdStr.isEmpty()) {
            response.sendRedirect("search");
            return;
        }

        try {
            int journeyId = Integer.parseInt(journeyIdStr);

            // Get journey details
            Journey journey = journeyDAO.getJourneyById(journeyId);

            if (journey == null) {
                request.setAttribute("error", "Journey not found");
                request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
                return;
            }

            // Get booked seats for this journey
            List<String> bookedSeats = ticketDAO.getBookedSeatsForJourney(journeyId);

            // Calculate available seats
            int totalSeats = journey.getAvailableSeats() + bookedSeats.size();

            request.setAttribute("journey", journey);
            request.setAttribute("bookedSeats", bookedSeats);
            request.setAttribute("totalSeats", totalSeats);

            request.getRequestDispatcher("/WEB-INF/views/journey-details.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("search");
        }
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

        String journeyIdStr = request.getParameter("journeyId");
        String seatNumber = request.getParameter("seatNumber");
        String passengerName = request.getParameter("passengerName");
        String passengerAgeStr = request.getParameter("passengerAge");

        // Validate input
        if (journeyIdStr == null || seatNumber == null || passengerName == null ||
            passengerAgeStr == null || journeyIdStr.isEmpty() || seatNumber.isEmpty() ||
            passengerName.isEmpty() || passengerAgeStr.isEmpty()) {

            request.setAttribute("error", "All fields are required");
            doGet(request, response);
            return;
        }

        try {
            int journeyId = Integer.parseInt(journeyIdStr);
            int passengerAge = Integer.parseInt(passengerAgeStr);

            // Check if seat is already booked
            List<String> bookedSeats = ticketDAO.getBookedSeatsForJourney(journeyId);
            if (bookedSeats.contains(seatNumber)) {
                request.setAttribute("error", "Seat " + seatNumber + " is already booked");
                doGet(request, response);
                return;
            }

            // Create and save ticket
            boolean success = ticketDAO.addTicket(user.getUserId(), journeyId, seatNumber,
                                                   passengerName, passengerAge);

            if (success) {
                response.sendRedirect("dashboard?booking=success");
            } else {
                request.setAttribute("error", "Failed to book ticket. Please try again.");
                doGet(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input format");
            doGet(request, response);
        }
    }
}
