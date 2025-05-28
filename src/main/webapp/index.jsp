<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Train Ticket System - Home</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <div class="container mt-5">
        <div class="jumbotron">
            <h1 class="display-4">Welcome to Train Ticket System</h1>
            <p class="lead">Book your train tickets online with ease and convenience.</p>
            <hr class="my-4">
            <p>Search for available trains, book tickets, and manage your journeys all in one place.</p>
            <a class="btn btn-primary btn-lg" href="${pageContext.request.contextPath}/search" role="button">Search Trains</a>
        </div>
        
        <div class="row mt-5">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Search Trains</h5>
                        <p class="card-text">Find the best train for your journey by searching our extensive network.</p>
                        <a href="${pageContext.request.contextPath}/search" class="btn btn-outline-primary">Search Now</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Manage Bookings</h5>
                        <p class="card-text">View, modify or cancel your existing bookings with just a few clicks.</p>
                        <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline-primary">My Bookings</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Customer Support</h5>
                        <p class="card-text">Need help? Our customer support team is here to assist you.</p>
                        <a href="#" class="btn btn-outline-primary">Contact Us</a>
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