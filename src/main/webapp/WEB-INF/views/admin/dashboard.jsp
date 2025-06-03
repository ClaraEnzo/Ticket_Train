<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Train Ticket System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body style="font-family: 'Poppins', sans-serif; background-color: #f5f7fa;">
    <jsp:include page="/WEB-INF/views/common/admin-header.jsp" />
    
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp"  />
            
            <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4 py-4" style="margin-left: 250px;">
                <!-- Header with gradient -->
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-4 mb-4 border-bottom">
                    <div>
                        <h1 class="h3 fw-bold text-gradient">
                            <i class="fas fa-tachometer-alt me-2"></i>Tableau de Bord Administrateur
                        </h1>
                        <p class="mb-0 text-muted">Bonjour, ${sessionScope.user.fullName}! Voici un aperçu de votre système.</p>
                    </div>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group">
                            <button type="button" class="btn btn-sm btn-primary">
                                <i class="fas fa-download me-1"></i> Exporter
                            </button>
                            <button type="button" class="btn btn-sm btn-outline-secondary">
                                <i class="fas fa-calendar me-1"></i> Période
                            </button>
                        </div>
                    </div>
                </div>
                
                <!-- Stats Cards with hover effects -->
                <div class="row mb-4">
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card card-hover border-start border-primary border-4 h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-uppercase text-primary fw-bold mb-2">Utilisateurs Totaux</h6>
                                        <h2 class="mb-0 fw-bold">${totalUsers}</h2>
                                    </div>
                                    <div class="icon-shape bg-primary bg-opacity-10 rounded-3 p-3">
                                        <i class="fas fa-users text-primary fs-4"></i>
                                    </div>
                                </div>
                                <div class="mt-3">
                                    <span class="badge bg-primary bg-opacity-10 text-primary">
                                        <i class="fas fa-arrow-up me-1"></i> 12% ce mois
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card card-hover border-start border-success border-4 h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-uppercase text-success fw-bold mb-2">Stations Actives</h6>
                                        <h2 class="mb-0 fw-bold">${totalCities}</h2>
                                    </div>
                                    <div class="icon-shape bg-success bg-opacity-10 rounded-3 p-3">
                                        <i class="fas fa-map-marker-alt text-success fs-4"></i>
                                    </div>
                                </div>
                                <div class="mt-3">
                                    <span class="badge bg-success bg-opacity-10 text-success">
                                        <i class="fas fa-arrow-up me-1"></i> 5% ce mois
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card card-hover border-start border-info border-4 h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-uppercase text-info fw-bold mb-2">Administrateurs</h6>
                                        <h2 class="mb-0 fw-bold">${totalUsers-clientCount}</h2>
                                    </div>
                                    <div class="icon-shape bg-info bg-opacity-10 rounded-3 p-3">
                                        <i class="fas fa-user-tie text-info fs-4"></i>
                                    </div>
                                </div>
                                <div class="mt-3">
                                    <span class="badge bg-info bg-opacity-10 text-info">
                                        <i class="fas fa-equals me-1"></i> Stable
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card card-hover border-start border-warning border-4 h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-uppercase text-warning fw-bold mb-2">Clients</h6>
                                        <h2 class="mb-0 fw-bold">${clientCount}</h2>
                                    </div>
                                    <div class="icon-shape bg-warning bg-opacity-10 rounded-3 p-3">
                                        <i class="fas fa-user text-warning fs-4"></i>
                                    </div>
                                </div>
                                <div class="mt-3">
                                    <span class="badge bg-warning bg-opacity-10 text-warning">
                                        <i class="fas fa-arrow-up me-1"></i> 18% ce mois
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Main Content -->
                <div class="row">
                    <!-- Welcome Card -->
                    <div class="col-lg-8 mb-4">
                        <div class="card card-hover border-0 shadow-sm h-100">
                            <div class="card-header bg-white border-0 py-3">
                                <h5 class="mb-0 fw-bold">
                                    <i class="fas fa-info-circle text-primary me-2"></i>Bienvenue dans l'espace administrateur
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="d-flex align-items-center mb-4">
                                    <div class="flex-shrink-0">
                                        <img src="https://ui-avatars.com/api/?name=${sessionScope.user.fullName}&background=4e73df&color=fff&size=64" 
                                             class="rounded-circle shadow-sm" width="64" alt="Profile">
                                    </div>
                                    <div class="flex-grow-1 ms-3">
                                        <h5 class="mb-1">${sessionScope.user.fullName}</h5>
                                        <p class="text-muted mb-2">Dernière connexion: Aujourd'hui à <fmt:formatDate value="${lastLogin}" pattern="HH:mm" /></p>
                                        <span class="badge bg-primary bg-opacity-10 text-primary">
                                            <i class="fas fa-shield-alt me-1"></i> Administrateur
                                        </span>
                                    </div>
                                </div>
                                
                                <h6 class="fw-bold mb-3">Actions rapides :</h6>
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <a href="${pageContext.request.contextPath}/admin/users" class="card quick-action-card mb-3 text-decoration-none">
                                            <div class="card-body text-center p-3">
                                                <div class="icon-lg bg-primary bg-opacity-10 text-primary rounded-circle mb-2 mx-auto">
                                                    <i class="fas fa-users"></i>
                                                </div>
                                                <h6 class="mb-0">Gérer les utilisateurs</h6>
                                            </div>
                                        </a>
                                    </div>
                                    <div class="col-md-6">
                                        <a href="${pageContext.request.contextPath}/admin/stations" class="card quick-action-card mb-3 text-decoration-none">
                                            <div class="card-body text-center p-3">
                                                <div class="icon-lg bg-success bg-opacity-10 text-success rounded-circle mb-2 mx-auto">
                                                    <i class="fas fa-map-marker-alt"></i>
                                                </div>
                                                <h6 class="mb-0">Gérer les stations</h6>
                                            </div>
                                        </a>
                                    </div>
                                    <div class="col-md-6">
                                        <a href="${pageContext.request.contextPath}/admin/trains" class="card quick-action-card mb-3 text-decoration-none">
                                            <div class="card-body text-center p-3">
                                                <div class="icon-lg bg-info bg-opacity-10 text-info rounded-circle mb-2 mx-auto">
                                                    <i class="fas fa-train"></i>
                                                </div>
                                                <h6 class="mb-0">Gérer les trains</h6>
                                            </div>
                                        </a>
                                    </div>
                                    <div class="col-md-6">
                                        <a href="${pageContext.request.contextPath}/admin/routes" class="card quick-action-card mb-3 text-decoration-none">
                                            <div class="card-body text-center p-3">
                                                <div class="icon-lg bg-warning bg-opacity-10 text-warning rounded-circle mb-2 mx-auto">
                                                    <i class="fas fa-route"></i>
                                                </div>
                                                <h6 class="mb-0">Gérer les routes</h6>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Recent Activity -->
                    <div class="col-lg-4 mb-4">
                        <div class="card card-hover border-0 shadow-sm h-100">
                            <div class="card-header bg-white border-0 py-3">
                                <h5 class="mb-0 fw-bold">
                                    <i class="fas fa-clock text-primary me-2"></i>Activité récente
                                </h5>
                            </div>
                            <div class="card-body">
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item border-0 px-0 py-2 d-flex align-items-center">
                                        <div class="icon-sm bg-primary bg-opacity-10 text-primary rounded-circle me-3">
                                            <i class="fas fa-user-plus"></i>
                                        </div>
                                        <div>
                                            <h6 class="mb-0 fw-bold">5 nouveaux utilisateurs</h6>
                                            <small class="text-muted">Aujourd'hui</small>
                                        </div>
                                    </li>
                                    <li class="list-group-item border-0 px-0 py-2 d-flex align-items-center">
                                        <div class="icon-sm bg-success bg-opacity-10 text-success rounded-circle me-3">
                                            <i class="fas fa-ticket-alt"></i>
                                        </div>
                                        <div>
                                            <h6 class="mb-0 fw-bold">23 billets vendus</h6>
                                            <small class="text-muted">Cette semaine</small>
                                        </div>
                                    </li>
                                    <li class="list-group-item border-0 px-0 py-2 d-flex align-items-center">
                                        <div class="icon-sm bg-info bg-opacity-10 text-info rounded-circle me-3">
                                            <i class="fas fa-calendar-check"></i>
                                        </div>
                                        <div>
                                            <h6 class="mb-0 fw-bold">156 réservations</h6>
                                            <small class="text-muted">Ce mois</small>
                                        </div>
                                    </li>
                                    <li class="list-group-item border-0 px-0 py-2 d-flex align-items-center">
                                        <div class="icon-sm bg-warning bg-opacity-10 text-warning rounded-circle me-3">
                                            <i class="fas fa-exclamation-circle"></i>
                                        </div>
                                        <div>
                                            <h6 class="mb-0 fw-bold">3 problèmes signalés</h6>
                                            <small class="text-muted">Hier</small>
                                        </div>
                                    </li>
                                </ul>
                                <a href="#" class="btn btn-outline-primary w-100 mt-3">
                                    <i class="fas fa-history me-1"></i> Voir toute l'activité
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Additional Section -->
                <div class="row mt-4">
                    <div class="col-12">
                        <div class="card border-0 shadow-sm">
                            <div class="card-header bg-white border-0 py-3">
                                <h5 class="mb-0 fw-bold">
                                    <i class="fas fa-chart-line text-primary me-2"></i>Statistiques du système
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="row text-center">
                                    <div class="col-md-3 mb-3 mb-md-0">
                                        <div class="p-3 bg-light rounded-3">
                                            <h3 class="fw-bold text-primary">1,254</h3>
                                            <p class="mb-0 text-muted">Voyages ce mois</p>
                                        </div>
                                    </div>
                                    <div class="col-md-3 mb-3 mb-md-0">
                                        <div class="p-3 bg-light rounded-3">
                                            <h3 class="fw-bold text-success">€24,560</h3>
                                            <p class="mb-0 text-muted">Revenus totaux</p>
                                        </div>
                                    </div>
                                    <div class="col-md-3 mb-3 mb-md-0">
                                        <div class="p-3 bg-light rounded-3">
                                            <h3 class="fw-bold text-info">92%</h3>
                                            <p class="mb-0 text-muted">Taux de satisfaction</p>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="p-3 bg-light rounded-3">
                                            <h3 class="fw-bold text-warning">12</h3>
                                            <p class="mb-0 text-muted">Trains actifs</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</body>
