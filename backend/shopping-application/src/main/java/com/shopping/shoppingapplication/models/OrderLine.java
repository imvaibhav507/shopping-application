package com.shopping.shoppingapplication.models;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "orderlines")
public class OrderLine {

    @Id
    private String id;
    @JsonSerialize(using = ToStringSerializer.class)
    private ObjectId user;
    private int totalPrice;
    private List<Order> orders;
    @CreatedDate
    private String date;
}
