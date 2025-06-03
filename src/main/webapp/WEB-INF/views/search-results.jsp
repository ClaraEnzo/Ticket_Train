<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results - Train Ticket System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3a0ca3;
            --accent-color: #4cc9f0;
            --light-bg: #f8f9fa;
            --card-shadow: 0 10px 30px rgba(67, 97, 238, 0.15);
            --gradient: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
        }
        
        body {
            background-color: var(--light-bg);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-image: url('https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            background-blend-mode: overlay;
            background-color: rgba(248, 249, 250, 0.9);
        }
        
        .results-card {
            border: none;
            border-radius: 15px;
            box-shadow: var(--card-shadow);
            overflow: hidden;
            backdrop-filter: blur(10px);
            background-color: rgba(255, 255, 255, 0.95);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .results-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(67, 97, 238, 0.2);
        }
        
        .card-header {
            background: var(--gradient);
            color: white;
            padding: 1.5rem;
            position: relative;
            overflow: hidden;
        }
        
        .card-header h4 {
            font-weight: 600;
            margin: 0;
            position: relative;
            z-index: 1;
        }
        
        .card-header p {
            opacity: 0.9;
            margin-bottom: 0;
            position: relative;
            z-index: 1;
        }
        
        .card-header::after {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 100%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.2) 0%, rgba(255,255,255,0) 70%);
            transform: rotate(30deg);
        }
        
        .table {
            --bs-table-bg: transparent;
            --bs-table-striped-bg: rgba(67, 97, 238, 0.03);
        }
        
        .table-hover tbody tr:hover {
            background-color: rgba(67, 97, 238, 0.1) !important;
        }
        
        .table th {
            border-top: none;
            border-bottom: 2px solid rgba(67, 97, 238, 0.1);
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.8rem;
            letter-spacing: 0.5px;
            color: var(--secondary-color);
        }
        
        .badge {
            font-weight: 500;
            padding: 0.5em 0.75em;
            border-radius: 6px;
            font-size: 0.75rem;
        }
        
        .badge-success {
            background-color: rgba(40, 167, 69, 0.15);
            color: #28a745;
        }
        
        .badge-warning {
            background-color: rgba(255, 193, 7, 0.15);
            color: #ffc107;
        }
        
        .badge-danger {
            background-color: rgba(220, 53, 69, 0.15);
            color: #dc3545;
        }
        
        .btn-primary {
            background: var(--gradient);
            border: none;
            padding: 10px 25px;
            border-radius: 8px;
            font-weight: 500;
            letter-spacing: 0.5px;
            transition: all 0.3s;
            position: relative;
            overflow: hidden;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.4);
        }
        
        .btn-sm {
            padding: 0.35rem 0.75rem;
            font-size: 0.8rem;
        }
        
        .alert {
            border-radius: 8px;
            border: none;
        }
        
        .train-icon {
            color: var(--primary-color);
            margin-right: 8px;
        }
        
        .duration-cell {
            font-weight: 500;
            color: var(--secondary-color);
        }
        
        .action-btn {
            transition: all 0.3s;
        }
        
        .action-btn:hover {
            transform: scale(1.05);
        }
        
        .no-results {
            padding: 3rem;
            text-align: center;
        }
        
        .no-results-icon {
            font-size: 3rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <div class="container my-5 animate__animated animate__fadeIn">
        <div class="row justify-content-center">
            <div class="col-lg-12">
                <div class="results-card">
                    <div class="card-header">
                        <h4><i class="fas fa-train me-2"></i>Search Results</h4>
                        <p class="mb-0">
                            <i class="fas fa-map-marker-alt"></i> ${departureCity} 
                            <i class="fas fa-arrow-right mx-2"></i> 
                            <i class="fas fa-map-marker-alt"></i> ${arrivalCity} 
                            | <i class="fas fa-calendar-day ms-2 me-1"></i> ${date}
                        </p>
                    </div>
                    <div class="card-body p-4">
                        <c:if test="${empty journeys}">
                            <div class="no-results">
                                <div class="no-results-icon">
                                    <i class="fas fa-train"></i>
                                </div>
                                <h5 class="mb-3">No trains found for your search criteria</h5>
                                <p class="text-muted mb-4">Please try different dates or destinations</p>
                                <a href="${pageContext.request.contextPath}/search" class="btn btn-primary">
                                    <i class="fas fa-search me-2"></i>New Search
                                </a>
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty journeys}">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Train</th>
                                    <th>Departure</th>
                                    <th>Arrival</th>
                                    <th>Duration</th>
                                    <th>Type</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="journey" items="${journeys}">
                                    <tr>
                                        <td>${journey.train.name}</td>
                                        <td>
                                            <fmt:formatDate value="${journey.departureTime}" pattern="HH:mm" />
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${journey.arrivalTime}" pattern="HH:mm" />
                                        </td>
                                        <td>${journey.durationInMinutes} min</td>
                                        <td>${journey.direct ? 'Direct' : 'Regular'}</td>
                                        <td>
                                            <span class="badge ${journey.status == 'SCHEDULED' ? 'badge-success' : journey.status == 'DELAYED' ? 'badge-warning' : 'badge-danger'}">
                                                ${journey.status}
                                            </span>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/journey-details?id=${journey.journeyId}" class="btn btn-sm btn-primary">Select</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <a href="${pageContext.request.contextPath}/search" class="btn btn-primary">New Search</a>
                </c:if>
            </div>
        </div>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>