package com.shopping.shoppingapplication.models;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Document(collection = "productreviews")
public class ProductReview {

    @Id
    private String id;
    private ObjectId product;
    private Review review;
}
