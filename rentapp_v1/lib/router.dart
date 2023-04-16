import 'package:flutter/material.dart';
import 'package:rentapp_v1/common/btm_bar.dart';
import 'package:rentapp_v1/extended/about.dart';
import 'package:rentapp_v1/features/address/screen/addresscreen.dart';
import 'package:rentapp_v1/features/admin/screen/add_product_screen.dart';
import 'package:rentapp_v1/features/auth/screens/auth_screen.dart';
import 'package:rentapp_v1/features/home/screens/category_dealscreen.dart';
import 'package:rentapp_v1/features/home/screens/home_screen.dart';
import 'package:rentapp_v1/features/order_details/screen/detail_screen.dart';
import 'package:rentapp_v1/features/produDetails/screens/prod_detail.dart';
import 'package:rentapp_v1/features/search/screen/search_screen.dart';
import 'package:rentapp_v1/models/product.dart';
import 'package:rentapp_v1/test/test.dart';

import 'models/order.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case OrderDetailScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailScreen(
          order: order,
        ),
      );
    case Test.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Test(),
      );
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      // var rentalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(
          totalAmount: totalAmount,
          // rentalAmount: rentalAmount,
        ),
      );
    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailScreen(
          product: product,
        ),
      );
    case AboutScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AboutScreen(),
      );
    case SearchScreen.routName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(searchQuery: searchQuery),
      );
    case CategoryDealScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealScreen(category: category),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const AddProductScreen(),
        settings: routeSettings,
      );
    case BottomBar.routerName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Center(
          child: Text("Page not found"),
        ),
      );
  }
}
