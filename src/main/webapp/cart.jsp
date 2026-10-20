
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="fragments/header.jsp" %>

<c:if test="${not empty sessionScope.cartMessage}">
    <div class="alert alert-warning">
        <c:out value="${sessionScope.cartMessage}"/>
    </div>
    <c:remove var="cartMessage" scope="session"/>
</c:if>

<h2>Your Cart</h2>

<c:if test="${not empty sessionScope.reorderMessage}">
    <div class="alert alert-info mt-3">
        <c:out value="${sessionScope.reorderMessage}"/>
    </div>
    <c:remove var="reorderMessage" scope="session"/>
</c:if>

<c:choose>
    <c:when test="${empty sessionScope.cart}">
        <div class="alert alert-info mt-4">
            Your cart is empty.
            <a href="products">Continue shopping</a>.
        </div>
    </c:when>

    <c:otherwise>
        <div class="table-responsive">
            <table class="table align-middle">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Price</th>
                        <th>Qty</th>
                        <th>Subtotal</th>
                        <th></th>
                    </tr>
                </thead>

                <tbody>
                    <c:set var="total" value="0"/>

                    <c:forEach var="item"
                               items="${sessionScope.cart.values()}">

                        <c:set var="total"
                               value="${total + item.subtotal}"/>

                        <tr>
                            <td>
                                <img src="${item.product.imageUrl}"
                                     class="cart-img"
                                     alt="${item.product.name}">
                                ${item.product.name}
                            </td>

                            <td>
                                ₹${item.product.finalPrice}
                            </td>

                            <td>
                                <form method="post"
                                      action="cart"
                                      class="d-flex">

                                    <input type="hidden"
                                           name="id"
                                           value="${item.product.productId}">

                                    <input type="hidden"
                                           name="action"
                                           value="update">

                                    <input class="form-control qty"
                                           type="number"
                                           min="0"
                                           name="qty"
                                           value="${item.quantity}">

                                    <button type="submit"
                                            class="btn btn-sm btn-outline-secondary">
                                        Update
                                    </button>
                                </form>
                            </td>

                            <td>
                                ₹${item.subtotal}
                            </td>

                            <td>
                                <form method="post" action="cart">
                                    <input type="hidden"
                                           name="id"
                                           value="${item.product.productId}">

                                    <input type="hidden"
                                           name="action"
                                           value="remove">

                                    <button type="submit"
                                            class="btn btn-sm btn-outline-danger">
                                        Remove
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="card p-4 ms-auto total-card">
            <h4>Subtotal: ₹${total}</h4>

            <a class="btn btn-primary"
               href="${pageContext.request.contextPath}/checkout.jsp">
                Proceed to Checkout
            </a>
        </div>
    </c:otherwise>
</c:choose>

<%@ include file="fragments/footer.jsp" %>
