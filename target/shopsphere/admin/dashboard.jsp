
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="../fragments/header.jsp" %>

<h2>Admin Dashboard</h2>

<div class="row g-4 mt-2">

    <div class="col-md-3">
        <div class="stat card p-4">
            <small>Products</small>
            <h2>5</h2>
        </div>
    </div>

    <div class="col-md-3">
        <div class="stat card p-4">
            <small>Orders</small>
            <h2>—</h2>
        </div>
    </div>

    <div class="col-md-3">
        <div class="stat card p-4">
            <small>Customers</small>
            <h2>—</h2>
        </div>
    </div>

    <div class="col-md-3">
        <div class="stat card p-4">
            <small>Low Stock</small>
            <h2>—</h2>
        </div>
    </div>

</div>

<div class="card p-4 mt-4">
    <h5>Admin Modules</h5>

    <p>
        Product CRUD • Category CRUD • Inventory •
        Customers • Orders • Coupons
    </p>
</div>

<%@ include file="../fragments/footer.jsp" %>
