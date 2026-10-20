package com.shopsphere.service;

import java.util.List;

import com.shopsphere.dao.ProductDAO;
import com.shopsphere.model.Product;

public class ProductService {
    private final ProductDAO dao = new ProductDAO();

    public List<Product> list(String q) throws Exception {
        return dao.all(q);
    }

    public List<Product> list(String q, int categoryId, double minPrice,
            double maxPrice, String sort) throws Exception {
        return dao.all(q, categoryId, minPrice, maxPrice, sort);
    }

    public Product get(int id) throws Exception {
        return dao.find(id);
    }
}
