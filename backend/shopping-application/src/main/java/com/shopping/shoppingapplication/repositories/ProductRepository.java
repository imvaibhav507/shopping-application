package com.shopping.shoppingapplication.repositories;

import com.shopping.shoppingapplication.models.Category;
import com.shopping.shoppingapplication.models.Product;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;


public interface ProductRepository extends MongoRepository<Product, String> {

    List<Product> findProductsByNameIsLikeIgnoreCaseOrBrandIsLikeIgnoreCase(String name, String brand);
}
