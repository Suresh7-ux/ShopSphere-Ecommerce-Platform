
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="fragments/header.jsp" %>

<div class="d-flex flex-wrap justify-content-between align-items-center mb-4">
    <div>
        <h1 class="page-heading mb-1">Your Orders</h1>
        <p class="text-muted mb-0">
            Track past purchases and reorder in a click.
        </p>
    </div>

    <a href="${pageContext.request.contextPath}/products"
       class="btn btn-outline-dark">
        Continue Shopping
    </a>
</div>

<c:if test="${param.placed == '1'}">
    <div class="alert alert-success d-flex align-items-center gap-3">
        <span class="success-check">✓</span>

        <div>
            <h5 class="mb-1">Order Placed Successfully!</h5>

            <div>
                Your order number is
                <b>#<c:out value="${sessionScope.orderSuccessId}"/></b>.
                Thanks for shopping with ShopSphere.
            </div>
        </div>
    </div>

    <c:remove var="orderSuccessId" scope="session"/>
</c:if>

<c:choose>
    <c:when test="${empty orders}">
        <div class="empty-state card p-5 text-center">
            <h3>No Orders Yet</h3>

            <p class="text-muted">
                Once you place an order, it will appear here.
            </p>

            <a href="${pageContext.request.contextPath}/products"
               class="btn btn-primary mx-auto">
                Explore Products
            </a>
        </div>
    </c:when>

    <c:otherwise>
        <c:forEach var="order" items="${orders}">
            <div class="card order-card mb-4">

                <!-- Order Header -->
                <div class="order-card-head d-flex flex-wrap justify-content-between gap-3">
                    <div>
                        <div class="text-muted small">
                            ORDER #<c:out value="${order.orderId}"/>
                        </div>

                        <h5 class="mb-1">
                            Placed <c:out value="${order.createdAt}"/>
                        </h5>

                        <span class="badge text-bg-success">
                            <c:out value="${order.status}"/>
                        </span>
                    </div>

                    <div class="text-md-end">
                        <div class="text-muted small">Order Total</div>

                        <h4>
                            ₹<c:out value="${order.total}"/>
                        </h4>

                        <div class="small text-muted">
                            <c:out value="${order.paymentMethod}"/>
                            ·
                            <c:out value="${order.paymentStatus}"/>
                        </div>
                    </div>
                </div>

                <!-- Ordered Items -->
                <div class="p-3">
                    <c:forEach var="item" items="${order.items}">
                        <div class="ordered-item">
                            <img
                                src="<c:out value='${item.imageUrl}'/>"
                                alt="<c:out value='${item.name}'/>"
                            >

                            <div class="flex-grow-1">
                                <b>
                                    <c:out value="${item.name}"/>
                                </b>

                                <div class="small text-muted">
                                    Quantity:
                                    <c:out value="${item.quantity}"/>
                                </div>
                            </div>

                            <div class="fw-semibold">
                                ₹<c:out value="${item.price * item.quantity}"/>
                            </div>
                        </div>
                    </c:forEach>

                    <!-- Reorder Form -->
                    <form
                        method="post"
                        action="${pageContext.request.contextPath}/orders">

                        <input
                            type="hidden"
                            name="orderId"
                            value="${order.orderId}"
                        >

                        <button
                            class="btn btn-primary mt-3"
                            type="submit">
                            ↻ Reorder Available Items
                        </button>
                    </form>
                </div>
            </div>
        </c:forEach>
    </c:otherwise>
</c:choose>

<%@ include file="fragments/footer.jsp" %>
