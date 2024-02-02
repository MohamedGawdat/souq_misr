import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeProvider with ChangeNotifier {
  late PersistentTabController controller;

  moveToTap(int index) {
    if (controller.index != index) {
      controller.jumpToTab(index);
      notifyListeners();
    }
  }
}
