package com.shopping.shoppingapplication.repositories;

import com.shopping.shoppingapplication.models.OrderLine;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface OrderRepository extends MongoRepository<OrderLine, String> {
}
