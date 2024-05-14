package com.shopping.shoppingapplication.services;
import com.shopping.shoppingapplication.models.Address;
import com.shopping.shoppingapplication.models.User;
import com.shopping.shoppingapplication.models.UserAddress;
import com.shopping.shoppingapplication.repositories.AddressRepository;
import com.shopping.shoppingapplication.repositories.UserRepository;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class AddressServiceImpl implements AddressService{

    @Autowired
    private AddressRepository addressRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private MongoTemplate mongoTemplate;
    @Override
    public UserAddress getUserAddress(String userId) {

        User user = userRepository.getUserById(userId);
        ObjectId userAddress = user.getUserAddress();

        if(userAddress == null) {
            UserAddress createdAddress = mongoTemplate.insert(new UserAddress(), "useraddresses");
            List<Address> addresses = new ArrayList<>();
            createdAddress.setAddresses(addresses);
            addressRepository.save(createdAddress);
            user.setUserAddress(new ObjectId(createdAddress.getId()));
            userRepository.save(user);
            return createdAddress;
        }
        return mongoTemplate.findById(userAddress, UserAddress.class, "useraddresses");
    }

    @Override
    public void addAddressItem(String userId, Address address) {

        UserAddress userAddress = getUserAddress(userId);
        List<Address> addresses = userAddress.getAddresses();
        addresses.add(address);
        userAddress.setAddresses(addresses);
        addressRepository.save(userAddress);
    }

    @Override
    public void removeAddressItem(String userId, String addressId) {
        UserAddress userAddress = getUserAddress(userId);
        List<Address> addresses = userAddress.getAddresses();
        Address foundAddress = addresses.stream()
                .filter((address -> address.getAddressId().equals(addressId)))
                .findFirst().orElse(null);

        if(foundAddress == null) {
            System.out.println("no address found to remove");
            return;
        }
        addresses.remove(foundAddress);
        userAddress.setAddresses(addresses);
        addressRepository.save(userAddress);
    }

    @Override
    public List<Address> getUserAddressItems(String userId) {

        UserAddress userAddress = getUserAddress(userId);
        return userAddress.getAddresses();
    }

    @Override
    public Address getAddressById(String userId, String addressId) {
        UserAddress userAddress = getUserAddress(userId);
        List<Address> addresses = userAddress.getAddresses();
        return addresses.stream()
                .filter((address -> address.getAddressId()
                .equals(addressId))).findFirst().orElse(null);
    }
}
