import 'package:flutter/material.dart';

const _subtitleTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
const _textFieldTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);

extension CustomTextStyle on TextTheme {
  TextStyle get subtitleTextStyle => _subtitleTextStyle;
  TextStyle get textFieldTextStyle => _textFieldTextStyle;
}