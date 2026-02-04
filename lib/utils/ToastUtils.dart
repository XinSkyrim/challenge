import 'package:flutter/material.dart';

class ToastUtils {

  static bool isShowing = false;

  static void showToast(BuildContext context, String? message) {
    if (isShowing) return;

    isShowing = true;

    Future.delayed(const Duration(seconds: 3), () {
      isShowing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 180,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        content: Text(
          message ?? "Success",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
