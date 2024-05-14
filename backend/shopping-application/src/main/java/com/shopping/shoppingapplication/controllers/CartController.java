package com.shopping.shoppingapplication.controllers;
import com.shopping.shoppingapplication.dtos.ApiResponseModel;
import com.shopping.shoppingapplication.dtos.CartItemModel;
import com.shopping.shoppingapplication.models.Cart;
import com.shopping.shoppingapplication.models.CartItem;
import com.shopping.shoppingapplication.models.User;
import com.shopping.shoppingapplication.services.CartService;
import lombok.RequiredArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin(origins = "*",allowedHeaders = "*")
@RequestMapping("/api/v1/user/cart")
@RequiredArgsConstructor
public class CartController {

    private final CartService cartService;

    @GetMapping()
    public ResponseEntity<ApiResponseModel> getUserCartItems() {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User fetchedUser = (User) authentication.getPrincipal();

        List<CartItemModel> fetchedCartItems = cartService.getUserCartItems(fetchedUser.getId());

        return new ResponseEntity<>(new ApiResponseModel(200, fetchedCartItems), HttpStatus.OK);

    }

    @PostMapping()
    public ResponseEntity<ApiResponseModel> addItemToCart(
            @RequestBody CartItem cartItem
            ) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User fetchedUser = (User) authentication.getPrincipal();
        cartService.addItemToCart(fetchedUser.getId(), cartItem);
        return new ResponseEntity<>(new ApiResponseModel(200, "item added to cart"), HttpStatus.OK);

    }

    @PutMapping()
    public ResponseEntity<ApiResponseModel> modifyCartItemQuantity(
            @RequestParam("cartitem") String cartItemId,
            @RequestParam("modify") String modifyType
    ) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User fetchedUser = (User) authentication.getPrincipal();

        cartService.ModifyCartItemQuantity(fetchedUser.getId(), cartItemId, modifyType);

        return new ResponseEntity<>(new ApiResponseModel(200, "quantity updated"), HttpStatus.OK);
    }
}
