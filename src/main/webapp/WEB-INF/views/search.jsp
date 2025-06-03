<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rechercher un train - Système de Billetterie</title>
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
        
        .search-card {
            border: none;
            border-radius: 15px;
            box-shadow: var(--card-shadow);
            overflow: hidden;
            backdrop-filter: blur(10px);
            background-color: rgba(255, 255, 255, 0.95);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .search-card:hover {
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
        
        .form-control, .form-select {
            border-radius: 8px;
            padding: 12px 15px;
            border: 1px solid #e0e0e0;
            transition: all 0.3s;
            height: auto;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--accent-color);
            box-shadow: 0 0 0 0.25rem rgba(76, 201, 240, 0.25);
        }
        
        .btn-primary {
            background: var(--gradient);
            border: none;
            padding: 12px 30px;
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
        
        .btn-primary::after {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 100%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.4) 0%, rgba(255,255,255,0) 70%);
            transform: rotate(30deg);
            transition: all 0.5s;
            opacity: 0;
        }
        
        .btn-primary:hover::after {
            opacity: 1;
            right: 0;
            top: 0;
        }
        
        .form-check-input:checked {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .form-check-label {
            user-select: none;
        }
        
        .alert {
            border-radius: 8px;
            border: none;
        }
        
        .search-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--primary-color);
            pointer-events: none;
        }
        
        .form-group {
            position: relative;
        }
        
        .container {
            max-width: 900px;
        }
        
        @media (max-width: 768px) {
            .card-header {
                padding: 1rem;
            }
            
            .btn-primary {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <div class="container my-5 animate__animated animate__fadeIn">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="search-card">
                    <div class="card-header">
                        <h4><i class="fas fa-train me-2"></i>Rechercher un train</h4>
                    </div>
                    <div class="card-body p-4">
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show animate__animated animate__shakeX" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i>${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>
                        
                        <form action="${pageContext.request.contextPath}/search" method="post">
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label for="departureCity" class="form-label">Ville de départ</label>
                                    <div class="position-relative">
                                        <select class="form-select" id="departureCity" name="departureCity" required>
                                            <option value="" selected disabled>Sélectionnez une ville</option>
                                            <c:forEach var="city" items="${cities}">
                                                <option value="${city}">${city}</option>
                                            </c:forEach>
                                        </select>
                                        <i class="fas fa-map-marker-alt search-icon"></i>
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <label for="arrivalCity" class="form-label">Ville d'arrivée</label>
                                    <div class="position-relative">
                                        <select class="form-select" id="arrivalCity" name="arrivalCity" required>
                                            <option value="" selected disabled>Sélectionnez une ville</option>
                                            <c:forEach var="city" items="${cities}">
                                                <option value="${city}">${city}</option>
                                            </c:forEach>
                                        </select>
                                        <i class="fas fa-map-marker-alt search-icon"></i>
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <label for="date" class="form-label">Date de voyage</label>
                                    <div class="position-relative">
                                        <input type="date" class="form-control" id="date" name="date" required>
                                        <i class="fas fa-calendar-day search-icon"></i>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="form-group mt-3">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="directOnly" name="directOnly">
                                    <label class="form-check-label" for="directOnly">
                                        <i class="fas fa-route me-2"></i>Trains directs uniquement
                                    </label>
                                </div>
                            </div>
                            
                            <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-search me-2"></i>Rechercher
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Définir la date minimale au jour actuel
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('date').min = today;
            
            // Optionnel: Définir la date par défaut à aujourd'hui
            document.getElementById('date').value = today;
            
            // Échanger les villes départ/arrivée
            const departureSelect = document.getElementById('departureCity');
            const arrivalSelect = document.getElementById('arrivalCity');
            
            departureSelect.addEventListener('change', function() {
                if (this.value === arrivalSelect.value) {
                    arrivalSelect.value = '';
                }
            });
            
            arrivalSelect.addEventListener('change', function() {
                if (this.value === departureSelect.value) {
                    departureSelect.value = '';
                }
            });
        });
    </script>
</body>
</html>