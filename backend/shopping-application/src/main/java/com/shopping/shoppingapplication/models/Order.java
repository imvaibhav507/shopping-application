package com.shopping.shoppingapplication.models;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.CreatedDate;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Order {

    private String orderId;
    @JsonSerialize(using = ToStringSerializer.class)
    private ObjectId productItem;
    private String brand;
    private String name;
    private String size;
    private int quantity;
    private int price;
    private String picture;
}
