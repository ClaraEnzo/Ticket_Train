<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
    :root {
        --primary-color: #3498db;
        --primary-dark: #2980b9;
        --secondary-color: #2c3e50;
        --accent-color: #e74c3c;
        --light-color: #ecf0f1;
    }
    
    .navbar-custom {
        background: linear-gradient(135deg, var(--secondary-color), var(--primary-color));
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        padding: 0.8rem 0;
    }
    
    .navbar-brand {
        font-weight: 700;
        font-size: 1.4rem;
        display: flex;
        align-items: center;
    }
    
    .navbar-brand i {
        font-size: 1.6rem;
        color: #fff;
        transition: transform 0.3s ease;
    }
    
    .navbar-brand:hover i {
        transform: rotate(-15deg);
    }
    
    .nav-link {
        font-weight: 500;
        padding: 0.5rem 1rem;
        margin: 0 0.2rem;
        border-radius: 6px;
        transition: all 0.3s ease;
        position: relative;
    }
    
    .nav-link:not(.dropdown-toggle):hover {
        background-color: rgba(255, 255, 255, 0.15);
    }
    
    .nav-link.active {
        background-color: rgba(255, 255, 255, 0.2);
        font-weight: 600;
    }
    
    .nav-link.active::after {
        content: '';
        position: absolute;
        bottom: -8px;
        left: 50%;
        transform: translateX(-50%);
        width: 60%;
        height: 3px;
        background-color: white;
        border-radius: 3px;
    }
    
    .dropdown-menu {
        border: none;
        border-radius: 8px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        padding: 0.5rem 0;
        margin-top: 8px;
    }
    
    .dropdown-item {
        padding: 0.5rem 1.5rem;
        font-weight: 500;
        transition: all 0.2s ease;
    }
    
    .dropdown-item:hover {
        background-color: #f8f9fa;
        padding-left: 1.8rem;
    }
    
    .dropdown-divider {
        margin: 0.4rem 0;
    }
    
    .user-greeting {
        display: flex;
        align-items: center;
    }
    
    .user-greeting::before {
        content: '';
        display: inline-block;
        width: 8px;
        height: 8px;
        background-color: #2ecc71;
        border-radius: 50%;
        margin-right: 8px;
        box-shadow: 0 0 0 2px rgba(46, 204, 113, 0.3);
    }
    
    @media (max-width: 991.98px) {
        .navbar-collapse {
            padding: 1rem 0;
        }
        
        .nav-link {
            margin: 0.2rem 0;
            padding: 0.8rem 1rem;
        }
        
        .nav-link.active::after {
            display: none;
        }
    }
</style>

<nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <i class="fas fa-train me-2"></i> RailExpress
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain"
            aria-controls="navbarMain" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarMain">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.endsWith('/index.jsp') ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/">
                        <i class="fas fa-home me-1"></i> Accueil
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.contains('search') ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/search">
                        <i class="fas fa-search me-1"></i> Rechercher
                    </a>
                </li>
                <c:if test="${not empty sessionScope.user}">
                    <li class="nav-item">
                        <a class="nav-link ${pageContext.request.requestURI.contains('my-tickets') ? 'active' : ''}" 
                           href="${pageContext.request.contextPath}/my-tickets">
                            <i class="fas fa-ticket-alt me-1"></i> Mes billets
                        </a>
                    </li>
                </c:if>
            </ul>

            <ul class="navbar-nav ms-auto">
    <c:choose>
        <c:when test="${not empty sessionScope.user}">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle user-greeting" href="#" id="userDropdown" role="button"
                   data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    ${sessionScope.user.fullName}
                </a>
                <div class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/dashboard">
                        <i class="fas fa-tachometer-alt me-2"></i> Tableau de bord
                    </a>
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/profile">
                        <i class="fas fa-user-cog me-2"></i> Mon profil
                    </a>
                    <c:if test="${sessionScope.user.role == 'ADMIN'}">
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item text-warning" href="${pageContext.request.contextPath}/admin/dashboard">
                            <i class="fas fa-crown me-2"></i> Administration
                        </a>
                    </c:if>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">
                        <i class="fas fa-sign-out-alt me-2"></i> Déconnexion
                    </a>
                </div>
            </li>
        </c:when>
        <c:otherwise>
            <li class="nav-item">
                <a class="nav-link ${fn:contains(pageContext.request.requestURI, 'login') ? 'active' : ''}" 
                    href="${pageContext.request.contextPath}/login">
                    <i class="fas fa-sign-in-alt me-1"></i> Connexion
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link btn btn-outline-light ms-2 px-3 ${fn:contains(pageContext.request.requestURI, 'register') ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/register">
                    <i class="fas fa-user-plus me-1"></i> Inscription
                </a>
            </li>
        </c:otherwise>
    </c:choose>
</ul>
        </div>
    </div>
</nav>