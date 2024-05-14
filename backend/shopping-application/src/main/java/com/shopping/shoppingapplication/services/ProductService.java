package com.shopping.shoppingapplication.services;

import com.shopping.shoppingapplication.models.Product;
import com.shopping.shoppingapplication.models.ProductItem;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface ProductService {

    void addNewProducts(List<Product> products);

    Product getProductById(String productId);

    List<String> getProductSuggestions(String query);

}
