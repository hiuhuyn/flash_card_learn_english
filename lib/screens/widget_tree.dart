import 'dart:async';

import 'package:flutter/material.dart';

import '../components/router/route_name.dart';
import '../data/firebase/auth.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    if (Auth.currentUser == null) {
      Timer(const Duration(seconds: 1), () {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteName.login, (route) => false);
      });
    } else {
      Timer(const Duration(seconds: 1), () {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteName.homePage, (route) => false);
      });
    }

    return Container(
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
      color: Colors.white,
      child: const SizedBox(
          height: 50,
          width: 50,
          child:
              CircularProgressIndicator(backgroundColor: Colors.transparent)),
    );
  }
}
