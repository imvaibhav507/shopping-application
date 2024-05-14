package com.shopping.shoppingapplication.services;
import com.shopping.shoppingapplication.models.Order;
import com.shopping.shoppingapplication.models.OrderLine;
import com.shopping.shoppingapplication.models.User;
import com.shopping.shoppingapplication.repositories.OrderRepository;
import com.shopping.shoppingapplication.repositories.UserRepository;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {


    @Autowired
    private OrderRepository orderRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private MongoTemplate mongoTemplate;
    @Override
    public List<ObjectId> getUserOrderLines(String userId) {

        User user = userRepository.getUserById(userId);
        List<ObjectId> lines = user.getOrderLine();

        if(lines == null) {
            lines = new ArrayList<>();
            user.setOrderLine(lines);
            userRepository.save(user);
        }

        return lines;
    }

    @Override
    public void createOrderLineForUser(String userId, List<Order> orders) {

        User user = userRepository.getUserById(userId);
        List<ObjectId> orderLines = getUserOrderLines(userId);

        OrderLine newOrderLine = mongoTemplate.insert(new OrderLine(), "orderlines");
        orderLines.add(new ObjectId(newOrderLine.getId()));

        newOrderLine.setOrders(orders);
        user.setOrderLine(orderLines);

        userRepository.save(user);
        orderRepository.save(newOrderLine);
    }

}
