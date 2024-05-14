package com.shopping.shoppingapplication.controllers;
import com.shopping.shoppingapplication.dtos.ApiResponseModel;
import com.shopping.shoppingapplication.dtos.AvailableColorsModel;
import com.shopping.shoppingapplication.dtos.ProductItemDetailModel;
import com.shopping.shoppingapplication.dtos.ProductItemModel;
import com.shopping.shoppingapplication.models.Category;
import com.shopping.shoppingapplication.models.SizeVariant;
import com.shopping.shoppingapplication.models.User;
import com.shopping.shoppingapplication.repositories.FavouriteRepository;
import com.shopping.shoppingapplication.services.FavouriteService;
import com.shopping.shoppingapplication.services.ProductItemService;
import com.shopping.shoppingapplication.services.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.util.List;

@RestController
@CrossOrigin(origins = "*",allowedHeaders = "*")
@RequestMapping("/api/v1/product")
@RequiredArgsConstructor
public class ProductController {

    private final ProductItemService productItemService;
    private final FavouriteService favouriteService;
    @GetMapping("/")
    public ResponseEntity<ApiResponseModel> getProductItemsByCategory(
            @RequestParam("category") Category category) {
        System.out.println(category);
        List<ProductItemModel> fetchedItems = productItemService.getProductItemByCategory(category);

        return new ResponseEntity<>(new ApiResponseModel(200, fetchedItems), HttpStatus.OK);
    }

    @GetMapping("/item/")
    public ResponseEntity<ApiResponseModel> getProductItemDetailsById(
            @RequestParam("itemId") String itemId,
            @RequestParam("productId") String productId) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User fetchedUser = (User) authentication.getPrincipal();

        ProductItemDetailModel fetchedItemDetail = productItemService.getProductItemDetailsById(itemId);
        boolean isFav = favouriteService.isItemInFavourites(fetchedUser.getId(), fetchedItemDetail.getId());
        fetchedItemDetail.setFavourite(isFav);

        List<AvailableColorsModel> availableColors = productItemService.getAvailableColorsForProductItems(productId);
        fetchedItemDetail.setAvailableColors(availableColors);

        System.out.println(fetchedItemDetail);

        return new ResponseEntity<>(new ApiResponseModel(200, fetchedItemDetail), HttpStatus.OK);
    }

    @GetMapping("/item/size")
    public ResponseEntity<ApiResponseModel> getAvailableSizes(
            @RequestParam("itemId") String itemId
    ) {

        List<SizeVariant> fetchedSizes = productItemService.getAvailableSizes(itemId);

        return new ResponseEntity<>(new ApiResponseModel(200, fetchedSizes), HttpStatus.OK);

    }
    @GetMapping("/item/favourite")
    public ResponseEntity<ApiResponseModel> getProductItemsByUserFavourite() {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User fetchedUser = (User) authentication.getPrincipal();

        List<ProductItemModel> fetchedItems = favouriteService.getProductItemsByUserFavourite(fetchedUser.getId());

        return new ResponseEntity<>(new ApiResponseModel(200, fetchedItems), HttpStatus.OK);
    }

    @GetMapping("/popular")
    public ResponseEntity<ApiResponseModel> getPopularProductItems() {

        List<ProductItemModel> fetchedItems = productItemService.getPopularProductItems();

        return new ResponseEntity<>(new ApiResponseModel(200, fetchedItems), HttpStatus.OK);
    }

    @PutMapping("/item/favourite")
    public ResponseEntity<ApiResponseModel> modifyFavourite(
            @RequestParam("itemId") String itemId) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User fetchedUser = (User) authentication.getPrincipal();

        favouriteService.modifyFavourite(fetchedUser.getId(), itemId);
        return new ResponseEntity<>(new ApiResponseModel(200, "item modified"), HttpStatus.OK);
    }

//    @GetMapping("/item/search")
//    public ResponseEntity<ApiResponseModel> getSearchKeys(
//            @RequestParam("query") String query){
//        List<String> searchResults = productItemService.getProductItemsByQuery(query);
//        return new ResponseEntity<>(new ApiResponseModel(200, searchResults), HttpStatus.OK);
//    }

    @PostMapping("/")
    public ResponseEntity<ApiResponseModel> uploadProductImages(
            @RequestParam("images") List<MultipartFile> files,
            @RequestParam("id") String id,
            @RequestParam("path") String path
    ) {
        List<String> uploadedImageUrls = productItemService.addProductImages(files, id, path);

        return new ResponseEntity<>(new ApiResponseModel(200, uploadedImageUrls), HttpStatus.OK);
    }

}
