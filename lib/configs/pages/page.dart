import 'package:flutter_java_code_app/configs/routes/route.dart';
import 'package:flutter_java_code_app/features/checkout/bindings/checkout_binding.dart';
import 'package:flutter_java_code_app/features/checkout/sub_features/voucher/view/ui/voucher_detail.dart';
import 'package:flutter_java_code_app/features/checkout/sub_features/voucher/view/ui/voucher_screen.dart';
import 'package:flutter_java_code_app/features/checkout/view/ui/checkout_screen.dart';
import 'package:flutter_java_code_app/features/evaluation/bindings/evaluation_binding.dart';
import 'package:flutter_java_code_app/features/evaluation/sub_features/chat_rating/view/ui/chat_rating_screen.dart';
import 'package:flutter_java_code_app/features/evaluation/view/ui/create_evaluation_screen.dart';
import 'package:flutter_java_code_app/features/evaluation/view/ui/evaluation_screen.dart';
import 'package:flutter_java_code_app/features/get_location/bindings/get_location_binding.dart';
import 'package:flutter_java_code_app/features/get_location/view/ui/get_location_screen.dart';
import 'package:flutter_java_code_app/features/home_page/bindings/home_page_binding.dart';
import 'package:flutter_java_code_app/features/home_page/sub_features/menu_details/view/ui/menu_details_screen.dart';
import 'package:flutter_java_code_app/features/home_page/sub_features/promo_details/view/ui/promo_details_screen.dart';
import 'package:flutter_java_code_app/features/main_page/bindings/main_page_binding.dart';
import 'package:flutter_java_code_app/features/main_page/view/ui/main_page_screen.dart';
import 'package:flutter_java_code_app/features/order/bindings/order_binding.dart';
import 'package:flutter_java_code_app/features/order/sub_features/order_again/view/ui/order_again_screen.dart';
import 'package:flutter_java_code_app/features/order/sub_features/order_details/view/ui/order_details_screen.dart';
import 'package:flutter_java_code_app/features/order/view/ui/order_screen.dart';
import 'package:flutter_java_code_app/features/profile/bindings/profile_binding.dart';
import 'package:flutter_java_code_app/features/profile/view/ui/profile_screen.dart';
import 'package:flutter_java_code_app/features/sign_in/bindings/sign_in_binding.dart';
import 'package:flutter_java_code_app/features/sign_in/view/ui/sign_in_screen.dart';
import 'package:flutter_java_code_app/features/splash/bindings/splash_binding.dart';
import 'package:flutter_java_code_app/features/splash/view/ui/splash_screen.dart';
import 'package:get/get.dart';

abstract class Pages {
  static final pages = [
    // Splash
    GetPage(
      name: Routes.splashRoute,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),

    // Sign In
    GetPage(
        name: Routes.signInRoute,
        page: () => SignInScreen(),
        binding: SignInBinding(),
        transition: Transition.fadeIn),

    // Get Location
    GetPage(
      name: Routes.getLocationRoute,
      page: () => const GetLocationScreen(),
      binding: GetLocationBinding(),
    ),

    // Main Page
    GetPage(
      name: Routes.mainPageRoute,
      page: () => MainPageScreen(),
      binding: MainPageBinding(),
    ),

    // Profile
    GetPage(
      name: Routes.profileRoute,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
    ),

    // Evaluation
    GetPage(
      name: Routes.evaluationRoute,
      page: () => EvaluationScreen(),
      binding: EvaluationBinding(),
    ),

    // Create Evaluation
    GetPage(
      name: Routes.createEvaluationRoute,
      page: () => const CreateEvaluationScreen(),
      binding: EvaluationBinding(),
    ),

    // Evaluation Chat Rating
    GetPage(
      name: Routes.evaluationChatRatingRoute,
      page: () => const ChatRatingScreen(),
      binding: EvaluationChatBinding(),
    ),

    // Order
    GetPage(
      name: Routes.orderRoute,
      page: () => OrderScreen(),
      binding: OrderBinding(),
    ),

    // Order Details
    GetPage(
      name: Routes.orderOrderDetailsRoute,
      page: () => const OrderDetailsScreen(),
      binding: OrderDetailsBinding(),
    ),

    // Order Again
    GetPage(
      name: Routes.orderOrderAgainRoute,
      page: () => OrderAgainScreen(),
      binding: OrderAgainBinding(),
    ),

    // Promo Details
    GetPage(
      name: Routes.homePagePromoDetailsRoute,
      page: () => const PromoDetailScreen(),
      binding: HomePagePromoDetailsBinding(),
    ),

    // Menu Details
    GetPage(
      name: Routes.homePageMenuDetailsRoute,
      page: () => const MenuDetailsScreen(),
      binding: HomePageMenuDetailsBinding(),
    ),

    // Checkout
    GetPage(
      name: Routes.checkoutRoute,
      page: () => CheckoutScreen(),
      binding: CheckoutBinding(),
    ),

    // Checkout Voucher
    GetPage(
      name: Routes.checkoutVoucherRoute,
      page: () => VoucherScreen(),
      binding: CheckoutBinding(),
    ),

    // Checkout Voucher Detail
    GetPage(
      name: Routes.checkoutVoucherDetailRoute,
      page: () => const VoucherDetail(),
      binding: CheckoutBinding(),
    ),
  ];
}
