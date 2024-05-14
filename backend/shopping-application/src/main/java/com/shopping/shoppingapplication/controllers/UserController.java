package com.shopping.shoppingapplication.controllers;

import com.shopping.shoppingapplication.dtos.UserProfileModel;
import com.shopping.shoppingapplication.models.User;
import com.shopping.shoppingapplication.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@CrossOrigin(origins = "*",allowedHeaders = "*")
@RequestMapping("/api/v1/user")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @GetMapping()
    public ResponseEntity<UserProfileModel> getUserProfile() {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User fetchedUser = (User) authentication.getPrincipal();

        Optional<UserProfileModel> user = userService.getUserProfile(fetchedUser.getId());

        return user.map(
                        userProfileModel -> new ResponseEntity<>(userProfileModel, HttpStatus.OK))
                .orElseGet(() -> new ResponseEntity<>(null, HttpStatus.NOT_FOUND));

    }

    @PutMapping()
    public ResponseEntity<String> updateUserProfile(
            @RequestBody UserProfileModel updatedProfile
    ) {

        userService.updateUserProfile(updatedProfile.getId(), updatedProfile);

        return new ResponseEntity<>("user updated", HttpStatus.OK);

    }
}
