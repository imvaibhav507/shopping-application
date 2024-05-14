import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/utils/custom_image_view.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/screens/cart/controller/cart_controller.dart';
import '../../models/orders.dart';
import 'components/cart_card.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartController controller = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              "Your Cart",
              style: TextStyle(color: Colors.black),
            ),
            Obx(
              () => (controller.isLoading.isFalse)
                  ? Text(
                      "${controller.cartModelObj.value.cartItems?.length} items",
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  : const Text(''),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Obx(() {
          if (controller.isLoading.isTrue) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var items = controller.cartModelObj.value.cartItems;
          if (items == null || items.isEmpty) {
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 200,
                      color: Colors.grey,
                        child: CustomImageView(imagePath: "assets/icons/empty cart.png",)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Your cart is empty", style: Theme.of(context).textTheme.titleLarge),
                    ),
                  ],
                ));
          }
          return ListView.builder(
            itemCount: items.length ?? 0,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Dismissible(
                key: Key(items[index].itemId.toString()),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  // setState(() {
                  //   demoCarts.removeAt(index);
                  // });
                },
                background: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE6E6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const Spacer(),
                      SvgPicture.asset("assets/icons/Trash.svg"),
                    ],
                  ),
                ),
                child: CartCard(cartItem: items[index]),
              ),
            ),
          );
        }),
      ),
      bottomNavigationBar:
      Obx(() {
        var items = controller.cartModelObj.value.cartItems;
        if(items == null || items.isEmpty) {
          return const SizedBox(height: 20,);
        }
        RxInt itemTotal = 0.obs;
        items.forEach((item) {
          itemTotal += (int.parse(item.price!) * item.quantity!);
        });
        final orders = createOrder(items, itemTotal.value);

        return CheckoutCard(
          itemTotal: itemTotal.toString(),
          orders: orders);
      }),
    );
  }

  List<Order> createOrder(List<CartItem>? items, int itemTotal) {
    if(items == null) {
      return <Order>[];
    }
    List<Order> orders = <Order>[];
    for (var item in items) {
      final order = Order(
        orderId: uuid.v1(),
        date: DateTime.now().toString(),
        productItem: item.productItem,
        quantity: item.quantity,
        totalPrice: itemTotal);
      orders.add(order);
    }
    return orders;
  }
}
