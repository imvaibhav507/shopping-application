package com.shopping.shoppingapplication.models;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.CreatedDate;

@Data
@NoArgsConstructor
public class Order {

    private String orderId;
    @CreatedDate
    private String date;
    private ObjectId productItem;
    private int quantity;
    private int totalPrice;

    public Order(String orderId, String date, String productItem, int quantity, int totalPrice) {
        this.orderId = orderId;
        this.date = date;
        this.productItem = new ObjectId(productItem);
        this.quantity = quantity;
        this.totalPrice = totalPrice;
    }
}
