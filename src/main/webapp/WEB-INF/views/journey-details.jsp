<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails du trajet - Système de Billetterie</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --primary-light: #e0e7ff;
            --secondary-color: #3a0ca3;
            --accent-color: #4cc9f0;
            --success-color: #2ecc71;
            --danger-color: #e74c3c;
            --warning-color: #f39c12;
            --dark-color: #2c3e50;
            --light-color: #f8f9fa;
            --gray-color: #95a5a6;
            --border-radius: 12px;
            --box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            --transition: all 0.3s ease;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f9fafb;
            color: var(--dark-color);
            line-height: 1.6;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }
        
        /* Header Styles */
        .header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 2.5rem;
            border-radius: var(--border-radius);
            margin-bottom: 2.5rem;
            position: relative;
            overflow: hidden;
            box-shadow: var(--box-shadow);
        }
        
        .header::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 100%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.15) 0%, rgba(255,255,255,0) 70%);
            transform: rotate(30deg);
        }
        
        .header h1 {
            font-size: 2.2rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            position: relative;
            z-index: 1;
        }
        
        .header p {
            opacity: 0.9;
            font-weight: 300;
            position: relative;
            z-index: 1;
        }
        
        /* Card Styles */
        .card {
            background: white;
            border-radius: var(--border-radius);
            padding: 2.5rem;
            box-shadow: var(--box-shadow);
            margin-bottom: 2.5rem;
            transition: var(--transition);
            border: none;
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(67, 97, 238, 0.15);
        }
        
        /* Journey Info Styles */
        .journey-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .info-item {
            padding: 1.5rem;
            background: var(--light-color);
            border-radius: var(--border-radius);
            border-left: 4px solid var(--primary-color);
            transition: var(--transition);
        }
        
        .info-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }
        
        .info-label {
            font-weight: 500;
            color: var(--gray-color);
            font-size: 0.85rem;
            margin-bottom: 0.5rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .info-value {
            font-size: 1.25rem;
            color: var(--dark-color);
            font-weight: 500;
        }
        
        /* Route Info Styles */
        .route-info {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: linear-gradient(to right, var(--primary-light), white);
            padding: 2rem;
            border-radius: var(--border-radius);
            margin: 2rem 0;
            position: relative;
            overflow: hidden;
        }
        
        .station {
            text-align: center;
            flex: 1;
            position: relative;
            z-index: 1;
        }
        
        .station-name {
            font-weight: 600;
            font-size: 1.4rem;
            margin-bottom: 0.5rem;
            color: var(--primary-color);
        }
        
        .station-time {
            font-size: 1.1rem;
            font-weight: 500;
            color: var(--dark-color);
        }
        
        .route-arrow {
            margin: 0 1.5rem;
            font-size: 2rem;
            color: var(--primary-color);
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% { opacity: 0.7; }
            50% { opacity: 1; }
            100% { opacity: 0.7; }
        }
        
        /* Booking Section */
        .booking-section {
            background: white;
            border-radius: var(--border-radius);
            padding: 2.5rem;
            box-shadow: var(--box-shadow);
        }
        
        .section-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            color: var(--dark-color);
            position: relative;
            padding-bottom: 0.75rem;
        }
        
        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 3px;
            background: var(--primary-color);
            border-radius: 3px;
        }
        
        /* Seat Selection */
        .seat-selection {
            margin: 2rem 0;
        }
        
        .seat-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(60px, 1fr));
            gap: 0.75rem;
            max-width: 500px;
            margin: 1.5rem 0;
        }
        
        .seat {
            width: 100%;
            aspect-ratio: 1;
            border: 2px solid #ddd;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 0.85rem;
            font-weight: 500;
            transition: var(--transition);
        }
        
        .seat.available {
            background: rgba(46, 204, 113, 0.1);
            border-color: var(--success-color);
            color: var(--success-color);
        }
        
        .seat.available:hover {
            background: var(--success-color);
            color: white;
            transform: scale(1.05);
        }
        
        .seat.booked {
            background: rgba(231, 76, 60, 0.1);
            border-color: var(--danger-color);
            color: var(--danger-color);
            cursor: not-allowed;
        }
        
        .seat.selected {
            background: var(--primary-color);
            border-color: var(--primary-color);
            color: white;
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.3);
        }
        
        .seat-label {
            font-weight: 500;
            margin-top: 1rem;
        }
        
        .seat-label span {
            color: var(--primary-color);
            font-weight: 600;
        }
        
        /* Form Styles */
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--dark-color);
        }
        
        .form-control {
            width: 100%;
            padding: 0.85rem 1.25rem;
            border: 1px solid #e2e8f0;
            border-radius: var(--border-radius);
            font-size: 1rem;
            transition: var(--transition);
            background-color: var(--light-color);
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.2);
        }
        
        /* Button Styles */
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 0.85rem 2rem;
            border: none;
            border-radius: var(--border-radius);
            cursor: pointer;
            font-size: 1rem;
            font-weight: 500;
            transition: var(--transition);
            box-shadow: 0 4px 6px rgba(67, 97, 238, 0.15);
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 7px 14px rgba(67, 97, 238, 0.2);
        }
        
        .btn:disabled {
            background: #bdc3c7;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }
        
        .btn i {
            margin-right: 0.5rem;
        }
        
        /* Price Styles */
        .price {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--success-color);
        }
        
        /* Error Message */
        .alert {
            padding: 1.25rem;
            border-radius: var(--border-radius);
            margin-bottom: 2rem;
            font-weight: 500;
        }
        
        .alert-danger {
            background: rgba(231, 76, 60, 0.1);
            color: var(--danger-color);
            border-left: 4px solid var(--danger-color);
        }
        
        /* Back Link */
        .back-link {
            display: inline-flex;
            align-items: center;
            margin-bottom: 1.5rem;
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
            transition: var(--transition);
        }
        
        .back-link:hover {
            color: var(--secondary-color);
            text-decoration: underline;
        }
        
        .back-link i {
            margin-right: 0.5rem;
        }
        
        /* Login Prompt */
        .login-prompt {
            text-align: center;
            padding: 2rem;
        }
        
        .login-prompt a {
            color: var(--primary-color);
            font-weight: 500;
            text-decoration: none;
            transition: var(--transition);
        }
        
        .login-prompt a:hover {
            color: var(--secondary-color);
            text-decoration: underline;
        }
        
        /* Responsive Adjustments */
        @media (max-width: 768px) {
            .container {
                padding: 1.5rem;
            }
            
            .header {
                padding: 1.5rem;
            }
            
            .header h1 {
                font-size: 1.8rem;
            }
            
            .route-info {
                flex-direction: column;
                padding: 1.5rem;
            }
            
            .route-arrow {
                margin: 1rem 0;
                transform: rotate(90deg);
            }
            
            .card, .booking-section {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="search" class="back-link">
            <i class="fas fa-arrow-left"></i> Retour à la recherche
        </a>
        
        <div class="header">
            <h1>Détails du trajet</h1>
            <p>Réservez votre siège pour ce trajet</p>
        </div>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>
        
        <div class="card">
            <div class="route-info">
                <div class="station">
                    <div class="station-name">${journey.departureStation.city}</div>
                    <div class="station-time">
                        <fmt:formatDate value="${journey.departureTime}" pattern="HH:mm" />
                    </div>
                </div>
                <div class="route-arrow">
                    <i class="fas fa-long-arrow-alt-right"></i>
                </div>
                <div class="station">
                    <div class="station-name">${journey.arrivalStation.city}</div>
                    <div class="station-time">
                        <fmt:formatDate value="${journey.arrivalTime}" pattern="HH:mm" />
                    </div>
                </div>
            </div>
            
            <div class="journey-info">
                <div class="info-item">
                    <div class="info-label">Train</div>
                    <div class="info-value">
                        <i class="fas fa-train"></i> ${journey.train.trainName} (${journey.train.trainNumber})
                    </div>
                </div>
                <div class="info-item">
                    <div class="info-label">Date</div>
                    <div class="info-value">
                        <i class="far fa-calendar-alt"></i> 
                        <fmt:formatDate value="${journey.journeyDate}" pattern="dd MMM yyyy" />
                    </div>
                </div>
                <div class="info-item">
                    <div class="info-label">Durée</div>
                    <div class="info-value">
                        <i class="far fa-clock"></i> 
                        <c:set var="duration" value="${(journey.arrivalTime.time - journey.departureTime.time) / (1000 * 60 * 60)}" />
                        <fmt:formatNumber value="${duration}" maxFractionDigits="1" />h
                    </div>
                </div>
                <div class="info-item">
                    <div class="info-label">Places disponibles</div>
                    <div class="info-value">
                        <i class="fas fa-chair"></i> ${journey.availableSeats} / ${totalSeats}
                    </div>
                </div>
                <div class="info-item">
                    <div class="info-label">Prix</div>
                    <div class="info-value price">
                        <i class="fas fa-tag"></i> ${journey.price} DT
                    </div>
                </div>
            </div>
        </div>
        
        <c:if test="${sessionScope.user != null}">
            <div class="booking-section">
                <h2 class="section-title">Réservation</h2>
                
                <form method="post" id="bookingForm">
                    <input type="hidden" name="journeyId" value="${journey.id}" />
                    <input type="hidden" name="seatNumber" id="selectedSeat" />
                    
                    <div class="seat-selection">
    <h3 class="section-title">Sélectionnez votre place dans le train</h3>
    
    <!-- Locomotive -->
<div class="train-locomotive">
    <div class="train-front"></div>
    <div class="train-cabin">TGV</div>
</div>

<!-- Wagons (3 wagons dans cet exemple) -->
<c:forEach var="wagon" begin="1" end="3">
    <div class="train-wagon">
        <div class="wagon-number">Wagon ${wagon}</div>
        
        <div class="wagon-seats">
            <!-- On crée 10 rangées de sièges (pour 10 rangées) -->
            <c:forEach var="row" begin="1" end="10">
                <div class="seat-row">
                    <!-- Sièges côté fenêtre (gauche) -->
                    <div class="window-side">
                        <c:set var="seatNumLeft" value="A${row}W${wagon}" />
                        <div class="seat ${bookedSeats.contains(seatNumLeft) ? 'booked' : 'available'} window-seat" 
                             data-seat="${seatNumLeft}"
                             onclick="${bookedSeats.contains(seatNumLeft) ? '' : 'selectSeat(this)'}">
                            <span class="seat-number">${seatNumLeft}</span>
                            <div class="seat-view"></div>
                        </div>
                    </div>
                    
                    <!-- Couloir central -->
                    <div class="wagon-aisle"></div>
                    
                    <!-- Sièges côté couloir (droite) -->
                    <div class="aisle-side">
                        <c:set var="seatNumRight" value="B${row}W${wagon}" />
                        <div class="seat ${bookedSeats.contains(seatNumRight) ? 'booked' : 'available'} aisle-seat" 
                             data-seat="${seatNumRight}"
                             onclick="${bookedSeats.contains(seatNumRight) ? '' : 'selectSeat(this)'}">
                            <span class="seat-number">${seatNumRight}</span>
                            <div class="seat-view"></div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</c:forEach>
    
    <div class="seat-selection-info">
        <div class="seat-legend">
            <div class="legend-item">
                <div class="legend-color available"></div>
                <span>Disponible</span>
            </div>
            <div class="legend-item">
                <div class="legend-color booked"></div>
                <span>Occupé</span>
            </div>
            <div class="legend-item">
                <div class="legend-color selected"></div>
                <span>Sélectionné</span>
            </div>
        </div>
        <p class="seat-label"><strong>Siège sélectionné :</strong> <span id="seatDisplay">Aucun</span></p>
    </div>
</div>

<style>
   .train-wagon {
    flex-shrink: 0;
    width: 220px;
    background: #3498db;
    border-radius: 5px;
    padding: 10px;
    position: relative;
}

.wagon-seats {
    background: #ecf0f1;
    border-radius: 5px;
    padding: 10px;
    height: 400px; /* Plus grand pour accommoder les rangées */
}

.seat-row {
    display: flex;
    justify-content: space-between;
    margin-bottom: 15px;
    height: 30px;
    align-items: center;
}

.window-side, .aisle-side {
    display: flex;
    gap: 5px;
}

.wagon-aisle {
    width: 40px;
    background: #bdc3c7;
    height: 100%;
}

.seat {
    width: 30px;
    height: 25px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    border-radius: 3px;
    position: relative;
    cursor: pointer;
    transition: all 0.2s;
}

.seat-number {
    position: absolute;
    top: -18px;
    font-size: 0.7rem;
    color: #2c3e50;
    font-weight: bold;
}

.seat-view {
    width: 15px;
    height: 10px;
    background: rgba(0,0,0,0.1);
    border-radius: 2px;
}

/* Le reste du CSS peut rester identique */
    
    .seat-selection-info {
        margin-top: 1.5rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .seat-legend {
        display: flex;
        gap: 1rem;
    }
    
    .legend-item {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        font-size: 0.9rem;
    }
    
    .legend-color {
        width: 15px;
        height: 15px;
        border-radius: 3px;
    }
    
    .legend-color.available {
        background: #2ecc71;
    }
    
    .legend-color.booked {
        background: #e74c3c;
    }
    
    .legend-color.selected {
        background: #f39c12;
    }
    
    /* Responsive */
    @media (max-width: 768px) {
        .train-container {
            gap: 3px;
        }
        
        .train-wagon {
            width: 150px;
        }
        
        .wagon-seats {
            height: 120px;
        }
        
        .seat-number {
            top: -18px;
            font-size: 0.6rem;
        }
    }
</style>

<script>
    // Même fonction selectSeat que précédemment
    function selectSeat(element) {
        const previouslySelected = document.querySelector('.seat.selected');
        if (previouslySelected) {
            previouslySelected.classList.remove('selected');
        }
        
        element.classList.add('selected');
        document.getElementById('selectedSeat').value = element.getAttribute('data-seat');
        document.getElementById('seatDisplay').textContent = element.getAttribute('data-seat');
        document.getElementById('bookBtn').disabled = false;
    }
</script>
                    
                    <div class="form-group">
                        <label for="passengerName"><i class="fas fa-user"></i> Nom du passager</label>
                        <input type="text" id="passengerName" name="passengerName" class="form-control" required />
                    </div>
                    
                    <div class="form-group">
                        <label for="passengerAge"><i class="fas fa-birthday-cake"></i> Âge du passager</label>
                        <input type="number" id="passengerAge" name="passengerAge" class="form-control" min="1" max="120" required />
                    </div>
                    
                    <button type="submit" class="btn" id="bookBtn" disabled>
                        <i class="fas fa-ticket-alt"></i> Réserver - ${journey.price} DT
                    </button>
                </form>
            </div>
        </c:if>
        
        <c:if test="${sessionScope.user == null}">
            <div class="card login-prompt">
                <h2 class="section-title">Connexion requise</h2>
                <p>Veuillez vous <a href="login"><i class="fas fa-sign-in-alt"></i> connecter</a> pour réserver des billets pour ce trajet.</p>
            </div>
        </c:if>
    </div>
    
    <script>
        let selectedSeatElement = null;
        
        function selectSeat(element) {
            // Supprimer la sélection précédente
            if (selectedSeatElement) {
                selectedSeatElement.classList.remove('selected');
            }
            
            // Sélectionner le nouveau siège
            selectedSeatElement = element;
            element.classList.add('selected');
            
            // Mettre à jour le formulaire
            const seatNumber = element.getAttribute('data-seat');
            document.getElementById('selectedSeat').value = seatNumber;
            document.getElementById('seatDisplay').textContent = seatNumber;
            document.getElementById('bookBtn').disabled = false;
        }
        
        // Validation du formulaire
        document.getElementById('bookingForm').addEventListener('submit', function(e) {
            const seatNumber = document.getElementById('selectedSeat').value;
            const passengerName = document.getElementById('passengerName').value;
            const passengerAge = document.getElementById('passengerAge').value;
            
            if (!seatNumber) {
                e.preventDefault();
                alert('Veuillez sélectionner un siège');
                return;
            }
            
            if (!passengerName.trim()) {
                e.preventDefault();
                alert('Veuillez entrer le nom du passager');
                return;
            }
            
            if (!passengerAge || passengerAge < 1 || passengerAge > 120) {
                e.preventDefault();
                alert('Veuillez entrer un âge valide (1-120)');
                return;
            }
        });
    </script>
</body>
</html>