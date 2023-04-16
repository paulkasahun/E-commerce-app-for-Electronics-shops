import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:rentapp_v1/constants/error_handle.dart';
import 'package:rentapp_v1/constants/globalvariables.dart';
import 'package:rentapp_v1/constants/utils.dart';
import 'package:rentapp_v1/models/product.dart';
import 'package:rentapp_v1/providers/user_provider.dart';
import 'package:http/http.dart' as http;

class HomeService {
  Future<Product> fetchDealOfDay({
    required context,
  }) async {
    final token = Provider.of<UserProvider>(context, listen: false).user.token;
    Product product = Product(
      name: '',
      description: '',
      quantity: 0,
      images: [],
      category: '',
      price: 0,
    );

    try {
      http.Response dres = await http.get(
        Uri.parse('$uri/api/deal-of-day'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'x-auth-token': token,
        },
      );
      httpErrorHandler(
        response: dres,
        context: context,
        onSuccess: () {
          product = Product.fromJson(dres.body);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return product;
  }

  Future<List<Product>> fetchCategoryProducts({
    required context,
    required String category,
  }) async {
    final token = Provider.of<UserProvider>(context, listen: false).user.token;
    List<Product> prodList = [];
    try {
      http.Response cres = await http.get(
        Uri.parse('$uri/api/products?category=$category'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'x-auth-token': token,
        },
      );
      httpErrorHandler(
        response: cres,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(cres.body).length; i++) {
            prodList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(cres.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return prodList;
  }
}
