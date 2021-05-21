import 'package:get/get.dart';
import 'package:parkovka/pages/payment/controllers/PaymentController.dart';

class PaymentBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentController());
  }
}