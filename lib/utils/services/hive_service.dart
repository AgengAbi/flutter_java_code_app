import 'package:flutter_java_code_app/features/checkout/sub_features/voucher/models/voucher.dart';
import 'package:flutter_java_code_app/features/evaluation/models/rating.dart';
import 'package:flutter_java_code_app/features/home_page/models/menu.dart';
import 'package:flutter_java_code_app/features/home_page/models/menu_ui.dart';
import 'package:flutter_java_code_app/features/home_page/models/promo.dart';
import 'package:flutter_java_code_app/features/home_page/sub_features/promo_details/models/promo_details.dart';
import 'package:flutter_java_code_app/features/order/models/order_model.dart';
import 'package:flutter_java_code_app/features/order/sub_features/order_details/models/order_detail_model.dart';
import 'package:flutter_java_code_app/features/profile/models/user.dart';
import 'package:flutter_java_code_app/features/sign_in/models/user_auth.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService extends GetxService {
  LocalStorageService._();
  static late Box<String> authToken;
  static late Box<UserAuth> userAuthBox; // * typeId: 0
  static late Box<User> userBox; // * typeId: 1
  static late Box<Promo> promoBox; // * typeId: 2
  static late Box<PromoDetails> promoDetailBox; // * typeId: 3
  static late Box<Menu> menuBox; // * typeId: 4
  static late Box<MenuUI> menuUIBox; // * typeId: 5
  // Level * typeId 6
  // Topping * typeId 7
  static late Box<OrderModel> orderAPIBox; // * typeId: 8
  static late Box<MenuModel> menuOrderAPIBox; // * typeId: 9
  static late Box<OrderDetailModel> menuOrderDetailAPIBox; // * typeId: 10
  static late Box<Voucher> voucherBox; // * typeId: 11
  static late Box<Rating> ratingBox; // * typeId: 12
  static late Box<String> languageBox;

  // Declare all model that needed
  static Future<void> initHive() async {
    // List model adapter
    Hive.registerAdapter(UserAuthAdapter());
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(RatingAdapter());

    // Open box that are needed
    // user
    userAuthBox = await Hive.openBox<UserAuth>('userAuthBox');
    userBox = await Hive.openBox<User>('userBox');
    authToken = await Hive.openBox<String>('authToken');
    if (!Hive.isBoxOpen('languageBox')) {
      languageBox = await Hive.openBox<String>('languageBox');
    } else {
      languageBox = Hive.box<String>('languageBox');
    }
    ratingBox = await Hive.openBox<Rating>('ratingBox');

    if (languageBox.get('language') == null) {
      await languageBox.put('language', "Indonesia");
    }
  }

  static Future<void> deleteAll() async {
    await userAuthBox.clear();
    await userBox.clear();
    await authToken.clear();
    await languageBox.clear();
    await ratingBox.clear();
  }

  // UserAuth
  static Future<void> setUserAuth(UserAuth user) async {
    await userAuthBox.clear();
    await userAuthBox.put('user', user);
  }

  static UserAuth? getUserAuth() {
    return userAuthBox.get('user');
  }

  static Future<void> setAuthToken(String token) async {
    await authToken.clear();
    await authToken.put('authToken', token);
  }

  static String? getAuthToken() {
    return authToken.get('authToken');
  }

  // * Profile user
  static Future<void> setUser(User user) async {
    await userBox.clear();
    await userBox.put('user', user);
  }

  static User? getUser() {
    return userBox.get('user');
  }

  static Future<void> deleteUser() async {
    await userBox.delete('user');
  }

  // Language methods
  static Future<void> setLanguage(String language) async {
    await languageBox.put('language', language);
  }

  static String getLanguage() {
    // Mengembalikan bahasa yang tersimpan atau default "Indonesia"
    return languageBox.get('language') ?? "Indonesia";
  }
}
