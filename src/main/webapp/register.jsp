
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="fragments/header.jsp" %>

<div class="auth-card card shadow-sm p-4 mx-auto">
    <h2>Create Account</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            <c:out value="${error}" />
        </div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/register">
        <input
            class="form-control mb-3"
            type="text"
            name="name"
            placeholder="Full name"
            required
        >

        <input
            class="form-control mb-3"
            type="email"
            name="email"
            placeholder="Email"
            required
        >

        <input
            class="form-control mb-3"
            type="tel"
            name="mobile"
            placeholder="Mobile"
        >

        <input
            class="form-control mb-3"
            type="password"
            name="password"
            placeholder="Password"
            minlength="6"
            required
        >

        <button class="btn btn-primary w-100" type="submit">
            Register
        </button>
    </form>
</div>

<%@ include file="fragments/footer.jsp" %>
