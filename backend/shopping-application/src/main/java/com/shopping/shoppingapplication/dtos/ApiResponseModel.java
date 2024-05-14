package com.shopping.shoppingapplication.dtos;
import lombok.*;
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ApiResponseModel {

    private int status;
    private Object data;
}
