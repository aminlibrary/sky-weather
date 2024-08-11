import 'package:flutter/material.dart';

class BottomNavProvider extends ChangeNotifier {
  //* init index
  int index = 0;

  //* toggle index
  void toggleIndex(int pageIndex) {
    //* set index
    index = pageIndex;

    //* update state
    notifyListeners();
  }
}
