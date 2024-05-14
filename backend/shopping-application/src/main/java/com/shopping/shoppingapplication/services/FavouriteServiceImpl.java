package com.shopping.shoppingapplication.services;

import com.shopping.shoppingapplication.dtos.ProductItemModel;
import com.shopping.shoppingapplication.models.Favourite;
import com.shopping.shoppingapplication.models.User;
import com.shopping.shoppingapplication.repositories.FavouriteRepository;
import com.shopping.shoppingapplication.repositories.UserRepository;
import org.bson.Document;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.AggregationResults;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

import static org.springframework.data.mongodb.core.aggregation.Aggregation.*;

@Service
public class FavouriteServiceImpl implements FavouriteService {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private FavouriteRepository favouriteRepository;
    @Autowired
    private MongoTemplate mongoTemplate;

    @Override
    public Favourite getUserFavourite(String id) {

        User user = userRepository.getUserById(id);
        ObjectId favourite = user.getFavourite();

        if(favourite == null) {
            Favourite newFavourite = mongoTemplate.insert(new Favourite(), "favourites");
            List<ObjectId> productItems = new ArrayList<>();
            newFavourite.setFavouriteItems(productItems);
            favouriteRepository.save(newFavourite);
            user.setFavourite(new ObjectId(newFavourite.getId()));
            userRepository.save(user);
            return newFavourite;
        }
        return mongoTemplate.findById(favourite, Favourite.class, "favourites");
    }

    @Override
    public List<ProductItemModel> getProductItemsByUserFavourite(String userId) {

        Favourite userFavourite = getUserFavourite(userId);

        AggregationResults<ProductItemModel> fetchedItems = mongoTemplate.aggregate(
                newAggregation(
                        match(Criteria.where("_id").is(new ObjectId(userFavourite.getId()))),

                        unwind("favouriteItems"),

                        lookup()
                                .from("productitems")
                                .localField("favouriteItems")
                                .foreignField("_id")
                                .as("favouriteItems"),

                        unwind("favouriteItems"),

                        lookup()
                                .from("products")
                                .localField("favouriteItems.product")
                                .foreignField("_id")
                                .as("product"),

                        unwind("product"),

                        project()

                                .andExpression("favouriteItems._id").as("sid")
                                .andExpression("product.name").as("name")
                                .andExpression("product.brand").as("brand")
                                .andExpression("product.price").as("price")
                                .andExpression("product._id").as("productId")
                                .andExpression("product.category").as("category")
                                .andExpression("favouriteItems.pictures").arrayElementAt(0).as("picture")
                                .andExpression("favouriteItems.color").as("color")

                ),
                "favourites", ProductItemModel.class);

        return fetchedItems.getMappedResults();
    }

    @Override
    public void modifyFavourite(String userId, String itemId) {

        Favourite favourite = getUserFavourite(userId);
        List<ObjectId> favouriteItems = favourite.getFavouriteItems();

        ObjectId existingItem = favouriteItems.stream()
                .filter((val)->
                        val.toHexString().equals(itemId))
                .findFirst().orElse(null);

        System.out.println(existingItem);

        if(existingItem != null) {
            System.out.println("item already present");
            favouriteItems.remove(new ObjectId(itemId));
            System.out.println("item removed");
        }
        else {
            favouriteItems.add(new ObjectId(itemId));
            System.out.println("new item added");
        }

        favourite.setFavouriteItems(favouriteItems);
        favouriteRepository.save(favourite);
        System.out.println(favouriteItems);
    }

    @Override
    public boolean isItemInFavourites(String userId, String itemId) {

        Favourite favourite = getUserFavourite(userId);
        List<ObjectId> favItem = favourite.getFavouriteItems();
        return favItem.contains(new ObjectId(itemId));

    }
}
