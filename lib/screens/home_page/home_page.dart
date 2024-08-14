import 'package:flutter/material.dart';
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
            return ListTile(
              title: Text(
                controller.products[index].title.toString(),
              ),
            );
          },
        ),
      ),
    );
  }
}
