package com.shopping.shoppingapplication.repositories;

import com.shopping.shoppingapplication.models.ProductItem;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface ProductItemRepository extends MongoRepository<ProductItem, String> {
}
