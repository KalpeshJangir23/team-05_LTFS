package com.lostandfound.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    // Recommended: keep path in application.properties and inject it here
    @Value("${app.upload.dir:C:/team-05_LTFS/backend/lostandfound/uploads/}")
    private String uploadDir;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // Ensure uploadDir ends with slash
        if (!uploadDir.endsWith("/") && !uploadDir.endsWith("\\")) {
            uploadDir = uploadDir + "/";
        }

        // Map requests to /uploads/** -> files in the filesystem folder
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations("file:" + uploadDir);
    }
}
