import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static void showShortToast({required String message, bool isError = true}) {
    _showToast(
      message,
      Toast.LENGTH_SHORT,
      ToastGravity.BOTTOM,
      isError,
    );
  }

  static void showShortToastFromBackEnd(
      {required String message, bool isError = true}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.yellow,
        fontSize: 16.0);
  }

  static void showLongToast({required String message, bool isError = true}) {
    _showToast(message, Toast.LENGTH_LONG, ToastGravity.BOTTOM, isError);
  }

  static void _showToast(
      String message, Toast length, ToastGravity? gravity, isError) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: length,
        gravity: gravity,
        backgroundColor: isError ? Colors.red : Colors.green,
        fontSize: 16.0);
  }
}
