<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Système de Billetterie de Train - Accueil</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <div class="container mt-5">
        <div class="jumbotron">
            <h1 class="display-4">Bienvenue sur le Système de Billetterie de Train</h1>
            <p class="lead">Réservez vos billets de train en ligne facilement et rapidement.</p>
            <hr class="my-4">
            <p>Recherchez les trains disponibles, réservez vos billets et gérez vos voyages au même endroit.</p>
            <a class="btn btn-primary btn-lg" href="${pageContext.request.contextPath}/search" role="button">Rechercher un train</a>
        </div>
        
        <div class="row mt-5">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Rechercher un train</h5>
                        <p class="card-text">Trouvez le train idéal pour votre trajet grâce à notre réseau étendu.</p>
                        <a href="${pageContext.request.contextPath}/search" class="btn btn-outline-primary">Rechercher maintenant</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Gérer mes réservations</h5>
                        <p class="card-text">Consultez, modifiez ou annulez vos réservations en quelques clics.</p>
                        <a href="${pageContext.request.contextPath}/my-tickets" class="btn btn-outline-primary">Mes réservations</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Support client</h5>
                        <p class="card-text">Besoin d'aide ? Notre équipe de support est à votre disposition.</p>
                        <a href="#" class="btn btn-outline-primary">Nous contacter</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
