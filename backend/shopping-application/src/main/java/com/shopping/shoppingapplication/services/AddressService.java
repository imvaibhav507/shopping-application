package com.shopping.shoppingapplication.services;

import com.shopping.shoppingapplication.models.Address;
import com.shopping.shoppingapplication.models.UserAddress;

import java.util.List;

public interface AddressService {

    UserAddress getUserAddress(String userId);

    void addAddressItem(String userId, Address address);

    void removeAddressItem(String userId, String addressId);
    List<Address> getUserAddressItems(String userId);

    Address getAddressById(String userId, String addressId);
}
