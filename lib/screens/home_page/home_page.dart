import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
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
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: SpinKitThreeBounce(
                      color: Colors.purple,
                      size: 40,
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
