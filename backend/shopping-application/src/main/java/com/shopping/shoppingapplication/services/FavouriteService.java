package com.shopping.shoppingapplication.services;

import com.shopping.shoppingapplication.dtos.ProductItemModel;
import com.shopping.shoppingapplication.models.Favourite;

import java.util.List;

public interface FavouriteService {

    void modifyFavourite(String userId, String itemId);

    boolean isItemInFavourites(String userId, String itemId);
    Favourite getUserFavourite(String userId);

    List<ProductItemModel> getProductItemsByUserFavourite(String userId);
}
