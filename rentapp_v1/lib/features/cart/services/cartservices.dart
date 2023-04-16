import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:rentapp_v1/constants/error_handle.dart';
import 'package:rentapp_v1/constants/globalvariables.dart';
import 'package:rentapp_v1/constants/utils.dart';
import 'package:rentapp_v1/models/product.dart';
import 'package:rentapp_v1/models/user.dart';
import 'package:rentapp_v1/providers/user_provider.dart';
import 'package:http/http.dart' as http;

class CartServices {
  void removeFromCart({
    required context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/remove-from-cart/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          User user =
              userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
