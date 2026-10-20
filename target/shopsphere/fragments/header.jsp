<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html><html><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>${empty pageTitle ? 'ShopSphere' : pageTitle}</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"></head><body>
<nav class="navbar navbar-expand-lg bg-dark navbar-dark"><div class="container"><a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/index.jsp">ShopSphere</a>
<div class="ms-auto"><a class="btn btn-outline-light btn-sm me-2" href="${pageContext.request.contextPath}/products">Shop</a>
<a class="btn btn-warning btn-sm me-2" href="${pageContext.request.contextPath}/cart">Cart 🛒</a>
<c:if test="${not empty sessionScope.user}"><a class="btn btn-outline-light btn-sm me-2" href="${pageContext.request.contextPath}/orders">Orders</a></c:if>
<c:choose><c:when test="${not empty sessionScope.user}"><span class="text-white me-2">Hi, ${sessionScope.user.name}</span><a class="btn btn-outline-light btn-sm" href="${pageContext.request.contextPath}/logout">Logout</a></c:when>
<c:otherwise><a class="btn btn-light btn-sm" href="${pageContext.request.contextPath}/login.jsp">Login</a></c:otherwise></c:choose></div></div></nav>
<main class="container py-4">
