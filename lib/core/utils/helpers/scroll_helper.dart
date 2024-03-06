import 'package:flutter/material.dart';

class ScrollHelper {
  static ScrollController listScrollController = ScrollController();
  static scrollToBottom() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (listScrollController.hasClients) {
        final position = listScrollController.position.maxScrollExtent;
        listScrollController.animateTo(
          position,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
