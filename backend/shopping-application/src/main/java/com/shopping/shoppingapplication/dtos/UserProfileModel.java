package com.shopping.shoppingapplication.dtos;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserProfileModel {
    private String id;
    private String fullname;
    private String email;
    private String gender;
}
