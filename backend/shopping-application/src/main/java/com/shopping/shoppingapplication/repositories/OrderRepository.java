package com.shopping.shoppingapplication.repositories;

import com.shopping.shoppingapplication.models.OrderLine;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface OrderRepository extends MongoRepository<OrderLine, String> {

    List<OrderLine> findOrderLinesByUser(ObjectId userId);
}
