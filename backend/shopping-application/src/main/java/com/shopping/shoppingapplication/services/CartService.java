package com.shopping.shoppingapplication.services;

import com.shopping.shoppingapplication.dtos.CartItemModel;
import com.shopping.shoppingapplication.models.Cart;
import com.shopping.shoppingapplication.models.CartItem;

import java.util.List;

public interface CartService {

    Cart getUserCart(String id);
    void addItemToCart(String userId, CartItem cartItem);

    List<CartItemModel> getUserCartItems(String userId);

    void ModifyCartItemQuantity(String userId, String cartItemId, String modifyType);

    void clearUserCart(String userId);
}
