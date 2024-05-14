package com.shopping.shoppingapplication.dtos;

import com.shopping.shoppingapplication.models.Category;
import com.shopping.shoppingapplication.models.SizeVariant;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProductItemDetailModel {
    private String id;
    private String name;
    private String brand;
    private String price;
    private String productId;
    private Category category;
    private List<String> pictures;
    private String color;
    private boolean isFavourite;
    private List<SizeVariant> sizeVariants;
    private List<AvailableColorsModel> availableColors;
}
