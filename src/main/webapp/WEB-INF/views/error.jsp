<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Erreur - Train Ticket System</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card border-danger">
                    <div class="card-header bg-danger text-white">
                        <h4>Une erreur s'est produite</h4>
                    </div>
                    <div class="card-body">
                        <div class="alert alert-danger">
                            <h5>Désolé, une erreur inattendue s'est produite.</h5>
                            <c:if test="${not empty errorMessage}">
                                <p><strong>Message :</strong> ${errorMessage}</p>
                            </c:if>
                        </div>
                        
                        <div class="mt-4">
                            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                                Retour à l'accueil
                            </a>
                            <a href="javascript:history.back()" class="btn btn-secondary">
                                Page précédente
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>