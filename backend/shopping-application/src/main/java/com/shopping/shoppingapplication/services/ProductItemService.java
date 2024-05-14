package com.shopping.shoppingapplication.services;

import com.shopping.shoppingapplication.dtos.AvailableColorsModel;
import com.shopping.shoppingapplication.dtos.ProductItemDetailModel;
import com.shopping.shoppingapplication.dtos.ProductItemModel;
import com.shopping.shoppingapplication.models.Category;
import com.shopping.shoppingapplication.models.ProductItem;
import com.shopping.shoppingapplication.models.Size;
import com.shopping.shoppingapplication.models.SizeVariant;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface ProductItemService {

    void addNewProductItem(ProductItem productItem, String productId, List<SizeVariant> sizeVariants);

    List<ProductItemModel> getProductItemByCategory(Category category);

    List<String> addProductImages(List<MultipartFile> files, String productItemId, String path);

    ProductItemDetailModel getProductItemDetailsById(String id);

    List<SizeVariant> getAvailableSizes(String itemId);
    List<AvailableColorsModel> getAvailableColorsForProductItems(String productId);

    List<ProductItemModel> getPopularProductItems();
}
