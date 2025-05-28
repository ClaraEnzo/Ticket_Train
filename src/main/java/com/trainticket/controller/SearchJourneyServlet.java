package com.trainticket.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.trainticket.dao.JourneyDAO;
import com.trainticket.dao.StationDAO;
import com.trainticket.model.Journey;

@WebServlet("/search")
public class SearchJourneyServlet extends HttpServlet {

    private JourneyDAO journeyDAO = new JourneyDAO();
    private StationDAO stationDAO = new StationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get list of cities for dropdown
        List<String> cities = stationDAO.getAllCities();
        request.setAttribute("cities", cities);

        request.getRequestDispatcher("/WEB-INF/views/search.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String departureCity = request.getParameter("departureCity");
        String arrivalCity = request.getParameter("arrivalCity");
        String dateStr = request.getParameter("date");

        // Validate input
        if (departureCity == null || arrivalCity == null || dateStr == null ||
            departureCity.isEmpty() || arrivalCity.isEmpty() || dateStr.isEmpty()) {
            request.setAttribute("error", "All fields are required");
            List<String> cities = stationDAO.getAllCities();
            request.setAttribute("cities", cities);
            request.getRequestDispatcher("/WEB-INF/views/search.jsp").forward(request, response);
            return;
        }

        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date date = dateFormat.parse(dateStr);

            List<Journey> journeys = journeyDAO.searchJourneys(departureCity, arrivalCity, date);

            request.setAttribute("journeys", journeys);
            request.setAttribute("departureCity", departureCity);
            request.setAttribute("arrivalCity", arrivalCity);
            request.setAttribute("date", dateStr);

            request.getRequestDispatcher("/WEB-INF/views/search-results.jsp").forward(request, response);
        } catch (ParseException e) {
            request.setAttribute("error", "Invalid date format");
            List<String> cities = stationDAO.getAllCities();
            request.setAttribute("cities", cities);
            request.getRequestDispatcher("/WEB-INF/views/search.jsp").forward(request, response);
        }
    }
}