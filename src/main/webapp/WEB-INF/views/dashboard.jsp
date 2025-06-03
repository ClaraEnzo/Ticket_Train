<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de Bord - Train Ticket System</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2c3e50;
            --accent-color: #e74c3c;
            --light-color: #ecf0f1;
            --dark-color: #2c3e50;
            --success-color: #27ae60;
            --warning-color: #f39c12;
            --info-color: #2980b9;
        }
        
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .dashboard-header {
            background: linear-gradient(135deg, var(--secondary-color), var(--primary-color));
            color: white;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            margin-bottom: 2rem;
        }
        
        .dashboard-header h1 {
            font-weight: 700;
        }
        
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin-bottom: 1.5rem;
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }
        
        .card-header {
            border-radius: 10px 10px 0 0 !important;
            font-weight: 600;
            border-bottom: none;
        }
        
        .badge {
            font-size: 0.85rem;
            padding: 0.35em 0.65em;
            font-weight: 500;
        }
        
        .list-group-item {
            border-left: none;
            border-right: none;
            padding: 1rem 1.25rem;
            transition: all 0.3s ease;
        }
        
        .list-group-item:hover {
            background-color: rgba(52, 152, 219, 0.1);
            padding-left: 1.5rem;
        }
        
        .list-group-item i {
            width: 24px;
            text-align: center;
            margin-right: 10px;
            color: var(--primary-color);
        }
        
        .btn-outline-primary {
            border-width: 2px;
            font-weight: 500;
        }
        
        .admin-badge {
            background: linear-gradient(135deg, #f39c12, #e74c3c);
            color: white;
            border-radius: 50px;
            padding: 0.5rem 1rem;
            display: inline-flex;
            align-items: center;
        }
        
        .admin-badge i {
            margin-right: 8px;
        }
        
        .user-info-table th {
            width: 40%;
            color: var(--secondary-color);
            font-weight: 600;
        }
        
        .quick-actions-btn {
            height: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 1.5rem 0.5rem;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        
        .quick-actions-btn i {
            font-size: 1.75rem;
            margin-bottom: 10px;
        }
        
        .quick-actions-btn:hover {
            background-color: rgba(52, 152, 219, 0.1);
            transform: translateY(-3px);
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <div class="container mt-4">
        <!-- Messages d'erreur/succès -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle mr-2"></i> ${error}
                <button type="button" class="close" data-dismiss="alert">
                    <span>&times;</span>
                </button>
            </div>
        </c:if>
        
        <!-- Message de bienvenue -->
        <div class="dashboard-header">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h1 class="display-4 font-weight-bold">
                        <i class="fas fa-tachometer-alt mr-3"></i> ${welcomeMessage}
                    </h1>
                    <p class="lead mb-0">Bienvenue sur votre tableau de bord personnel</p>
                </div>
                <div>
                    <span class="badge badge-light p-2">
                        <i class="fas fa-calendar-day mr-2"></i>
                        <fmt:formatDate value="<%= new java.util.Date() %>" pattern="EEEE dd MMMM yyyy" />
                    </span>
                </div>
            </div>
            
            <c:if test="${isAdmin}">
                <div class="admin-badge mt-3">
                    <i class="fas fa-crown"></i>
                    <span>${adminMessage}</span>
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-light btn-sm ml-3">
                        <i class="fas fa-cog mr-1"></i> Panneau d'administration
                    </a>
                </div>
            </c:if>
        </div>
        
        <!-- Informations utilisateur et actions rapides -->
        <div class="row">
            <div class="col-lg-6">
                <div class="card">
                    <div class="card-header bg-primary text-white d-flex align-items-center">
                        <i class="fas fa-user mr-2"></i>
                        <h5 class="mb-0">Mes Informations</h5>
                    </div>
                    <div class="card-body">
                        <table class="table user-info-table">
                            <tr>
                                <th>Nom d'utilisateur:</th>
                                <td>${user.username}</td>
                            </tr>
                            <tr>
                                <th>Nom complet:</th>
                                <td>${user.fullName}</td>
                            </tr>
                            <tr>
                                <th>Email:</th>
                                <td>${user.email}</td>
                            </tr>
                            <tr>
                                <th>Téléphone:</th>
                                <td>${not empty user.phone ? user.phone : '<span class="text-muted">Non renseigné</span>'}</td>
                            </tr>
                            <tr>
                                <th>Rôle:</th>
                                <td>
                                    <span class="badge badge-${user.role == 'ADMIN' ? 'danger' : user.role == 'EMPLOYEE' ? 'warning' : 'primary'}">
                                        ${user.role}
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <th>Membre depuis:</th>
                                <td>
                                    <fmt:formatDate value="${user.createdAt}" pattern="dd MMMM yyyy" />
                                </td>
                            </tr>
                        </table>
                        
                        <div class="d-flex justify-content-end mt-3">
                            <a href="${pageContext.request.contextPath}/profile" class="btn btn-primary">
                                <i class="fas fa-edit mr-2"></i> Modifier mon profil
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-6">
                <div class="card">
                    <div class="card-header bg-success text-white d-flex align-items-center">
                        <i class="fas fa-bolt mr-2"></i>
                        <h5 class="mb-0">Actions Rapides</h5>
                    </div>
                    <div class="card-body p-0">
                        <div class="list-group list-group-flush">
                            <a href="${pageContext.request.contextPath}/search" class="list-group-item list-group-item-action d-flex align-items-center">
                                <i class="fas fa-search text-primary"></i>
                                <span>Rechercher des trains</span>
                                <i class="fas fa-chevron-right ml-auto text-muted"></i>
                            </a>
                            <a href="${pageContext.request.contextPath}/my-tickets" class="list-group-item list-group-item-action d-flex align-items-center">
                                <i class="fas fa-ticket-alt text-primary"></i>
                                <span>Mes billets</span>
                                <i class="fas fa-chevron-right ml-auto text-muted"></i>
                            </a>
                            <a href="${pageContext.request.contextPath}/booking-history" class="list-group-item list-group-item-action d-flex align-items-center">
                                <i class="fas fa-history text-primary"></i>
                                <span>Historique des réservations</span>
                                <i class="fas fa-chevron-right ml-auto text-muted"></i>
                            </a>
                            <a href="${pageContext.request.contextPath}/profile" class="list-group-item list-group-item-action d-flex align-items-center">
                                <i class="fas fa-user-cog text-primary"></i>
                                <span>Paramètres du compte</span>
                                <i class="fas fa-chevron-right ml-auto text-muted"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Section statistiques (pour les admins) -->
        <c:if test="${isAdmin}">
            <div class="row mt-4">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header bg-warning text-dark d-flex align-items-center">
                            <i class="fas fa-chart-line mr-2"></i>
                            <h5 class="mb-0">Accès Rapide Administration</h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-3 mb-3">
                                    <a href="${pageContext.request.contextPath}/admin/users" class="quick-actions-btn text-center">
                                        <i class="fas fa-users text-primary"></i>
                                        <span class="font-weight-bold">Gestion Utilisateurs</span>
                                        <small class="text-muted">Gérer les comptes</small>
                                    </a>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <a href="${pageContext.request.contextPath}/admin/stations" class="quick-actions-btn text-center">
                                        <i class="fas fa-map-marker-alt text-success"></i>
                                        <span class="font-weight-bold">Stations</span>
                                        <small class="text-muted">Gérer les gares</small>
                                    </a>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <a href="${pageContext.request.contextPath}/admin/trains" class="quick-actions-btn text-center">
                                        <i class="fas fa-train text-info"></i>
                                        <span class="font-weight-bold">Trains</span>
                                        <small class="text-muted">Gérer le matériel</small>
                                    </a>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="quick-actions-btn text-center">
                                        <i class="fas fa-chart-pie text-warning"></i>
                                        <span class="font-weight-bold">Statistiques</span>
                                        <small class="text-muted">Tableau de bord</small>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        // Animation pour les cartes au chargement
        $(document).ready(function() {
            $('.card').each(function(i) {
                $(this).delay(i * 100).animate({
                    opacity: 1
                }, 400);
            });
        });
    </script>
</body>
</html>