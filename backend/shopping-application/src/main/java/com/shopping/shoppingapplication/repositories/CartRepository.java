package com.shopping.shoppingapplication.repositories;

import com.shopping.shoppingapplication.models.Cart;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface CartRepository extends MongoRepository<Cart, String> {
}
