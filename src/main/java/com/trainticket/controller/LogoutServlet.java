package com.trainticket.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/logout")
/**
 * Servlet implementation class LogoutServlet
 * Handles user logout by invalidating session and clearing cookies
 */
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public LogoutServlet() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set cache control headers to prevent caching of sensitive pages
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setDateHeader("Expires", 0); // Proxies

        // Get the current session
        HttpSession session = request.getSession(false);

        if (session != null) {
            // Log the logout event (optional)
            String username = (String) session.getAttribute("username");
            if (username != null) {
                System.out.println("User logged out: " + username);
            }

            // Invalidate session
            session.invalidate();
        }

        // Clear cookies if any
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("remember-me") || cookie.getName().equals("JSESSIONID")) {
                    cookie.setMaxAge(0); // Delete the cookie
                    cookie.setPath("/");
                    response.addCookie(cookie);
                }
            }
        }

        // Redirect to home page
        response.sendRedirect(request.getContextPath() + "/");
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
