package com.shopping.shoppingapplication.services;

import com.shopping.shoppingapplication.dtos.UserProfileModel;

import java.util.Optional;

public interface UserService {

    Optional<UserProfileModel> getUserProfile(String id);

    void updateUserProfile(String id, UserProfileModel userProfileModel);
}
