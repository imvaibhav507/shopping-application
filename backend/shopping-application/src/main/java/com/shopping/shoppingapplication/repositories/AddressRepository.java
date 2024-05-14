package com.shopping.shoppingapplication.repositories;

import com.shopping.shoppingapplication.models.UserAddress;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface AddressRepository extends MongoRepository<UserAddress, String> {

    UserAddress getUserAddressByUser(ObjectId userId);
}
