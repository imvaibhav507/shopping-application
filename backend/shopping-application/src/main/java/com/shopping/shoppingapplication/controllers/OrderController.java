package com.shopping.shoppingapplication.controllers;
import com.shopping.shoppingapplication.dtos.ApiResponseModel;
import com.shopping.shoppingapplication.models.Order;
import com.shopping.shoppingapplication.models.OrderLine;
import com.shopping.shoppingapplication.models.User;
import com.shopping.shoppingapplication.services.CartService;
import com.shopping.shoppingapplication.services.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin(origins = "*",allowedHeaders = "*")
@RequestMapping("/api/v1/user/order")
@RequiredArgsConstructor
public class OrderController {

    private final OrderService orderService;
    private final CartService cartService;

    @GetMapping()
    ResponseEntity<ApiResponseModel> getAllOrdersForUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User fetchedUser = (User) authentication.getPrincipal();
        List<OrderLine> fetchedOrderLines = orderService.getAllUserOrders(fetchedUser.getId());
        return new ResponseEntity<>(new ApiResponseModel(200, fetchedOrderLines), HttpStatus.OK);
    }

    @PostMapping
    ResponseEntity<ApiResponseModel> createOrdersForUser(
            @RequestBody List<Order> orders) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User fetchedUser = (User) authentication.getPrincipal();
        orderService.createOrderLineForUser(fetchedUser.getId(), orders);
        cartService.clearUserCart(fetchedUser.getId());
        return new ResponseEntity<>(new ApiResponseModel(200, "orders placed"), HttpStatus.OK);
    }
}
