<%@ page contentType="text/html;charset=UTF-8" %><%@ taglib prefix="c"
uri="jakarta.tags.core" %> <%@ include file="fragments/header.jsp" %>
<div class="hero p-5 rounded-4 shadow-sm">
  <div class="row align-items-center">
    <div class="col-md-7">
      <span class="badge bg-warning text-dark mb-3"
        >YOUR EVERYDAY SHOPPING STORE</span
      >
      <h1 class="display-4 fw-bold">
        Shop smarter with <span>ShopSphere.</span>
      </h1>
      <p class="lead">
        Discover a wide range of quality products across multiple categories,
        all in one place. Find your favorites, explore great options, and enjoy
        a smooth and convenient shopping experience with ShopSphere.
      </p>
      <a href="products" class="btn btn-primary btn-lg">Explore Products</a>
    </div>
    <div class="col-md-5 text-center fs-1">🛍️<br />⚡ 🧑‍💻 📦</div>
  </div>
</div>
<div class="row g-4 mt-4">
  <div class="col-md-4">
    <div class="card p-4 h-100">
      <h4>Secure Login</h4>
      <p>Session-based authentication with hashed passwords.</p>
    </div>
  </div>
  <div class="col-md-4">
    <div class="card p-4 h-100">
      <h4>Seamless Shopping Experience</h4>
      <p>
        Explore quality products with organized categories, detailed product
        information, and easy order management.
      </p>
    </div>
  </div>
  <div class="col-md-4">
    <div class="card p-4 h-100">
      <h4>Smart & Scalable Design</h4>
      <p>
        Built with Java Servlets, JDBC, and MySQL for smooth performance,
        organized code, and reliable data handling.
      </p>
    </div>
  </div>
</div>
<%@ include file="fragments/footer.jsp" %>
