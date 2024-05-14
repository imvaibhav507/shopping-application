package com.shopping.shoppingapplication.models;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Address {

    private String addressId;
    private String name;
    private String phone;
    private String house;
    private String road;
    private String landmark;
    private String pincode;
}
