import 'package:flutter/material.dart';
import 'package:rentapp_v1/extended/portofolio.dart';

import '../constants/globalvariables.dart';

class DefaultBtmBar extends StatefulWidget {
  const DefaultBtmBar({super.key});

  @override
  State<DefaultBtmBar> createState() => _DefaultBtmBarState();
}

class _DefaultBtmBarState extends State<DefaultBtmBar> {
  int _page = 0;
  double bottombarborderwidth = 5;
  double bottomBarwidth = 42;
  List<Widget> pages = [
    const Portofolio(),
  ];
  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final userCartLen = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        // elevation: 0,
        onTap: updatePage,
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        iconSize: 40,
        items: [
          //home
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarwidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottombarborderwidth,
                  ),
                ),
              ),
              child: const Icon(Icons.home_outlined),
            ),
            label: '',
          ),
          //account
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarwidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottombarborderwidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.person_outlined,
              ),
            ),
            label: '',
          ),
          //cart
        ],
      ),
    );
  }
}
