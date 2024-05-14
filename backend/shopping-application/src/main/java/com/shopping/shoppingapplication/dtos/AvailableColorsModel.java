package com.shopping.shoppingapplication.dtos;

import com.shopping.shoppingapplication.models.Color;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AvailableColorsModel {
    private String id;
    private Color color;
}
