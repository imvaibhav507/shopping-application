package com.shopping.shoppingapplication.services;
import com.shopping.shoppingapplication.dtos.UserProfileModel;
import com.shopping.shoppingapplication.models.User;
import com.shopping.shoppingapplication.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.FindAndModifyOptions;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.Aggregation;
import org.springframework.data.mongodb.core.aggregation.AggregationResults;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private MongoTemplate mongoTemplate;

    @Autowired
    private UserRepository userRepository;

    @Override
    public Optional<UserProfileModel> getUserProfile(String id) {

        Aggregation aggregation = Aggregation.newAggregation(

                Aggregation.match(Criteria.where("_id").is(id)),
                Aggregation.project("_id", "fullname", "email", "gender")
        );

        AggregationResults<UserProfileModel> results = mongoTemplate
                .aggregate(aggregation, "users", UserProfileModel.class);

        return results.getMappedResults().stream().findFirst();
    }

    @Override
    public void updateUserProfile(String id, UserProfileModel userProfileModel) {

        Query query = new Query(Criteria.where("_id").is(id));

        Update update = new Update()
                .set("fullname", userProfileModel.getFullname())
                .set("gender", userProfileModel.getGender());

        mongoTemplate.findAndModify(
                query, update,
                new FindAndModifyOptions().returnNew(true),
                User.class
        );
    }

}
