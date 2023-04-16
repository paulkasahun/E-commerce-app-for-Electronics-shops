import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:rentapp_v1/constants/error_handle.dart';
import 'package:rentapp_v1/constants/globalvariables.dart';
import 'package:rentapp_v1/constants/utils.dart';
import 'package:rentapp_v1/models/product.dart';
import 'package:rentapp_v1/providers/user_provider.dart';

class SearchServices {
  
  Future<List<Product>> fetchSearchedProduct({
    required  context,
    required String searchQuery,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/products/search/$searchQuery'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }
}
