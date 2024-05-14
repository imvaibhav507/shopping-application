package com.shopping.shoppingapplication.services;
import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.stream.Stream;

@Service
public class CloudinaryServiceImpl  implements CloudinaryService{

    @Autowired
    private Cloudinary cloudinary;
    @Override
    public List<String> upload(List<MultipartFile> files, String folder) {

        Stream<Map> uploadedFiles = files.stream().map(
                (file)-> {
                    try {
                        return this.cloudinary
                                .uploader().upload(file.getBytes(),
                                        ObjectUtils.asMap("folder", folder));
                    } catch (IOException e) {
                        throw new RuntimeException(e);
                    }
                }
        );

        return uploadedFiles
                .map((file)-> file.get("url").toString()).toList();
    }
}
