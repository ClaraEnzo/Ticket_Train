<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Utilisateurs - Admin</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .table-actions .btn {
            margin-right: 5px; /* Add some space between buttons */
        }
        .table-actions .btn:last-child {
            margin-right: 0;
        }
        /* Custom styles for sidebar and main content if needed */
        body {
            display: flex;
            min-height: 100vh;
            flex-direction: column;
        }
        .wrapper {
            flex: 1;
            display: flex;
        }
        main {
            padding-top: 20px; /* Adjust padding for fixed header */
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/admin-header.jsp" />

    <div class="container-fluid mt-4">
        <div class="row">
            <jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />

            <main class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2"><i class="fas fa-users"></i> Gestion des Utilisateurs</h1>
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createUserModal">
                        <i class="fas fa-plus"></i> Nouvel Utilisateur
                    </button>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${error}
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </c:if>

                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${success}
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </c:if>

                <div class="card shadow mb-4">
                    <div class="card-header py-3 d-flex justify-content-between align-items-center">
                        <h6 class="m-0 font-weight-bold text-primary">Liste des Utilisateurs</h6>
                        <div class="col-md-6 text-right"> <%-- Align search to the right --%>
                            <form action="${pageContext.request.contextPath}/admin/users" method="get" class="form-inline my-2 my-lg-0 justify-content-end">
                                <div class="input-group">
                                    <input type="text" name="search" class="form-control" placeholder="Rechercher..." value="${param.search != null ? param.search : ''}">
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-secondary" type="submit">
                                            <i class="fas fa-search"></i>
                                        </button>
                                        <c:if test="${not empty param.search}">
                                            <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline-danger" title="Effacer la recherche">
                                                <i class="fas fa-times"></i>
                                            </a>
                                        </c:if>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Nom d'utilisateur</th>
                                        <th>Nom complet</th>
                                        <th>Email</th>
                                        <th>Rôle</th>
                                        <th>Statut</th>
                                        <th>Date création</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty users}">
                                            <c:forEach var="user" items="${users}">
                                                <tr>
                                                    <td>${user.userId}</td>
                                                    <td>${user.username}</td>
                                                    <td>${user.firstName} ${user.lastName}</td>
                                                    <td>${user.email}</td>
                                                    <td>
                                                        <span class="badge badge-${user.role == 'ADMIN' ? 'danger' : user.role == 'EMPLOYEE' ? 'warning' : 'primary'}">
                                                            ${user.role}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <span class="badge badge-${user.active ? 'success' : 'secondary'}">
                                                            ${user.active ? 'Actif' : 'Inactif'}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                                    </td>
                                                    <td>
                                                        <div class="btn-group table-actions" role="group">
                                                            <button type="button" class="btn btn-sm btn-outline-primary"
                                                                    onclick="editUser(${user.userId}, '${user.email}', '${user.firstName}', '${user.lastName}', '${user.role}')"
                                                                    data-toggle="modal" data-target="#editUserModal" title="Modifier">
                                                                <i class="fas fa-edit"></i>
                                                            </button>
                                                            <button type="button" class="btn btn-sm btn-outline-${user.active ? 'warning' : 'success'}"
                                                                    onclick="toggleUserStatus(${user.userId})" title="${user.active ? 'Désactiver' : 'Activer'}">
                                                                <i class="fas fa-${user.active ? 'ban' : 'check'}"></i>
                                                            </button>
                                                            <%-- The 'adminCount' attribute must be set in the servlet for this logic --%>
                                                            <c:if test="${user.role != 'ADMIN' || adminCount > 1}">
                                                                <button type="button" class="btn btn-sm btn-outline-danger"
                                                                        onclick="deleteUser(${user.userId}, '${user.username}')" title="Supprimer">
                                                                    <i class="fas fa-trash"></i>
                                                                </button>
                                                            </c:if>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="8" class="text-center">Aucun utilisateur trouvé.</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>

                        <nav aria-label="Page navigation">
                            <ul class="pagination justify-content-center">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${currentPage-1}${not empty param.search ? '&search=' : ''}${param.search}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                </c:if>

                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${i}${not empty param.search ? '&search=' : ''}${param.search}">${i}</a>
                                    </li>
                                </c:forEach>

                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${currentPage+1}${not empty param.search ? '&search=' : ''}${param.search}" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <div class="modal fade" id="createUserModal" tabindex="-1" role="dialog" aria-labelledby="createUserModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="createUserModalLabel">Créer un Nouvel Utilisateur</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form action="${pageContext.request.contextPath}/admin/users" method="post">
                    <input type="hidden" name="action" value="create">
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="username">Nom d'utilisateur</label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                        <div class="form-group">
                            <label for="password">Mot de passe</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="firstName">Prénom</label>
                                <input type="text" class="form-control" id="firstName" name="firstName" required>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="lastName">Nom</label>
                                <input type="text" class="form-control" id="lastName" name="lastName" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="form-group">
                            <label for="role">Rôle</label>
                            <select class="form-control" id="role" name="role" required>
                                <option value="USER">Utilisateur</option>
                                <option value="EMPLOYEE">Employé</option>
                                <option value="ADMIN">Administrateur</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>
                        <button type="submit" class="btn btn-primary">Créer</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal fade" id="editUserModal" tabindex="-1" role="dialog" aria-labelledby="editUserModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editUserModalLabel">Modifier l'Utilisateur</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form action="${pageContext.request.contextPath}/admin/users" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" id="editUserId" name="userId">
                    <div class="modal-body">
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="editFirstName">Prénom</label>
                                <input type="text" class="form-control" id="editFirstName" name="firstName" required>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="editLastName">Nom</label>
                                <input type="text" class="form-control" id="editLastName" name="lastName" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="editEmail">Email</label>
                            <input type="email" class="form-control" id="editEmail" name="email" required>
                        </div>
                        <div class="form-group">
                            <label for="editRole">Rôle</label>
                            <select class="form-control" id="editRole" name="role" required>
                                <option value="USER">Utilisateur</option>
                                <option value="EMPLOYEE">Employé</option>
                                <option value="ADMIN">Administrateur</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>
                        <button type="submit" class="btn btn-primary">Modifier</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <form id="toggleStatusForm" action="${pageContext.request.contextPath}/admin/users" method="post" style="display: none;">
        <input type="hidden" name="action" value="toggleStatus">
        <input type="hidden" id="toggleUserId" name="userId">
    </form>

    <form id="deleteForm" action="${pageContext.request.contextPath}/admin/users" method="post" style="display: none;">
        <input type="hidden" name="action" value="delete">
        <input type="hidden" id="deleteUserId" name="userId">
    </form>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        function editUser(userId, email, firstName, lastName, role) {
            document.getElementById('editUserId').value = userId;
            document.getElementById('editEmail').value = email;
            document.getElementById('editFirstName').value = firstName;
            document.getElementById('editLastName').value = lastName;
            document.getElementById('editRole').value = role;
        }

        function toggleUserStatus(userId) {
            if (confirm('Êtes-vous sûr de vouloir changer le statut de cet utilisateur ?')) {
                document.getElementById('toggleUserId').value = userId;
                document.getElementById('toggleStatusForm').submit();
            }
        }

        function deleteUser(userId, username) {
            if (confirm('Êtes-vous sûr de vouloir supprimer l\'utilisateur "' + username + '" ? Cette action est irréversible.')) {
                document.getElementById('deleteUserId').value = userId;
                document.getElementById('deleteForm').submit();
            }
        }
    </script>
</body>
</html>