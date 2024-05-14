package com.shopping.shoppingapplication.models;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class SizeVariant {

    private Size size;
    private int quantity;
}
