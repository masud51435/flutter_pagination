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

  @override
  void onInit() {
    // TODO: implement onInit
    getProducts();
    super.onInit();

    scrollController.addListener(loadMore);
  }

  void loadMore() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      getProducts();
    }
  }

  Future<void> getProducts() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(
          'https://dummyjson.com/products?limit=10&skip=${products.length}&select=title,price,thumbnail',
        ),
      );
      if (response.statusCode == 200) {
        var productItems = jsonDecode(response.body);
        var items = ProductModel.fromJson(productItems);
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
