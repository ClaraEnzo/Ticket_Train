<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription - Train Ticket System</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header bg-success text-white">
                        <h4><i class="fas fa-user-plus"></i> Créer un compte</h4>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                <i class="fas fa-exclamation-triangle"></i> ${error}
                            </div>
                        </c:if>
                        
                        <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm">
                            <div class="form-group">
                                <label for="username">Nom d'utilisateur *</label>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                                    </div>
                                    <input type="text" class="form-control" id="username" name="username" 
                                           value="${param.username}" required minlength="3" maxlength="50">
                                </div>
                                <small class="form-text text-muted">3-50 caractères, lettres et chiffres uniquement</small>
                            </div>
                            
                            <div class="form-group">
                                <label for="fullName">Nom complet *</label>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"><i class="fas fa-id-card"></i></span>
                                    </div>
                                    <input type="text" class="form-control" id="fullName" name="fullName" 
                                           value="${param.fullName}" required maxlength="100">
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label for="email">Adresse email *</label>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                    </div>
                                    <input type="email" class="form-control" id="email" name="email" 
                                           value="${param.email}" required maxlength="100">
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label for="phone">Téléphone</label>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                    </div>
                                    <input type="tel" class="form-control" id="phone" name="phone" 
                                           value="${param.phone}" maxlength="20">
                                </div>
                                <small class="form-text text-muted">Optionnel</small>
                            </div>
                            
                            <div class="form-group">
                                <label for="password">Mot de passe *</label>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                    </div>
                                    <input type="password" class="form-control" id="password" name="password" 
                                           required minlength="6">
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                </div>
                                <small class="form-text text-muted">Au moins 6 caractères</small>
                            </div>
                            
                            <div class="form-group">
                                <label for="confirmPassword">Confirmer le mot de passe *</label>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                    </div>
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" 
                                           required minlength="6">
                                </div>
                                <div id="passwordMatch" class="form-text"></div>
                            </div>
                            
                            <div class="form-group form-check">
                                <input type="checkbox" class="form-check-input" id="agreeTerms" required>
                                <label class="form-check-label" for="agreeTerms">
                                    J'accepte les <a href="#" target="_blank">conditions d'utilisation</a> *
                                </label>
                            </div>
                            
                            <button type="submit" class="btn btn-success btn-block" id="submitBtn">
                                <i class="fas fa-user-plus"></i> Créer mon compte
                            </button>
                        </form>
                        
                        <div class="text-center mt-3">
                            <p>Vous avez déjà un compte ? 
                                <a href="${pageContext.request.contextPath}/login">Connectez-vous ici</a>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <script>
        // Toggle password visibility
        document.getElementById('togglePassword').addEventListener('click', function() {
            const password = document.getElementById('password');
            const icon = this.querySelector('i');
            
            if (password.type === 'password') {
                password.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                password.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });
        
        // Password confirmation validation
        function checkPasswordMatch() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const matchDiv = document.getElementById('passwordMatch');
            const submitBtn = document.getElementById('submitBtn');
            
            if (confirmPassword === '') {
                matchDiv.innerHTML = '';
                matchDiv.className = 'form-text';
                return;
            }
            
            if (password === confirmPassword) {
                matchDiv.innerHTML = '<i class="fas fa-check text-success"></i> Les mots de passe correspondent';
                matchDiv.className = 'form-text text-success';
                submitBtn.disabled = false;
            } else {
                matchDiv.innerHTML = '<i class="fas fa-times text-danger"></i> Les mots de passe ne correspondent pas';
                matchDiv.className = 'form-text text-danger';
                submitBtn.disabled = true;
            }
        }
        
        document.getElementById('password').addEventListener('input', checkPasswordMatch);
        document.getElementById('confirmPassword').addEventListener('input', checkPasswordMatch);
        
        // Username validation
        document.getElementById('username').addEventListener('input', function() {
            const username = this.value;
            const regex = /^[a-zA-Z0-9]+$/;
            
            if (username && !regex.test(username)) {
                this.setCustomValidity('Le nom d\'utilisateur ne peut contenir que des lettres et des chiffres');
            } else {
                this.setCustomValidity('');
            }
        });
        
        // Form submission validation
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Les mots de passe ne correspondent pas');
                return false;
            }
        });
    </script>
</body>
</html>