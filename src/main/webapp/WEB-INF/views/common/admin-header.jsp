<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="navbar navbar-expand-md navbar-dark bg-dark sticky-top shadow">
    <div class="container-fluid">
        <!-- Brand & Toggler -->
        <a class="navbar-brand me-0 me-md-2" href="${pageContext.request.contextPath}/admin/dashboard">
            <i class="fas fa-train me-2"></i>Train Admin
        </a>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <!-- Main Navbar Content -->
        <div class="collapse navbar-collapse" id="navbarCollapse">
            <!-- Search Bar (visible on desktop) -->
            <form class="d-none d-md-flex w-100 mx-2">
                <div class="input-group">
                    <input class="form-control form-control-dark" type="search" placeholder="Rechercher..." aria-label="Search">
                    <button class="btn btn-outline-light" type="submit">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </form>
            
            <!-- User Dropdown -->
            <ul class="navbar-nav ms-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                        <div class="me-2 d-none d-sm-block">${sessionScope.user.fullName}</div>
                        <div class="position-relative">
                            <i class="fas fa-user-circle fs-4"></i>
                            <span class="position-absolute top-0 start-100 translate-middle p-1 bg-success border border-light rounded-circle">
                                <span class="visually-hidden">Online</span>
                            </span>
                        </div>
                    </a>
                    <div class="dropdown-menu dropdown-menu-end shadow">
                        <div class="px-4 py-3">
                            <p class="mb-0 fw-bold">${sessionScope.user.fullName}</p>
                            <small class="text-muted">${sessionScope.user.email}</small>
                        </div>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/profile">
                            <i class="fas fa-user-edit me-2"></i> Profil
                        </a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/settings">
                            <i class="fas fa-cog me-2"></i> Paramètres
                        </a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/" target="_blank">
                            <i class="fas fa-external-link-alt me-2"></i> Site Public
                        </a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">
                            <i class="fas fa-sign-out-alt me-2"></i> Déconnexion
                        </a>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Mobile Search (hidden on desktop) -->
<div class="d-md-none bg-dark p-2">
    <form class="w-100">
        <div class="input-group">
            <input class="form-control form-control-dark" type="search" placeholder="Rechercher..." aria-label="Search">
            <button class="btn btn-outline-light" type="submit">
                <i class="fas fa-search"></i>
            </button>
        </div>
    </form>
</div>

<style>
.navbar {
    padding-top: 0.5rem;
    padding-bottom: 0.5rem;
}

.navbar-brand {
    font-weight: 600;
    padding: 0.5rem 1rem;
    border-radius: 0.375rem;
    background-color: rgba(255, 255, 255, 0.1);
}

.form-control-dark {
    color: #fff;
    background-color: rgba(255, 255, 255, 0.1);
    border-color: rgba(255, 255, 255, 0.1);
}

.form-control-dark:focus {
    color: #fff;
    background-color: rgba(255, 255, 255, 0.2);
    border-color: rgba(255, 255, 255, 0.3);
    box-shadow: 0 0 0 0.25rem rgba(255, 255, 255, 0.1);
}

.dropdown-menu {
    border: none;
    min-width: 280px;
}

.dropdown-item {
    padding: 0.5rem 1.5rem;
}

.dropdown-item:active {
    background-color: #f8f9fa;
    color: #212529;
}

@media (max-width: 767.98px) {
    .navbar-collapse {
        padding-top: 1rem;
    }
}
</style>