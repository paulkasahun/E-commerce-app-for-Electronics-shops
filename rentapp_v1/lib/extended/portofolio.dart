import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/globalvariables.dart';
import '../features/auth/screens/auth_screen.dart';

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
                  backgroundImage: AssetImage(
                    'assets/images/paul.jpg',
                  ),
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
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.login),
                title: const Text('Sign In'),
                onTap: () {
                  Navigator.pushNamed(context, AuthScreen.routeName);
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('About'),
                onTap: () {},
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

class Portofolio extends StatelessWidget {
  const Portofolio({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24 + MediaQuery.of(context).padding.top),
      child: Scaffold(
        drawer: const NavigationDrawer(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: const Text("Dynamo Center for Technology"),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Container(
              padding: EdgeInsets.only(
                top: 24 + MediaQuery.of(context).padding.top,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Drawer(
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 1.23,
                            child: Container(
                              color: GlobalVariables.backgroundColor,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                      top: 24 +
                                          MediaQuery.of(context).padding.top,
                                    ),
                                    child: const CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          AssetImage('assets/images/D.jpg'),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Dynamo Center for Technology',
                                      style: GoogleFonts.robotoSerif(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const Text("We Empower Makers of Tomorrow !")
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
