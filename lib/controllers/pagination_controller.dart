import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaginationController extends GetxController {
  static PaginationController get instance => Get.find();

  final ScrollController scrollController = ScrollController();
  
 RxBool isLoading = false.obs;
}
