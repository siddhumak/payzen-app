import 'package:get/get.dart';

class MainController extends GetxController {
  RxInt currentIndex = 0.obs;
  var selectedTabIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
    selectedTabIndex.value = index;
  }
}
