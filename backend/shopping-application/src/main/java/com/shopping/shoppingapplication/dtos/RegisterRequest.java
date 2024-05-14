package com.shopping.shoppingapplication.dtos;

import com.shopping.shoppingapplication.models.Gender;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class RegisterRequest {

    private String fullname;
    private String email;
    private Gender gender;
    private String password;

}
