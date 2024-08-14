import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pagination/controllers/pagination_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final PaginationController controller = Get.put(PaginationController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Obx(
        () => ListView.builder(
          controller: controller.scrollController,
          itemCount: controller.products.length,
          itemBuilder: (BuildContext context, int index) {
            final product = controller.products[index];
            return Column(
              children: [
                ListTile(
                  tileColor: index.isEven
                      ? Colors.grey.shade100
                      : Colors.grey.shade200,
                  leading: Text(product.id.toString()),
                  title: Text(product.title ?? 'No Title'),
                  subtitle:
                      Text('\$${product.price?.toStringAsFixed(2) ?? '0.00'}'),
                  trailing: product.thumbnail != null
                      ? Image.network(product.thumbnail!)
                      : const Icon(Icons.image_not_supported),
                ),
                if (index == controller.products.length - 1 &&
                    controller.isLoading.value)
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.purple,
                      size: 60,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
