package com.shopping.shoppingapplication.controllers;
import com.shopping.shoppingapplication.dtos.ApiResponseModel;
import com.shopping.shoppingapplication.services.CloudinaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.util.List;

@RestController
@CrossOrigin(origins = "*",allowedHeaders = "*")
@RequestMapping("/api/v1/auth/cloudinary")
public class CloudinaryImageUploadController {

    @Autowired
    private CloudinaryService cloudinaryService;

    @PostMapping("/upload")
    public ResponseEntity<ApiResponseModel> uploadImage (
            @RequestParam("images") List<MultipartFile > files,
            @RequestParam("path") String path
            ) {

        List<String> fetchedUrls = cloudinaryService.upload(files, path);

        return new ResponseEntity<>(new ApiResponseModel(200, fetchedUrls), HttpStatus.OK);
    }
}
