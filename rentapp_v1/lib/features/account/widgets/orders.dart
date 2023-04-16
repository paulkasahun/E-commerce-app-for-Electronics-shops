import 'package:flutter/material.dart';
import 'package:rentapp_v1/constants/globalvariables.dart';
import 'package:rentapp_v1/constants/loader.dart';
import 'package:rentapp_v1/features/account/services/services.dart';
import 'package:rentapp_v1/features/account/widgets/single_product.dart';
import 'package:rentapp_v1/features/order_details/screen/detail_screen.dart';
import 'package:rentapp_v1/models/order.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  AccountServices accountServices = AccountServices();

  List<Order>? orders;
  @override
  void initState() {
    super.initState();
    fetchorders();
  }

  void fetchorders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 15,
                      ),
                      child: const Text(
                        "Your Orders",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        right: 15,
                      ),
                      child: Text(
                        "See All",
                        style: TextStyle(
                          color: GlobalVariables.selectedNavBarColor,
                        ),
                      ),
                    ),
                  ],
                ),
                //display orderd products
                Container(
                  height: 170,
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 0,
                    top: 20,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: orders!.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            OrderDetailScreen.routeName,
                            arguments: orders![index],
                          );
                        },
                        child: SingleProduct(
                          image: orders![index].products[0].images[0],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          );
  }
}
