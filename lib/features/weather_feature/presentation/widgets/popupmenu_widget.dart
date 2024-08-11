import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_app/core/constants/colors.dart';
import 'package:weather_app/core/constants/urls.dart';
import 'package:weather_app/core/widgets/txt.dart';

class PopupmenuWidget extends StatelessWidget {
  const PopupmenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        iconColor: whiteColor,
        iconSize: 30,
        itemBuilder: (context) {
          return [
            popupMenuItem(CupertinoIcons.star, "Rate me", () {
              //* open browser
              launchUrl(
                Uri.parse(webContactUrl),
              );
            }),
            popupMenuItem(CupertinoIcons.phone, "Contact me", () {
              //* open browser
              launchUrl(Uri.parse(webContactUrl));
            }),
            popupMenuItem(CupertinoIcons.person, "About me", () {
              //* open browser
              launchUrl(Uri.parse(webHomeUrl));
            }),
          ];
        });
  }
}

PopupMenuItem popupMenuItem(IconData icon, String title, Function()? onTap) {
  return PopupMenuItem(
      child: ListTile(
    leading: Icon(icon),
    title: txt(title),
    onTap: onTap,
  ));
}
