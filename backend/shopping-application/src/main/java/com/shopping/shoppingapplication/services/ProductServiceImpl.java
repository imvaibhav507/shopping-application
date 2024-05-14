package com.shopping.shoppingapplication.services;

import com.shopping.shoppingapplication.models.Category;
import com.shopping.shoppingapplication.models.Product;
import com.shopping.shoppingapplication.repositories.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Service
public class ProductServiceImpl implements ProductService{

    @Autowired
    private ProductRepository productRepository;
    @Override
    public void addNewProducts(List<Product> products) {

        productRepository.insert(products);
    }

    @Override
    public Product getProductById(String id) {
        return productRepository.findById(id).orElse(null);
    }

    @Override
    public List<String> getProductSuggestions(String query) {
        List<Product> fetchedProducts = productRepository
                .findProductsByNameIsLikeIgnoreCaseOrBrandIsLikeIgnoreCase(query, query);

        return fetchedProducts.stream().map(Product::getName).toList();
    }

}
