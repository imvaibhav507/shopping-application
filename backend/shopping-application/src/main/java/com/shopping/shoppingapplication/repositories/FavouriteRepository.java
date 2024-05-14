package com.shopping.shoppingapplication.repositories;
import com.shopping.shoppingapplication.models.Favourite;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface FavouriteRepository extends MongoRepository<Favourite, String> {
}
