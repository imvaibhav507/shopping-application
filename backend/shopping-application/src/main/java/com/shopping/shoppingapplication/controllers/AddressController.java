package com.shopping.shoppingapplication.controllers;
import com.shopping.shoppingapplication.dtos.ApiResponseModel;
import com.shopping.shoppingapplication.models.Address;
import com.shopping.shoppingapplication.models.User;
import com.shopping.shoppingapplication.services.AddressService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@CrossOrigin(origins = "*",allowedHeaders = "*")
@RequestMapping("/api/v1/user/address")
@RequiredArgsConstructor
public class AddressController {

    private final AddressService addressService;
    @GetMapping()
    ResponseEntity<ApiResponseModel> getUserAddresses() {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User fetchedUser = (User) authentication.getPrincipal();

        List<Address> fetchedAddresses = addressService.getUserAddressItems(fetchedUser.getId());

        return new ResponseEntity<>(new ApiResponseModel(200, fetchedAddresses), HttpStatus.OK);
    }
    @GetMapping("/default")
    ResponseEntity<ApiResponseModel> getSingleUserAddress() {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User fetchedUser = (User) authentication.getPrincipal();

        Address address = new Address();
        List<Address> fetchedAddresses = addressService.getUserAddressItems(fetchedUser.getId());
        if(!fetchedAddresses.isEmpty()) {
            address = fetchedAddresses.get(0);
        }

        return new ResponseEntity<>(new ApiResponseModel(200, address), HttpStatus.OK);
    }

    @GetMapping("/")
    ResponseEntity<ApiResponseModel> getAddressById(
            @RequestParam("id") String addressId) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User fetchedUser = (User) authentication.getPrincipal();

        Address fetchedAddress = addressService.getAddressById(fetchedUser.getId(), addressId);

        return new ResponseEntity<>(new ApiResponseModel(200, fetchedAddress), HttpStatus.OK);
    }

    @PostMapping()
    ResponseEntity<ApiResponseModel> addNewAddress(
            @RequestBody Address address
    ) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User fetchedUser = (User) authentication.getPrincipal();

        addressService.addAddressItem(fetchedUser.getId(), address);

        return new ResponseEntity<>(new ApiResponseModel(200, "Address added"), HttpStatus.OK);
    }

    @DeleteMapping()
    ResponseEntity<ApiResponseModel> removeAddress(
            @RequestParam("id") String addressId
    ) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User fetchedUser = (User) authentication.getPrincipal();

        addressService.removeAddressItem(fetchedUser.getId(), addressId);
        System.out.println("address deleted");

        return  new ResponseEntity<>(new ApiResponseModel(200, "Address removed"), HttpStatus.OK);
    }
}
