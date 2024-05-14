package com.shopping.shoppingapplication.services;
import com.shopping.shoppingapplication.models.Order;
import com.shopping.shoppingapplication.models.OrderLine;
import org.bson.types.ObjectId;
import java.util.List;

public interface OrderService {

    List<ObjectId> getUserOrderLines(String userId);

    void createOrderLineForUser(String userId, List<Order> orders);

    List<OrderLine> getAllUserOrders(String userId);
}
