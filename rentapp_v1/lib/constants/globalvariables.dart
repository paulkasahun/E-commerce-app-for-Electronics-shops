import 'package:flutter/material.dart';

// 192.168.0.105  wifi
// String uri = 'http://192.168.1.101:5000';

// Ethernet
// String uri = 'http://10.140.77.24:5000';
// String uri = 'http://192.168.43.133:5000';

// String uri = 'http://192.168.43.133:5000';
// 10.140.77.23
// 10.141.215.129
// 192.168.1.105
// String uri = 'http://10.141.215.129:5000';

// String uri = 'http://192.168.1.105:5000';
// String uri = 'http://192.168.1.101:5000';
 String uri = 'https://shop-electronics.onrender.com';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;

  // STATIC IMAGES
  static const List<String> carouselImages = [
    'https://images.unsplash.com/photo-1629739884942-8678d138dd64?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    'https://images.unsplash.com/photo-1586920740099-f3ceb65bc51e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1931&q=80',
    'https://makershop.ie/image/cache/catalog/p/00082/000-1100x1100.png',
    'https://uk.farnell.com/productimages/large/en_GB/2281679-40.jpg',
    'https://www.rcecho.com/images/leopard-outrunner-lc700-motor-500kv_om065_01.jpg',
    'https://cdn-shop.adafruit.com/1200x900/4664-03.jpg',
    'https://i0.wp.com/www.htebd.com/wp-content/uploads/2021/07/ultrasonic-sonar-sensor-hc-sr04-2.jpg?w=800&ssl=1'
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Arduino',
      'image': 'assets/images/arduino.png',
    },
    {
      'title': 'Raspberry Pi',
      'image': 'assets/images/raspi.png',
    },
    {
      'title': 'Motors',
      'image': 'assets/images/motor.png',
    },
    {
      'title': 'Relays',
      'image': 'assets/images/relay.png',
    },
    {
      'title': 'LCD',
      'image': 'assets/images/lcd.png',
    },
    {
      'title': 'Sensors',
      'image': 'assets/images/sensor.png',
    },
  ];
}
