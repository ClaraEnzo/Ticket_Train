<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mon Profil - Train Ticket System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --accent-color: #4cc9f0;
            --light-bg: #f8f9fa;
            --card-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        }
        
        body {
            background-color: var(--light-bg);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: var(--card-shadow);
            transition: transform 0.3s ease;
            margin-bottom: 20px;
        }
        
        .card:hover {
            transform: translateY(-5px);
        }
        
        .card-header {
            border-radius: 12px 12px 0 0 !important;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            font-weight: 600;
            padding: 15px 20px;
        }
        
        .list-group-item {
            border-left: 0;
            border-right: 0;
            padding: 12px 20px;
            color: #495057;
            transition: all 0.3s ease;
        }
        
        .list-group-item:first-child {
            border-top: 0;
        }
        
        .list-group-item:hover {
            background-color: rgba(67, 97, 238, 0.1);
            color: var(--primary-color);
            padding-left: 25px;
        }
        
        .list-group-item.active {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .list-group-item i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }
        
        .form-control {
            border-radius: 8px;
            padding: 12px 15px;
            border: 1px solid #e0e0e0;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            border-color: var(--accent-color);
            box-shadow: 0 0 0 0.25rem rgba(76, 201, 240, 0.25);
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s;
        }
        
        .btn-primary:hover {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
            transform: translateY(-2px);
        }
        
        .btn-warning {
            background-color: #ffaa00;
            border-color: #ffaa00;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s;
        }
        
        .btn-warning:hover {
            background-color: #e69500;
            border-color: #e69500;
            color: white;
            transform: translateY(-2px);
        }
        
        .tab-content {
            animation: fadeIn 0.5s ease;
        }
        
        .profile-icon {
            font-size: 1.2rem;
            margin-right: 8px;
        }
        
        .alert {
            border-radius: 8px;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .input-group-text {
            background-color: #f8f9fa;
        }
        
        .section-title {
            position: relative;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }
        
        .section-title:after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 50px;
            height: 3px;
            background: linear-gradient(to right, var(--primary-color), var(--accent-color));
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <div class="container py-4">
        <div class="row">
            <div class="col-lg-3">
                <!-- Sidebar -->
                <div class="card animate__animated animate__fadeInLeft">
                    <div class="card-header">
                        <h6 class="mb-0"><i class="fas fa-user-circle me-2"></i>Mon Compte</h6>
                    </div>
                    <div class="list-group list-group-flush">
                        <a href="#profile-info" class="list-group-item list-group-item-action active" data-bs-toggle="tab">
                            <i class="fas fa-user-circle profile-icon"></i> Informations personnelles
                        </a>
                        <a href="#change-password" class="list-group-item list-group-item-action" data-bs-toggle="tab">
                            <i class="fas fa-key profile-icon"></i> Changer le mot de passe
                        </a>
                        <a href="${pageContext.request.contextPath}/dashboard" class="list-group-item list-group-item-action">
                            <i class="fas fa-tachometer-alt profile-icon"></i> Tableau de bord
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-9">
                <!-- Messages -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show animate__animated animate__shakeX" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                
                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show animate__animated animate__fadeIn" role="alert">
                        <i class="fas fa-check-circle me-2"></i>${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                
                <!-- Tab Content -->
                <div class="tab-content">
                    <!-- Profile Information Tab -->
                    <div class="tab-pane fade show active" id="profile-info">
                        <div class="card animate__animated animate__fadeIn">
                            <div class="card-header">
                                <h5 class="mb-0"><i class="fas fa-user-edit me-2"></i>Modifier mes informations</h5>
                            </div>
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath}/profile" method="post">
                                    <input type="hidden" name="action" value="updateProfile">
                                    
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="username" class="form-label">Nom d'utilisateur *</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                                                <input type="text" class="form-control" id="username" name="username" 
                                                       value="${user.username}" required>
                                            </div>
                                        </div>
                                        
                                        <div class="col-md-6 mb-3">
                                            <label for="fullName" class="form-label">Nom complet *</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="fas fa-id-card"></i></span>
                                                <input type="text" class="form-control" id="fullName" name="fullName" 
                                                       value="${user.fullName}" required>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="email" class="form-label">Email *</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                                <input type="email" class="form-control" id="email" name="email" 
                                                       value="${user.email}" required>
                                            </div>
                                        </div>
                                        
                                        <div class="col-md-6 mb-3">
                                            <label for="phone" class="form-label">Téléphone</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                                <input type="text" class="form-control" id="phone" name="phone" 
                                                       value="${user.phone}">
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Rôle</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="fas fa-user-tag"></i></span>
                                                <input type="text" class="form-control" value="${user.role}" readonly>
                                            </div>
                                            <small class="text-muted">Le rôle ne peut pas être modifié</small>
                                        </div>
                                        
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Membre depuis</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="fas fa-calendar-alt"></i></span>
                                                <input type="text" class="form-control" 
                                                       value="<fmt:formatDate value='${user.createdAt}' pattern='dd/MM/yyyy' />" readonly>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save me-2"></i> Enregistrer les modifications
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Change Password Tab -->
                    <div class="tab-pane fade" id="change-password">
                        <div class="card animate__animated animate__fadeIn">
                            <div class="card-header">
                                <h5 class="mb-0"><i class="fas fa-key me-2"></i>Changer le mot de passe</h5>
                            </div>
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath}/profile" method="post">
                                    <input type="hidden" name="action" value="changePassword">
                                    
                                    <div class="mb-3">
                                        <label for="currentPassword" class="form-label">Mot de passe actuel *</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                            <input type="password" class="form-control" id="currentPassword" 
                                                   name="currentPassword" required>
                                            <button class="btn btn-outline-secondary toggle-password" type="button">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="newPassword" class="form-label">Nouveau mot de passe *</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-key"></i></span>
                                            <input type="password" class="form-control" id="newPassword" 
                                                   name="newPassword" required minlength="6">
                                            <button class="btn btn-outline-secondary toggle-password" type="button">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                        </div>
                                        <div class="password-strength mt-2">
                                            <div class="progress" style="height: 5px;">
                                                <div class="progress-bar" role="progressbar" style="width: 0%"></div>
                                            </div>
                                            <small class="text-muted">Le mot de passe doit contenir au moins 6 caractères</small>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-4">
                                        <label for="confirmPassword" class="form-label">Confirmer le nouveau mot de passe *</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-key"></i></span>
                                            <input type="password" class="form-control" id="confirmPassword" 
                                                   name="confirmPassword" required minlength="6">
                                            <button class="btn btn-outline-secondary toggle-password" type="button">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                        </div>
                                        <div class="password-match mt-1"></div>
                                    </div>
                                    
                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                        <button type="submit" class="btn btn-warning">
                                            <i class="fas fa-key me-2"></i> Changer le mot de passe
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/zxcvbn/4.4.2/zxcvbn.js"></script>
    
    <script>
        // Toggle password visibility
        document.querySelectorAll('.toggle-password').forEach(button => {
            button.addEventListener('click', function() {
                const input = this.parentElement.querySelector('input');
                const icon = this.querySelector('i');
                
                if (input.type === 'password') {
                    input.type = 'text';
                    icon.classList.remove('fa-eye');
                    icon.classList.add('fa-eye-slash');
                } else {
                    input.type = 'password';
                    icon.classList.remove('fa-eye-slash');
                    icon.classList.add('fa-eye');
                }
            });
        });
        
        // Password strength indicator
        document.getElementById('newPassword').addEventListener('input', function() {
            const password = this.value;
            const result = zxcvbn(password);
            const progressBar = this.parentElement.parentElement.querySelector('.progress-bar');
            
            let width = 0;
            let color = '';
            
            switch(result.score) {
                case 0:
                case 1:
                    width = 25;
                    color = 'bg-danger';
                    break;
                case 2:
                    width = 50;
                    color = 'bg-warning';
                    break;
                case 3:
                    width = 75;
                    color = 'bg-info';
                    break;
                case 4:
                    width = 100;
                    color = 'bg-success';
                    break;
            }
            
            progressBar.style.width = width + '%';
            progressBar.className = 'progress-bar ' + color;
        });
        
        // Password confirmation check
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = this.value;
            const matchDiv = this.parentElement.parentElement.querySelector('.password-match');
            
            if (confirmPassword.length === 0) {
                matchDiv.innerHTML = '';
                this.setCustomValidity('');
            } else if (newPassword !== confirmPassword) {
                matchDiv.innerHTML = '<small class="text-danger"><i class="fas fa-times-circle"></i> Les mots de passe ne correspondent pas</small>';
                this.setCustomValidity('Les mots de passe ne correspondent pas');
            } else {
                matchDiv.innerHTML = '<small class="text-success"><i class="fas fa-check-circle"></i> Les mots de passe correspondent</small>';
                this.setCustomValidity('');
            }
        });
        
        // Initialize tooltips
        const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
    </script>
</body>
</html>