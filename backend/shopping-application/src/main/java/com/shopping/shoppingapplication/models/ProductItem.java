package com.shopping.shoppingapplication.models;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Document(collection = "productitems")
public class ProductItem {

    @Id
    private String id;
    private ObjectId product;
    private Color color;
    private List<SizeVariant> sizeVariants;
    private List<String> pictures;

}
