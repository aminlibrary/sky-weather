import 'package:flutter/material.dart';

// ignore: camel_case_types
class txt extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final String? fontFamily;

  const txt(this.text,
      {this.size,
      this.color,
      this.fontWeight,
      this.textAlign,
      this.fontFamily,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontFamily: fontFamily ?? "poppins",
        fontWeight: fontWeight,
      ),
    );
  }
}
