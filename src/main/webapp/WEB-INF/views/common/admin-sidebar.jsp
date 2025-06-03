<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
    <div class="sidebar-sticky pt-3">
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link ${fn:contains(pageContext.request.requestURI, '/admin/dashboard') ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="fas fa-tachometer-alt"></i> Tableau de Bord
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${fn:contains(pageContext.request.requestURI, '/admin/users') ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/users">
                    <i class="fas fa-users"></i> Utilisateurs
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${fn:contains(pageContext.request.requestURI, '/admin/stations') ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/stations">
                    <i class="fas fa-map-marker-alt"></i> Stations
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${fn:contains(pageContext.request.requestURI, '/admin/trains') ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/trains">
                    <i class="fas fa-train"></i> Trains
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${fn:contains(pageContext.request.requestURI, '/admin/routes') ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/routes">
                    <i class="fas fa-route"></i> Routes
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${fn:contains(pageContext.request.requestURI, '/admin/journeys') ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/journeys">
                    <i class="fas fa-calendar-alt"></i> Voyages
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${fn:contains(pageContext.request.requestURI, '/admin/tickets') ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/tickets">
                    <i class="fas fa-ticket-alt"></i> Billets
                </a>
            </li>
        </ul>
        
        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
            <span>Rapports</span>
        </h6>
        <ul class="nav flex-column mb-2">
            <li class="nav-item">
                <a class="nav-link ${fn:contains(pageContext.request.requestURI, '/admin/reports') ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/reports">
                    <i class="fas fa-chart-bar"></i> Statistiques
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${fn:contains(pageContext.request.requestURI, '/admin/logs') ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/logs">
                    <i class="fas fa-file-alt"></i> Logs Système
                </a>
            </li>
        </ul>
        
        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
            <span>Système</span>
        </h6>
        <ul class="nav flex-column mb-2">
            <li class="nav-item">
                <a class="nav-link ${fn:contains(pageContext.request.requestURI, '/admin/settings') ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/settings">
                    <i class="fas fa-cog"></i> Paramètres
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/" target="_blank">
                    <i class="fas fa-external-link-alt"></i> Site Public
                </a>
            </li>
        </ul>
        
        <!-- Informations utilisateur en bas -->
        <div class="sidebar-footer mt-auto px-3 py-2">
            <small class="text-muted">
                <i class="fas fa-user"></i> ${sessionScope.user.fullName}<br>
                <span class="badge badge-${sessionScope.user.role == 'ADMIN' ? 'danger' : 'primary'} badge-sm">
                    ${sessionScope.user.role}
                </span>
            </small>
        </div>
    </div>
</nav>

<style>
.sidebar {
    position: fixed;
    top: 56px; /* Height of navbar */
    bottom: 0;
    left: 0;
    z-index: 100;
    padding: 48px 0 0;
    box-shadow: inset -1px 0 0 rgba(0, 0, 0, .1);
    background: linear-gradient(180deg, #f8f9fa 0%, #e9ecef 100%);
}

.sidebar-sticky {
    position: relative;
    top: 0;
    height: calc(100vh - 48px);
    padding-top: .5rem;
    overflow-x: hidden;
    overflow-y: auto;
    display: flex;
    flex-direction: column;
}

.sidebar .nav-link {
    font-weight: 500;
    color: #495057;
    padding: 0.75rem 1rem;
    border-radius: 0.375rem;
    margin: 0.125rem 0.5rem;
    transition: all 0.2s ease-in-out;
    text-decoration: none;
}

.sidebar .nav-link:hover {
    color: #007bff;
    background-color: rgba(0, 123, 255, 0.1);
    text-decoration: none;
}

.sidebar .nav-link.active {
    color: #007bff;
    background-color: rgba(0, 123, 255, 0.15);
    border-left: 3px solid #007bff;
    font-weight: 600;
}

.sidebar .nav-link .fas {
    margin-right: 8px;
    color: #6c757d;
    width: 16px;
    text-align: center;
}

.sidebar .nav-link:hover .fas,
.sidebar .nav-link.active .fas {
    color: inherit;
}

.sidebar-heading {
    font-size: 0.75rem;
    text-transform: uppercase;
    font-weight: 600;
    letter-spacing: 0.05em;
}

.sidebar-footer {
    border-top: 1px solid #dee2e6;
    background-color: rgba(255, 255, 255, 0.8);
    margin-top: auto;
}

/* Responsive adjustments */
@media (max-width: 767.98px) {
    .sidebar {
        position: relative;
        top: 0;
        height: auto;
        padding: 0;
    }
    
    .sidebar-sticky {
        height: auto;
    }
}

/* Animation pour les liens */
.sidebar .nav-link {
    position: relative;
    overflow: hidden;
}

.sidebar .nav-link::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
    transition: left 0.5s;
}

.sidebar .nav-link:hover::before {
    left: 100%;
}

/* Amélioration du scroll */
.sidebar-sticky::-webkit-scrollbar {
    width: 6px;
}

.sidebar-sticky::-webkit-scrollbar-track {
    background: #f1f1f1;
}

.sidebar-sticky::-webkit-scrollbar-thumb {
    background: #c1c1c1;
    border-radius: 3px;
}

.sidebar-sticky::-webkit-scrollbar-thumb:hover {
    background: #a8a8a8;
}

/* Badge personnalisé */
.badge-sm {
    font-size: 0.65em;
    padding: 0.25em 0.4em;
}

/* Effet de focus pour l'accessibilité */
.sidebar .nav-link:focus {
    outline: 2px solid #007bff;
    outline-offset: 2px;
}
</style>

<script>
// Script pour améliorer l'expérience utilisateur
document.addEventListener('DOMContentLoaded', function() {
    // Ajouter un indicateur de chargement lors du clic sur les liens
    const sidebarLinks = document.querySelectorAll('.sidebar .nav-link');
    
    sidebarLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            // Ne pas ajouter l'indicateur pour les liens externes
            if (this.getAttribute('target') === '_blank') {
                return;
            }
            
            // Ajouter un spinner temporaire
            const icon = this.querySelector('.fas');
            const originalClass = icon.className;
            
            icon.className = 'fas fa-spinner fa-spin';
            
            // Restaurer l'icône après un délai
            setTimeout(() => {
                icon.className = originalClass;
            }, 1000);
        });
    });
    
    // Highlight du lien actuel au chargement de la page
    const currentPath = window.location.pathname;
    sidebarLinks.forEach(link => {
        const href = link.getAttribute('href');
        if (href && currentPath.includes(href.split('/').pop())) {
            link.classList.add('active');
        }
    });
});
</script>