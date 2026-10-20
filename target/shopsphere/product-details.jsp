
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="fragments/header.jsp" %>

<c:choose>
    <c:when test="${empty product}">
        <div class="alert alert-warning">
            This product could not be found.
            <a href="${pageContext.request.contextPath}/products">
                Back to shop
            </a>
        </div>
    </c:when>

    <c:otherwise>

        <!-- Breadcrumb Navigation -->
        <nav aria-label="breadcrumb" class="mb-4">
            <a
                href="${pageContext.request.contextPath}/products"
                class="text-decoration-none">
                Shop
            </a>

            /
            <span class="text-muted">
                <c:out value="${product.name}"/>
            </span>
        </nav>

        <div class="row g-4 align-items-center product-detail-layout">

            <!-- Product Image -->
            <div class="col-lg-6">
                <div class="detail-image-wrap">
                    <img
                        class="detail-img"
                        src="${product.imageUrl}"
                        alt="${product.name}"
                    >
                </div>
            </div>

            <!-- Product Information -->
            <div class="col-lg-6 detail-copy">

                <span class="badge rounded-pill text-bg-success mb-3">
                    <c:out value="${product.discount}"/>% OFF
                </span>

                <p class="text-uppercase small text-muted mb-2">
                    <c:out value="${product.brand}"/>
                </p>

                <h1 class="display-6 fw-bold">
                    <c:out value="${product.name}"/>
                </h1>

                <!-- Pricing -->
                <div class="d-flex align-items-center gap-3 my-3">
                    <span class="display-6 fw-bold">
                        ₹<c:out value="${product.finalPrice}"/>
                    </span>

                    <del class="text-muted fs-5">
                        ₹<c:out value="${product.price}"/>
                    </del>
                </div>

                <!-- Description -->
                <p class="lead detail-description">
                    <c:out value="${product.description}"/>
                </p>

                <!-- Stock Status -->
                <div class="stock-note mb-4">
                    <span class="stock-dot"></span>

                    <c:choose>
                        <c:when test="${product.stock > 0}">
                            In stock ·
                            <c:out value="${product.stock}"/>
                            available
                        </c:when>

                        <c:otherwise>
                            Currently out of stock
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Cart Actions -->
                <c:if test="${product.stock > 0}">
                    <form
                        method="post"
                        action="${pageContext.request.contextPath}/cart"
                        class="d-flex flex-wrap gap-2">

                        <input
                            type="hidden"
                            name="id"
                            value="${product.productId}"
                        >

                        <button
                            class="btn btn-primary btn-lg px-4"
                            type="submit">
                            Add to Cart
                        </button>

                        <a
                            class="btn btn-outline-dark btn-lg"
                            href="${pageContext.request.contextPath}/cart">
                            View Cart
                        </a>
                    </form>
                </c:if>

                <!-- Shopping Benefits -->
                <div class="detail-benefits mt-4">
                    <div>✓ Secure checkout</div>
                    <div>✓ Easy order history and reorder</div>
                    <div>✓ Clear product pricing</div>
                </div>

            </div>
        </div>

    </c:otherwise>
</c:choose>

<%@ include file="fragments/footer.jsp" %>
