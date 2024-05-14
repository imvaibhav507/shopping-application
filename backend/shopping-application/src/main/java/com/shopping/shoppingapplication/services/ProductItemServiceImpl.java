package com.shopping.shoppingapplication.services;
import com.shopping.shoppingapplication.dtos.AvailableColorsModel;
import com.shopping.shoppingapplication.dtos.ProductItemDetailModel;
import com.shopping.shoppingapplication.dtos.ProductItemModel;
import com.shopping.shoppingapplication.models.*;
import com.shopping.shoppingapplication.repositories.ProductItemRepository;
import com.shopping.shoppingapplication.repositories.ProductRepository;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.AggregationResults;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.springframework.data.mongodb.core.aggregation.Aggregation.*;

@Service
public class ProductItemServiceImpl implements ProductItemService{

    @Autowired
    private ProductItemRepository productItemRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private CloudinaryService cloudinaryService;

    @Autowired
    private MongoTemplate mongoTemplate;

    @Override
    public void addNewProductItem(ProductItem productItem, String productId, List<SizeVariant> sizeVariants) {

        Optional<Product> product = productRepository.findById(productId);

        product.ifPresent(foundProduct -> {
            productItem.setProduct(new ObjectId(foundProduct.getId()));
            ProductItem insertedItem = productItemRepository.insert(productItem);
            insertedItem.setSizeVariants(sizeVariants);
        });

    }

    @Override
    public List<ProductItemModel> getProductItemByCategory(Category category) {

        AggregationResults<ProductItemModel> fetchedItems = mongoTemplate
                .aggregate(
                        newAggregation(
                                lookup()
                                        .from("products")
                                        .localField("product")
                                        .foreignField("_id")
                                        .as("product"),

                                match(Criteria.where("product.category").is(category)),

                                unwind("product"),

                                project()
                                        .andExpression("_id").as("sid")
                                        .andExpression("product.name").as("name")
                                        .andExpression("product.brand").as("brand")
                                        .andExpression("product.price").as("price")
                                        .andExpression("product._id").as("productId")
                                        .andExpression("product.category").as("category")
                                        .andExpression("pictures").arrayElementAt(0).as("picture")
                                        .andExpression("color").as("color")

                        ),
                "productitems", ProductItemModel.class);

        return fetchedItems.getMappedResults();
    }

    @Override
    public List<String> addProductImages(List<MultipartFile> files, String productItemId, String path) {

        List<String> uploadedImageUrls;
        ProductItem item = productItemRepository.findById(productItemId).orElse(null);

        if(item != null) {
            uploadedImageUrls = cloudinaryService.upload(files, path);
            item.setPictures(uploadedImageUrls);
            productItemRepository.save(item);
            return uploadedImageUrls;
        }

        return new ArrayList<>();
    }

    @Override
    public ProductItemDetailModel getProductItemDetailsById(String id) {

        AggregationResults<ProductItemDetailModel> fetchedItemDetail = mongoTemplate
                .aggregate(
                        newAggregation(
                                match(Criteria.where("_id").is(id)),

                                lookup()
                                        .from("products")
                                        .localField("product")
                                        .foreignField("_id")
                                        .as("product"),

                                unwind("product"),

                                project()
                                        .andExpression("_id").as("id")
                                        .andExpression("product.name").as("name")
                                        .andExpression("product.brand").as("brand")
                                        .andExpression("product.price").as("price")
                                        .andExpression("product.category").as("category")
                                        .andExpression("product._id").as("productId")
                                        .andExpression("color").as("color")
                                        .andExpression("pictures").as("pictures")
                                        .andExpression("sizeVariants").as("sizeVariants")
                        ),
                        "productitems", ProductItemDetailModel.class);

        return fetchedItemDetail.getMappedResults().get(0);
    }

    @Override
    public List<SizeVariant> getAvailableSizes(String itemId) {
        List<SizeVariant> sizeVariants = new ArrayList<>();
        ProductItem item = productItemRepository.findById(itemId).orElse(null);
        if(item != null) {
            sizeVariants = item.getSizeVariants();
        }
        return sizeVariants;
    }

    @Override
    public List<AvailableColorsModel> getAvailableColorsForProductItems(String productId) {

        AggregationResults<AvailableColorsModel> availableColors = mongoTemplate
                .aggregate(
                        newAggregation(
                                match(Criteria.where("product").is(new ObjectId(productId))),

                                project()
                                        .andExpression("_id").as("id")
                                        .andExpression("color").as("color")
                        ),
                        "productitems", AvailableColorsModel.class);

        return availableColors.getMappedResults();
    }

    @Override
    public List<ProductItemModel> getPopularProductItems() {
        AggregationResults<ProductItemModel> queryValues =  mongoTemplate
                .aggregate(
                        newAggregation(

                                sample(5),
                                lookup()
                                        .from("products")
                                        .localField("product")
                                        .foreignField("_id")
                                        .as("product"),

                                unwind("product"),

                                project()
                                        .andExpression("_id").as("sid")
                                        .andExpression("product.name").as("name")
                                        .andExpression("product.brand").as("brand")
                                        .andExpression("product.price").as("price")
                                        .andExpression("product._id").as("productId")
                                        .andExpression("product.category").as("category")
                                        .andExpression("pictures").arrayElementAt(0).as("picture")
                                        .andExpression("color").as("color")

                        ),
                        "productitems", ProductItemModel.class);
        return queryValues.getMappedResults();
    }

}
