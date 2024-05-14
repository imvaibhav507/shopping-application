package com.shopping.shoppingapplication.configurations;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class CloudinaryConfig {

    Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
            "cloud_name", "dhkva4aew",
            "api_key", "228655166355216",
            "api_secret", "Y2yI4scBA5PthSGOSKHgC2jvD48",
            "secure", true));

    @Bean
    public Cloudinary getCloudinary() {
        return cloudinary;
    }


}
