import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentapp_v1/constants/globalvariables.dart';
import 'package:rentapp_v1/features/admin/services/admin_service.dart';
import 'package:rentapp_v1/models/product.dart';
import 'package:rentapp_v1/providers/user_provider.dart';

class Test extends StatefulWidget {
  static const String routeName = '/test';
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final AdminService adminService = AdminService();
  List<Product>? prdlst;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    //  final user = context.watch<UserProvider>().user;
    double sum = 0.0;
    user.cart
        .map(
          (e) => sum += e['quantity'] * e['product']['price'] * 0.15,
        )
        .toList();
    return Scaffold(
      body: Center(
        child: Text(
          sum.toString(),
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: const Text(
              "Add Product",
              style: TextStyle(color: Colors.black),
            )),
      ),
    );
  }
}
