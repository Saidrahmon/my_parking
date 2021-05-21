import 'package:get/get.dart';
import 'package:parkovka/pages/home/controllers/HomeController.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }

}