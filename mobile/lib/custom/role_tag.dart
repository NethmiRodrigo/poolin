import 'package:flutter/material.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/icons.dart';

class UserRoleTag {
  static Widget driver = Wrap(
    crossAxisAlignment: WrapCrossAlignment.center,
    alignment: WrapAlignment.start,
    spacing: 10.0,
    children: const [
      Icon(
        BlipIcons.driver,
        color: BlipColors.black,
        size: 12.0,
      ),
      Text(
        'Driver',
        style: BlipFonts.outline,
      ),
    ],
  );
  static Widget rider = Wrap(
    crossAxisAlignment: WrapCrossAlignment.center,
    alignment: WrapAlignment.start,
    spacing: 10.0,
    children: const [
      Icon(
        BlipIcons.rider,
        color: BlipColors.black,
        size: 12.0,
      ),
      Text(
        'Rider',
        style: BlipFonts.outline,
      ),
    ],
  );
}
