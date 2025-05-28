<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results - Train Ticket System</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <div class="container mt-5">
        <div class="card">
            <div class="card-header bg-primary text-white">
                <h4>Search Results</h4>
                <p class="mb-0">From ${departureCity} to ${arrivalCity} on ${date}</p>
            </div>
            <div class="card-body">
                <c:if test="${empty journeys}">
                    <div class="alert alert-info" role="alert">
                        No trains found for your search criteria. Please try different dates or destinations.
                    </div>
                    <a href="${pageContext.request.contextPath}/search" class="btn btn-primary">New Search</a>
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