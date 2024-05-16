package com.shopping.shoppingapplication.dtos;

import com.shopping.shoppingapplication.models.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CartItemModel {

    private String itemId;
    private String productItem;
    private String product;
    private String name;
    private String brand;
    private String picture;
    private String price;
    private Size size;
    private int quantity;

}