</html>

<style>
:root {
    --primary: #4e73df;
    --success: #1cc88a;
    --info: #36b9cc;
    --warning: #f6c23e;
    --danger: #e74a3b;
    --secondary: #858796;
    --light: #f8f9fc;
}

body {
    font-family: 'Poppins', sans-serif;
    background-color: #f5f7fa;
}

.text-gradient {
    background: linear-gradient(90deg, var(--primary), var(--info));
    -webkit-background-clip: text;
    background-clip: text;
    color: transparent;
}

.card {
    border: none;
    border-radius: 0.5rem;
    transition: all 0.3s ease;
}

.card-hover:hover {
    transform: translateY(-5px);
    box-shadow: 0 0.5rem 1.5rem rgba(0, 0, 0, 0.1);
}

.card-header {
    border-bottom: 1px solid rgba(0, 0, 0, 0.05);
}

.icon-shape {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 3rem;
    height: 3rem;
}

.icon-lg {
    width: 2.5rem;
    height: 2.5rem;
    display: inline-flex;
    align-items: center;
    justify-content: center;
}

.icon-sm {
    width: 2rem;
    height: 2rem;
    display: inline-flex;
    align-items: center;
    justify-content: center;
}

.quick-action-card {
    transition: all 0.3s ease;
    border: 1px solid rgba(0, 0, 0, 0.05);
}

.quick-action-card:hover {
    background-color: var(--light);
    border-color: var(--primary);
}

.border-start {
    border-left-width: 0.25rem !important;
}

.bg-opacity-10 {
    background-color: rgba(var(--bs-primary-rgb), 0.1) !important;
}

/* Custom scrollbar for sidebar */
::-webkit-scrollbar {
    width: 5px;
}

::-webkit-scrollbar-track {
    background: #f1f1f1;
}

::-webkit-scrollbar-thumb {
    background: #888;
    border-radius: 10px;
}

::-webkit-scrollbar-thumb:hover {
    background: #555;
}
</style>