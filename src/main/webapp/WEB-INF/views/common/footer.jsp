<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    .footer {
        background: linear-gradient(135deg, #2c3e50, #34495e);
        color: #ecf0f1;
        padding: 3rem 0 1.5rem;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        box-shadow: 0 -5px 20px rgba(0, 0, 0, 0.1);
        margin-top:100px;
    }
    
    .footer h5 {
        font-weight: 600;
        margin-bottom: 1.2rem;
        position: relative;
        display: inline-block;
    }
    
    .footer h5::after {
        content: '';
        position: absolute;
        left: 0;
        bottom: -8px;
        width: 50px;
        height: 3px;
        background: #3498db;
        border-radius: 3px;
    }
    
    .footer p {
        color: #bdc3c7;
        line-height: 1.6;
    }
    
    .footer-links {
        list-style: none;
        padding: 0;
    }
    
    .footer-links li {
        margin-bottom: 0.5rem;
    }
    
    .footer-links a {
        color: #bdc3c7;
        text-decoration: none;
        transition: all 0.3s ease;
        display: inline-block;
    }
    
    .footer-links a:hover {
        color: #3498db;
        transform: translateX(5px);
    }
    
    .footer-divider {
        border-color: rgba(255, 255, 255, 0.1);
        margin: 2rem 0;
    }
    
    .footer-bottom {
        background: rgba(0, 0, 0, 0.2);
        padding: 1rem 0;
        margin-top: 2rem;
    }
    
    .social-icons {
        display: flex;
        gap: 1rem;
        margin-top: 1.5rem;
    }
    
    .social-icons a {
        color: #ecf0f1;
        background: rgba(255, 255, 255, 0.1);
        width: 40px;
        height: 40px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: all 0.3s ease;
    }
    
    .social-icons a:hover {
        background: #3498db;
        transform: translateY(-3px);
    }
    
    .contact-item {
        display: flex;
        align-items: center;
        margin-bottom: 1rem;
    }
    
    .contact-item i {
        width: 20px;
        margin-right: 10px;
        color: #3498db;
    }
</style>

<footer class="footer">
    <div class="container">
        <div class="row">
            <div class="col-lg-4 mb-4">
                <h5><i class="fas fa-train me-2"></i>RailExpress</h5>
                <p>Votre partenaire de confiance pour voyager en toute sérénité à travers la Tunisie.</p>
                
            </div>
            
            <div class="col-lg-4 mb-4">
                <h5>Liens rapides</h5>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/"><i class="fas fa-chevron-right me-2"></i>Accueil</a></li>
                    <li><a href="${pageContext.request.contextPath}/search"><i class="fas fa-chevron-right me-2"></i>Rechercher un train</a></li>
                    <li><a href="${pageContext.request.contextPath}/my-tickets"><i class="fas fa-chevron-right me-2"></i>Mes billets</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact"><i class="fas fa-chevron-right me-2"></i>Contactez-nous</a></li>
                </ul>
            </div>
            
            <div class="col-lg-4 mb-4">
                <h5>Contact</h5>
                <div class="contact-item">
                    <i class="fas fa-map-marker-alt"></i>
                    <p>123 Avenue Habib Bourguiba, Tunis 1000</p>
                </div>
                <div class="contact-item">
                    <i class="fas fa-phone-alt"></i>
                    <p>+216 20 125 678</p>
                </div>
                <div class="contact-item">
                    <i class="fas fa-envelope"></i>
                    <p>contact@railexpress.tn</p>
                </div>
                <div class="contact-item">
                    <i class="fas fa-clock"></i>
                    <p>Lun-Ven: 8h-20h | Sam: 9h-17h</p>
                </div>
            </div>
        </div>
        
        
    </div>
</footer>