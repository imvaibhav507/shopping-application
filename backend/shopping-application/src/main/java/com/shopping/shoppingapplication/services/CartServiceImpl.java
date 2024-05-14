package com.shopping.shoppingapplication.services;
import com.shopping.shoppingapplication.dtos.CartItemModel;
import com.shopping.shoppingapplication.models.Cart;
import com.shopping.shoppingapplication.models.CartItem;
import com.shopping.shoppingapplication.models.User;
import com.shopping.shoppingapplication.repositories.CartRepository;
import com.shopping.shoppingapplication.repositories.UserRepository;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.AggregationOperation;
import org.springframework.data.mongodb.core.aggregation.AggregationResults;
import org.springframework.data.mongodb.core.aggregation.ArrayOperators;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import static org.springframework.data.mongodb.core.aggregation.Aggregation.*;

@Service
public class CartServiceImpl implements CartService{

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private CartRepository cartRepository;
    @Autowired
    private MongoTemplate mongoTemplate;
    @Override
    public Cart getUserCart(String id) {
        User user = userRepository.getUserById(id);
        ObjectId cart = user.getCart();

        if(cart == null) {
            Cart newCart = mongoTemplate.insert(new Cart(),"carts");
            List<CartItem> cartItems = new ArrayList<>();
            newCart.setCartItems(cartItems);
            cartRepository.save(newCart);
            user.setCart(new ObjectId(newCart.getId()));
            userRepository.save(user);
            return newCart;
        }

        return mongoTemplate.findById(cart, Cart.class, "carts");
    }

    @Override
    public void addItemToCart(String id, CartItem item) {
        Cart cart = getUserCart(id);
        System.out.println(cart);
        List<CartItem> cartItems = cart.getCartItems();

        CartItem existingItem = cartItems.stream()
                .filter((val)->
                        val.getProductItem().equals(item.getProductItem()) &&
                        val.getSize().equals(item.getSize()))
                .findFirst().orElse(null);

        System.out.println(existingItem);

        if(existingItem != null) {
            int quantity = existingItem.getQuantity();
            quantity++;
            int index = cartItems.indexOf(existingItem);
            item.setQuantity(quantity);
            cartItems.set(index, item);
            System.out.println("existing item updated");
        }

        else {
            cartItems.add(item);
            System.out.println("new item added");
        }

        cart.setCartItems(cartItems);
        cartRepository.save(cart);
        System.out.println(cartItems);
    }

    @Override
    public List<CartItemModel> getUserCartItems(String userId) {

        Cart cart = getUserCart(userId);
        AggregationResults<CartItemModel> fetchedCartItems = mongoTemplate
                .aggregate(
                        newAggregation(

                                match(Criteria.where("_id").is(new ObjectId(cart.getId()))),

                                unwind("cartItems"),

                                lookup()
                                        .from("products")
                                        .localField("cartItems.product")
                                        .foreignField("_id")
                                        .as("product"),

                                unwind("product"),

                                project()
                                        .andExpression("cartItems.itemId").as("itemId")
                                        .andExpression("cartItems.productItem").as("productItem")
                                        .andExpression("product.name").as("name")
                                        .andExpression("product.brand").as("brand")
                                        .andExpression("cartItems.picture").as("picture")
                                        .andExpression("product.price").as("price")
                                        .andExpression("cartItems.size").as("size")
                                        .andExpression("cartItems.quantity").as("quantity")
                        ),
                        "carts", CartItemModel.class);
        return fetchedCartItems.getMappedResults();
    }

    @Override
    public void ModifyCartItemQuantity(String userId, String cartItemId, String modifyType) {

        Cart cart = getUserCart(userId);

        List<CartItem> cartItems = cart.getCartItems();
        CartItem fetchedItem = cartItems.stream()
                .filter((item)-> item.getItemId().equals(cartItemId))
                .findFirst()
                .orElse(null);

        if(fetchedItem == null) {
            return;
        }
        int quantity = fetchedItem.getQuantity();

        if(modifyType.equals("increase")) {
            quantity++;
        } else quantity--;

        int index = cartItems.indexOf(fetchedItem);

        if(quantity == 0) {
            cartItems.remove(index);
        } else {
            fetchedItem.setQuantity(quantity);
            cartItems.set(index, fetchedItem);
        }

        cart.setCartItems(cartItems);
        cartRepository.save(cart);
        System.out.println(cartItems);
    }

    @Override
    public void clearUserCart(String userId) {
        Cart cart = getUserCart(userId);
        List<CartItem> cartItems = cart.getCartItems();
        cartItems.clear();
        cart.setCartItems(cartItems);
        cartRepository.save(cart);
    }
}
