<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Journey Details - Train Ticket System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            color: #333;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
        }
        
        .journey-card {
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }
        
        .journey-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .info-item {
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
            border-left: 4px solid #667eea;
        }
        
        .info-label {
            font-weight: bold;
            color: #666;
            font-size: 0.9em;
            margin-bottom: 5px;
        }
        
        .info-value {
            font-size: 1.1em;
            color: #333;
        }
        
        .route-info {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: #e3f2fd;
            padding: 20px;
            border-radius: 10px;
            margin: 20px 0;
        }
        
        .station {
            text-align: center;
            flex: 1;
        }
        
        .station-name {
            font-weight: bold;
            font-size: 1.2em;
            margin-bottom: 5px;
        }
        
        .station-time {
            color: #666;
            font-size: 0.9em;
        }
        
        .route-arrow {
            margin: 0 20px;
            font-size: 1.5em;
            color: #667eea;
        }
        
        .booking-section {
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        .seat-selection {
            margin: 20px 0;
        }
        
        .seat-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 10px;
            max-width: 300px;
            margin: 20px 0;
        }
        
        .seat {
            width: 40px;
            height: 40px;
            border: 2px solid #ddd;
            border-radius: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 0.8em;
            transition: all 0.3s;
        }
        
        .seat.available {
            background: #e8f5e8;
            border-color: #4caf50;
        }
        
        .seat.available:hover {
            background: #4caf50;
            color: white;
        }
        
        .seat.booked {
            background: #ffebee;
            border-color: #f44336;
            cursor: not-allowed;
            color: #999;
        }
        
        .seat.selected {
            background: #667eea;
            border-color: #667eea;
            color: white;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }
        
        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1em;
        }
        
        .btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            transition: transform 0.2s;
        }
        
        .btn:hover {
            transform: translateY(-2px);
        }
        
        .btn:disabled {
            background: #ccc;
            cursor: not-allowed;
            transform: none;
        }
        
        .error {
            background: #ffebee;
            color: #c62828;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #f44336;
        }
        
        .back-link {
            display: inline-block;
            margin-bottom: 20px;
            color: #667eea;
            text-decoration: none;
            font-weight: bold;
        }
        
        .back-link:hover {
            text-decoration: underline;
        }
        
        .price {
            font-size: 1.5em;
            font-weight: bold;
            color: #4caf50;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="search" class="back-link">← Back to Search</a>
        
        <div class="header">
            <h1>Journey Details</h1>
            <p>Book your seat for this journey</p>
        </div>
        
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        
        <div class="journey-card">
            <div class="route-info">
                <div class="station">
                    <div class="station-name">${journey.departureStation.city}</div>
                    <div class="station-time">
                        <fmt:formatDate value="${journey.departureTime}" pattern="HH:mm" />
                    </div>
                </div>
                <div class="route-arrow">→</div>
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
                    <div class="info-value">${journey.train.trainName} (${journey.train.trainNumber})</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Date</div>
                    <div class="info-value">
                        <fmt:formatDate value="${journey.journeyDate}" pattern="dd MMM yyyy" />
                    </div>
                </div>
                <div class="info-item">
                    <div class="info-label">Duration</div>
                    <div class="info-value">
                        <c:set var="duration" value="${(journey.arrivalTime.time - journey.departureTime.time) / (1000 * 60 * 60)}" />
                        <fmt:formatNumber value="${duration}" maxFractionDigits="1" />h
                    </div>
                </div>
                <div class="info-item">
                    <div class="info-label">Available Seats</div>
                    <div class="info-value">${journey.availableSeats} / ${totalSeats}</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Price</div>
                    <div class="info-value price">${journey.price} DT</div>
                </div>
            </div>
        </div>
        
        <c:if test="${sessionScope.user != null}">
            <div class="booking-section">
                <h2>Book Your Seat</h2>
                
                <form method="post" id="bookingForm">
                    <input type="hidden" name="journeyId" value="${journey.id}" />
                    <input type="hidden" name="seatNumber" id="selectedSeat" />
                    
                    <div class="seat-selection">
                        <h3>Select Your Seat</h3>
                        <div class="seat-grid">
                            <c:forEach var="row" begin="1" end="10">
                                <c:forEach var="col" items="A,B,C,D">
                                    <c:set var="seatNum" value="${col}${row}" />
                                    <div class="seat ${bookedSeats.contains(seatNum) ? 'booked' : 'available'}" 
                                         data-seat="${seatNum}"
                                         onclick="${bookedSeats.contains(seatNum) ? '' : 'selectSeat(this)'}">
                                        ${seatNum}
                                    </div>
                                </c:forEach>
                            </c:forEach>
                        </div>
                        <p><strong>Selected Seat:</strong> <span id="seatDisplay">None</span></p>
                    </div>
                    
                    <div class="form-group">
                        <label for="passengerName">Passenger Name:</label>
                        <input type="text" id="passengerName" name="passengerName" required />
                    </div>
                    
                    <div class="form-group">
                        <label for="passengerAge">Passenger Age:</label>
                        <input type="number" id="passengerAge" name="passengerAge" min="1" max="120" required />
                    </div>
                    
                    <button type="submit" class="btn" id="bookBtn" disabled>Book Ticket - $${journey.price}</button>
                </form>
            </div>
        </c:if>
        
        <c:if test="${sessionScope.user == null}">
            <div class="booking-section">
                <h2>Login Required</h2>
                <p>Please <a href="login">login</a> to book tickets for this journey.</p>
            </div>
        </c:if>
    </div>
    
    <script>
        let selectedSeatElement = null;
        
        function selectSeat(element) {
            // Remove previous selection
            if (selectedSeatElement) {
                selectedSeatElement.classList.remove('selected');
            }
            
            // Select new seat
            selectedSeatElement = element;
            element.classList.add('selected');
            
            // Update form
            const seatNumber = element.getAttribute('data-seat');
            document.getElementById('selectedSeat').value = seatNumber;
            document.getElementById('seatDisplay').textContent = seatNumber;
            document.getElementById('bookBtn').disabled = false;
        }
        
        // Form validation
        document.getElementById('bookingForm').addEventListener('submit', function(e) {
            const seatNumber = document.getElementById('selectedSeat').value;
            const passengerName = document.getElementById('passengerName').value;
            const passengerAge = document.getElementById('passengerAge').value;
            
            if (!seatNumber) {
                e.preventDefault();
                alert('Please select a seat');
                return;
            }
            
            if (!passengerName.trim()) {
                e.preventDefault();
                alert('Please enter passenger name');
                return;
            }
            
            if (!passengerAge || passengerAge < 1 || passengerAge > 120) {
                e.preventDefault();
                alert('Please enter a valid age (1-120)');
                return;
            }
        });
    </script>
</body>
</html>
