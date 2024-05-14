package com.shopping.shoppingapplication.controllers;
import com.shopping.shoppingapplication.dtos.AuthenticationRequest;
import com.shopping.shoppingapplication.dtos.AuthenticationResponse;
import com.shopping.shoppingapplication.dtos.RegisterRequest;
import com.shopping.shoppingapplication.services.AuthenticationService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin(origins = "*",allowedHeaders = "*")
@RequestMapping("/api/v1/auth")
@RequiredArgsConstructor
public class AuthenticationController {

    private final AuthenticationService authService;

    @PostMapping("/register")
    public ResponseEntity<AuthenticationResponse> register(
            @RequestBody RegisterRequest request
    ) {
        return ResponseEntity.ok(authService.register(request));
    }

    @PostMapping("/authenticate")
    public ResponseEntity<AuthenticationResponse> authenticate(
            @RequestBody AuthenticationRequest request
    ) {
        return  new ResponseEntity<>(authService.authenticate(request), HttpStatus.OK);
    }
}
