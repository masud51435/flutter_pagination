import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pagination/model/product_model.dart';
import 'package:http/http.dart' as http;

class PaginationController extends GetxController {
  static PaginationController get instance => Get.find();

  final ScrollController scrollController = ScrollController();

  RxBool isLoading = false.obs;
  RxList<Products> products = RxList<Products>();
  RxInt totalProducts = 500.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProducts();
    scrollController.addListener(loadMore);
  }

  void loadMore() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        products.length < totalProducts.value) {
      getProducts();
    }
  }

  Future<void> getProducts() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(
          'https://dummyjson.com/products?limit=11&skip=${products.length}&select=title,price,thumbnail',
        ),
      );
      if (response.statusCode == 200) {
        var productItems = jsonDecode(response.body);
        var items = ProductModel.fromJson(productItems);
        totalProducts.value = items.total!;
        isLoading.value = false;
        products.addAll(items.products!);
      }
    } catch (e) {
      throw e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
