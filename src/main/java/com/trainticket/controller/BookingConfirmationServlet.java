package com.trainticket.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.trainticket.model.User;

@WebServlet("/booking-confirmation")
public class BookingConfirmationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Integer journeyId = (Integer) session.getAttribute("bookingJourneyId");
        String ticketClass = (String) session.getAttribute("bookingClass");
        String[] preferences = (String[]) session.getAttribute("bookingPreferences");

        if (journeyId == null) {
            response.sendRedirect(request.getContextPath() + "/search");
            return;
        }

        String bookingReference = "TTS" + System.currentTimeMillis();

        request.setAttribute("bookingReference", bookingReference);
        request.setAttribute("journeyId", journeyId);
        request.setAttribute("ticketClass", ticketClass);
        request.setAttribute("preferences", preferences);
        request.setAttribute("user", user);

        session.removeAttribute("bookingJourneyId");
        session.removeAttribute("bookingClass");
        session.removeAttribute("bookingPreferences");

        request.getRequestDispatcher("/WEB-INF/views/booking-confirmation.jsp").forward(request, response);
    }
}