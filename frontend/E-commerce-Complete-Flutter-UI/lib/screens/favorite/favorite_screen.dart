import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/favorite/components/favourite_item_card.dart';
import 'package:shop_app/screens/favorite/controller/favourites_controller.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});

  FavouritesController controller = Get.put(FavouritesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorites",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Obx(
                  () => (controller.isLoading.isFalse)
                      ? GridView.builder(
                          itemCount: controller.productItemListObj.value
                                  .productItemList?.length ??
                              0,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 0.53,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 16,
                          ),
                          itemBuilder: (context, index) => FavouriteItemCard(
                            product: controller.productItemListObj.value
                                .productItemList![index],
                            onPress: () {
                              final item = controller.productItemListObj.value
                                  .productItemList![index];
                              Get.toNamed(AppRoutes.detailsScreen,
                                  arguments: item);
                            },
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
