import 'package:flutter/material.dart';
import 'package:rentapp_v1/extended/about.dart';
import 'package:rentapp_v1/extended/default_btm.dart';
import 'package:rentapp_v1/features/account/screens/account_screen.dart';
import 'package:rentapp_v1/features/admin/screen/admin_screen.dart';
import 'package:rentapp_v1/features/auth/screens/auth_screen.dart';

import '../constants/globalvariables.dart';

class Homepage extends StatelessWidget {
  static const String routeName = 'home-page';
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      drawer: const NavigationDrawer(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      bottomNavigationBar: const DefaultBtmBar(),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildHeader(context) => Container(
          color: Colors.blue.shade700,
          padding: EdgeInsets.only(
            top: 24 + MediaQuery.of(context).padding.top,
            bottom: 24,
          ),
          child: Column(
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: const CircleAvatar(
                  radius: 52,
                  // backgroundImage: AssetImage(
                  //   'assets/images/paul.jpg',
                  // ),
                ),
              ),
            ],
          ),
        );
    Widget buildMenuItems(context) => Container(
          padding: const EdgeInsets.all(24),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text('Home'),
                onTap: () {
                  // Navigator.pushNamed(context, AuthScreen.routeName);
                },
              ),
              ListTile(
                leading: const Icon(Icons.login),
                title: const Text('Sign In'),
                onTap: () {
                  Navigator.pushNamed(context, AuthScreen.routeName);
                },
              ),
              GestureDetector(
                child: ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('About'),
                  onTap: () {
                    Navigator.pushNamed(context, AboutScreen.routeName);
                  },
                ),
              ),
            ],
          ),
        );
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildHeader(context),
          buildMenuItems(context),
        ],
      ),
    );
  }
}
