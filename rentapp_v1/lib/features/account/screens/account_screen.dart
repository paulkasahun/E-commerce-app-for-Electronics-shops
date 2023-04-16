import 'package:flutter/material.dart';
import 'package:rentapp_v1/constants/globalvariables.dart';
import 'package:rentapp_v1/features/account/widgets/below_appbar.dart';
import 'package:rentapp_v1/features/account/widgets/orders.dart';
import 'package:rentapp_v1/features/account/widgets/top_btns.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          BelowAppBar(),
          SizedBox(
            height: 10,
          ),
          TopButtons(),
          SizedBox(
            height: 20,
          ),
          Orders(),
        ],
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(
                    "assets/images/D.jpg",
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Icon(Icons.notifications_outlined),
                    ),
                    Icon(
                      Icons.search,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
