import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentapp_v1/constants/error_handle.dart';
import 'package:rentapp_v1/constants/globalvariables.dart';
import 'package:rentapp_v1/constants/utils.dart';
import 'package:rentapp_v1/models/order.dart';
import 'package:rentapp_v1/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:rentapp_v1/models/sales.dart';
import 'package:rentapp_v1/providers/user_provider.dart';

class AdminService {
  Future<Map<String, dynamic>> getEarnings(context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    int totalEarning = 0;
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/analytics'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          var response = jsonDecode(res.body);
          totalEarning = response['totalEarnings'];
          sales = [
            Sales('Arduino', response['arduinoEarnings']),
            Sales('Raspberry Pi', response['raspiEarnings']),
            Sales('Motors', response['motorEarnings']),
            Sales('Relays', response['relayEarnings']),
            Sales('LCD', response['lcdEarnings']),
            Sales('Sensors', response['sensorEarnings']),
          ];
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return {
      'sales': sales,
      'totalEarnings': totalEarning,
    };
  }

  void changeOrderStatus({
    required context,
    required int status,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/change-order-status'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': order.id,
          'status': status,
        }),
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: onSuccess,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Order>> fetchAllOrders(context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-orders'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            orderList.add(
              Order.fromJson(
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
    return orderList;
  }

  //delet product
  Future<void> deleteProduct({
    required context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final token = Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'x-auth-token': token,
        },
        body: jsonEncode(
          {'id': product.id},
        ),
      );

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

//fetch all products to the post screen

  Future<List<Product>> fetchAllProducts(context) async {
    List<Product> productList = [];
    final token = Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      http.Response pres = await http.get(
        Uri.parse('$uri/admin/get-products'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'x-auth-token': token,
        },
      );

      httpErrorHandler(
        response: pres,
        context: context,
        onSuccess: () {
          //convert pres(list of product in json) i.e json format to model
          for (int i = 0; i < jsonDecode(pres.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(pres.body)[i],
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

  void rentProduct({
    required context,
    required String name,
    required description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    //duaencmcr
    //uoapqzyo
    final token = Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      final cloudinary = CloudinaryPublic(
        'duaencmcr',
        'uoapqzyo',
      );
      List<String> imageUrls = [];
      for (var i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            images[i].path,
            folder: name,
          ),
        );
        imageUrls.add(res.secureUrl); //url to mongodb
      }
      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );
      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'x-auth-token': token,
        },
        body: product.toJson(),
      );
      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Product added successfully.");
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }
}
