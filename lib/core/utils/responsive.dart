import 'package:flutter/material.dart';

extension ScreenUtils on BuildContext {
  //? screen width
  get width => MediaQuery.sizeOf(this).width;

  //? screen height
  get height => MediaQuery.sizeOf(this).height;
}
