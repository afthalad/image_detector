// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../../../core/configs/routes.dart';

class Redirector {
  void iniRedirect(BuildContext context) async {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
    });
  }

  void pushNameRedirect(context, routeName) {
    Navigator.pushNamed(context, routeName);
  }
}
