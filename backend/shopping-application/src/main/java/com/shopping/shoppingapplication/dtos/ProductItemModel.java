package com.shopping.shoppingapplication.dtos;

import com.shopping.shoppingapplication.models.Category;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProductItemModel {

    private String sid;
    private String name;
    private String brand;
    private String price;
    private String productId;
    private Category category;
    private String picture;
    private String color;
}
