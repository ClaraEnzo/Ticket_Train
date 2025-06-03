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
                
                <!-- Messages -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${error}
                        <button type="button" class="close" data-dismiss="alert">
                            <span>&times;</span>
                        </button>
                    </div>
                </c:if>
                
                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${success}
                        <button type="button" class="close" data-dismiss="alert">
                            <span>&times;</span>
                        </button>
                    </div>
                </c:if>
                
                <!-- Table des utilisateurs -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">Liste des Utilisateurs</h6>
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
                                                <div class="btn-group" role="group">
                                                    <button type="button" class="btn btn-sm btn-outline-primary" 
                                                            onclick="editUser(${user.userId}, '${user.email}', '${user.firstName}', '${user.lastName}', '${user.role}')"
                                                            data-toggle="modal" data-target="#editUserModal">
                                                        <i class="fas fa-edit"></i>
                                                    </button>
                                                    <button type="button" class="btn btn-sm btn-outline-${user.active ? 'warning' : 'success'}" 
                                                            onclick="toggleUserStatus(${user.userId})">
                                                        <i class="fas fa-${user.active ? 'ban' : 'check'}"></i>
                                                    </button>
                                                    <c:if test="${user.role != 'ADMIN' || adminCount > 1}">
                                                        <button type="button" class="btn btn-sm btn-outline-danger" 
                                                                onclick="deleteUser(${user.userId}, '${user.username}')">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </c:if>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
    <!-- Modal Créer Utilisateur -->
    <div class="modal fade" id="createUserModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Créer un Nouvel Utilisateur</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span>&times;</span>
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
    
    <!-- Modal Modifier Utilisateur -->
    <div class="modal fade" id="editUserModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Modifier l'Utilisateur</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span>&times;</span>
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
    
    <!-- Formulaires cachés pour actions -->
    <form id="toggleStatusForm" action="${pageContext.request.contextPath}/admin/users" method="post" style="display: none;">
        <input type="hidden" name="action" value="toggleStatus">
        <input type="hidden" id="toggleUserId" name="userId">
    </form>
    
    <form id="deleteForm" action="${pageContext.request.contextPath}/admin/users" method="get" style="display: none;">
        <input type="hidden" name="action" value="delete">
        <input type="hidden" id="deleteUserId" name="id">
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