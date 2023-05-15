import 'package:flutter/material.dart';

class TextStyles {
  static const TextStyle appNameTextStyle = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle defaultTextStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.normal,
  );

  static TextStyle defaultLightTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: Colors.grey.shade500,
  );

  static const TextStyle defaultBoldTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle completedTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.blueGrey,
    decoration: TextDecoration.lineThrough,
  );

  static const TextStyle lightText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle headerTextStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const headerName = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );
}
