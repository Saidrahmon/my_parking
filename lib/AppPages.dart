import 'package:get/get.dart';
import 'package:parkovka/AppRoutes.dart';
import 'package:parkovka/pages/home/bindings/HomeBinding.dart';
import 'package:parkovka/pages/home/views/home_view.dart';
import 'package:parkovka/pages/payment/bindings/PaymentBinding.dart';
import 'package:parkovka/pages/payment/views/PaymentView.dart';

class AppPages{
  static List<GetPage> pages = [
    GetPage(name: AppRoutes.home, page: () => HomeView(), binding: HomeBinding()),
    GetPage(name: AppRoutes.payment, page: () => PaymentView(), binding: PaymentBinding())
  ];
}