<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Billet - Système de Billetterie de Train</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            line-height: 1.6;
        }

        .header {
            background-color: #2c3e50;
            color: white;
            padding: 1rem 0;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .nav {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }

        .logo {
            font-size: 1.5rem;
            font-weight: bold;
        }

        .nav-links {
            display: flex;
            gap: 20px;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .nav-links a:hover {
            background-color: #34495e;
        }

        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 20px;
        }

        .welcome-section {
            background: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }

        .card {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .card h3 {
            color: #2c3e50;
            margin-bottom: 15px;
            border-bottom: 2px solid #3498db;
            padding-bottom: 10px;
        }

        .ticket-item {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 10px;
            background-color: #f9f9f9;
        }

        .ticket-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .ticket-id {
            font-weight: bold;
            color: #2c3e50;
        }

        .ticket-status {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.8rem;
            font-weight: bold;
        }

        .status-confirmed {
            background-color: #d4edda;
            color: #155724;
        }

        .status-cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }

        .journey-item {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 10px;
            background-color: #f9f9f9;
        }

        .journey-route {
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 5px;
        }

        .journey-details {
            font-size: 0.9rem;
            color: #666;
        }

        .btn {
            background-color: #3498db;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #2980b9;
        }

        .btn-success {
            background-color: #27ae60;
        }

        .btn-success:hover {
            background-color: #229954;
        }

        .quick-actions {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }

        .no-data {
            text-align: center;
            color: #666;
            font-style: italic;
            padding: 20px;
        }

        @media (max-width: 768px) {
            .dashboard-grid {
                grid-template-columns: 1fr;
            }

            .nav {
                flex-direction: column;
                gap: 10px;
            }

            .quick-actions {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <header class="header">
        <nav class="nav">
            <div class="logo">Système de Billetterie de Train</div>
            <div class="nav-links">
                <a href="search">Rechercher un train</a>
                <a href="dashboard">Tableau de bord</a>
                <a href="profile">Profil</a>
                <a href="logout">Déconnexion</a>
            </div>
        </nav>
    </header>

    <div class="container">
        <div class="welcome-section">
            <h2>Bon retour, ${user.fullName} !</h2>
            <p>Gérez vos réservations et explorez de nouveaux trajets.</p>

            <div class="quick-actions">
                <a href="search" class="btn btn-success">Rechercher des trains</a>
                <a href="profile" class="btn">Voir le profil</a>
            </div>
        </div>

        <div class="dashboard-grid">
            <!-- Section : Mes Billets -->
            <div class="card">
                <h3>Mes Billets</h3>
                <c:choose>
                    <c:when test="${not empty userTickets}">
                        <c:forEach var="ticket" items="${userTickets}">
                            <div class="ticket-item">
                                <div class="ticket-header">
                                    <span class="ticket-id">Billet n°${ticket.id}</span>
                                    <span class="ticket-status status-${ticket.status.toLowerCase()}">
                                        ${ticket.status}
                                    </span>
                                </div>
                                <div class="ticket-details">
                                    <p><strong>Passager :</strong> ${ticket.passengerName}</p>
                                    <p><strong>Siège :</strong> ${ticket.seatNumber}</p>
                                    <p><strong>Date de réservation :</strong>
                                        <fmt:formatDate value="${ticket.bookingDate}" pattern="dd MMM yyyy" />
                                    </p>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="no-data">
                            <p>Aucun billet trouvé.</p>
                            <a href="search" class="btn" style="margin-top: 10px;">Réservez votre premier billet</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</body>
</html>
