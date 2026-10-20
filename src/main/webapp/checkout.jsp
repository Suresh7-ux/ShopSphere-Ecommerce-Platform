<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="fragments/header.jsp" %>
<h1 class="page-heading mb-4">Secure checkout</h1>
<c:if test="${not empty sessionScope.checkoutError}"><div class="alert alert-danger"><c:out value="${sessionScope.checkoutError}"/></div><c:remove var="checkoutError" scope="session"/></c:if>
<c:choose>
<c:when test="${empty sessionScope.cart}"><div class="alert alert-info">Your cart is empty. <a href="${pageContext.request.contextPath}/products">Continue shopping</a>.</div></c:when>
<c:otherwise>
<form method="post" action="${pageContext.request.contextPath}/checkout" class="row g-4">
 <div class="col-lg-7"><div class="card p-4 checkout-panel"><h4 class="mb-3">Delivery details</h4>
 <label class="form-label" for="addressLine">Address</label><input id="addressLine" name="addressLine" class="form-control mb-3" maxlength="255" required placeholder="House number, street, area">
 <div class="row g-3"><div class="col-md-6"><label class="form-label" for="city">City</label><input id="city" name="city" class="form-control" required maxlength="80"></div><div class="col-md-6"><label class="form-label" for="state">State</label><input id="state" name="state" class="form-control" required maxlength="80"></div><div class="col-md-6"><label class="form-label" for="pincode">Pincode</label><input id="pincode" name="pincode" class="form-control" required pattern="[0-9]{5,10}" minlength="5" maxlength="10" inputmode="numeric"></div></div>
 <h4 class="mt-4 mb-3">Payment method</h4><div class="payment-option"><input type="radio" name="paymentMethod" id="cod" value="COD" checked><label for="cod">Cash on Delivery <span>Pay when your order arrives</span></label></div><div class="payment-option"><input type="radio" name="paymentMethod" id="upi" value="UPI_DEMO"><label for="upi">Demo UPI <span>Demo only — no real payment is taken</span></label></div><div class="payment-option"><input type="radio" name="paymentMethod" id="card" value="CARD_DEMO"><label for="card">Demo Card <span>Demo only — no real payment is taken</span></label></div>
 <button class="btn btn-success btn-lg w-100 mt-4" type="submit">Place order securely</button><p class="small text-muted mt-2 mb-0">This college project uses demo payment statuses and does not process real payments.</p></div></div>
 <div class="col-lg-5"><div class="card p-4 order-summary"><h4>Order summary</h4><c:set var="total" value="0"/><c:forEach var="item" items="${sessionScope.cart.values()}"><div class="summary-item"><img src="<c:out value='${item.product.imageUrl}'/>" alt=""><div class="flex-grow-1"><b><c:out value="${item.product.name}"/></b><div class="text-muted small">Qty: ${item.quantity}</div></div><b>₹<c:out value="${item.subtotal}"/></b></div><c:set var="total" value="${total + item.subtotal}"/></c:forEach><hr><div class="d-flex justify-content-between fs-5"><b>Total</b><b>₹<c:out value="${total}"/></b></div></div></div>
</form></c:otherwise></c:choose>
<%@ include file="fragments/footer.jsp" %>
