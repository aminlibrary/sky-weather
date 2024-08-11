import 'package:flutter/material.dart';
import 'package:weather_app/core/constants/colors.dart';

class ContainerWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final double? borderRadius;
  final Color? color;
  final Widget child;
  const ContainerWidget(
      {this.width,
      this.height,
      this.borderRadius,
      this.color,
      required this.child,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                color: color ?? whiteColor,
                borderRadius: BorderRadius.circular(borderRadius ?? 15)),
          ),

          //* child
          SizedBox(width: width, height: height, child: child)
        ],
      ),
    );
  }
}
