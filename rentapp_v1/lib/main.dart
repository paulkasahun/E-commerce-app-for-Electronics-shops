import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentapp_v1/common/btm_bar.dart';
import 'package:rentapp_v1/constants/globalvariables.dart';
import 'package:rentapp_v1/extended/home_page.dart';
import 'package:rentapp_v1/features/admin/screen/admin_screen.dart';
import 'package:rentapp_v1/features/auth/services/auth_service.dart';
import 'package:rentapp_v1/providers/user_provider.dart';
import 'package:rentapp_v1/router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

/// get data from shared preferences
/// inorder to switch between different pages

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => generateRoute(settings),
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        useMaterial3: true,
      ),
      home: user.token.isNotEmpty
          ? user.type == "user"
              ? const BottomBar()
              : const AdminScreen()
          : const Homepage(),
    
    );
  }
}
