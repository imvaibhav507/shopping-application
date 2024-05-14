package com.shopping.shoppingapplication.repositories;

import com.shopping.shoppingapplication.models.Cart;
import com.shopping.shoppingapplication.models.User;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.Optional;

public interface UserRepository extends MongoRepository<User, String> {

    Optional<User> findByEmail(String email);

    User getUserById(String id);
}
