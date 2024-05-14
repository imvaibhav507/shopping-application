package com.shopping.shoppingapplication.models;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import lombok.*;
import org.bson.types.ObjectId;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CartItem {

    private String itemId;
    @JsonSerialize(using = ToStringSerializer.class)
    private ObjectId productItem;
    private String price;
    private String picture;
    private int quantity;
    private Size size;

}
