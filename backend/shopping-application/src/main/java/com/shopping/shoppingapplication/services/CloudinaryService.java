package com.shopping.shoppingapplication.services;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

public interface CloudinaryService {

    public List<String> upload(List<MultipartFile> files, String folder);
}
