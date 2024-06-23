import 'package:flutter/material.dart';

// ignore: camel_case_types
class txt extends StatelessWidget {
  final String text;
  final Color? color;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final double? size;
  final TextAlign? textAlign;
  const txt(this.text,
      {super.key,
      this.color,
      this.fontFamily,
      this.fontWeight,
      this.size,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          color: color ?? Colors.white,
          fontFamily: "poppins",
          fontWeight: fontWeight,
          fontSize: size),
    );
  }
}
