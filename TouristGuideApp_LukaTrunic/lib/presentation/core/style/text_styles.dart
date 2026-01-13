import 'package:flutter/material.dart';

const _subtitleTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
const _textFieldTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
const _buttonTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
const _labelTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
const _titleTextStyle = TextStyle(fontSize: 28, fontWeight: FontWeight.bold);

extension CustomTextStyle on TextTheme {
  TextStyle get subtitleTextStyle => _subtitleTextStyle;
  TextStyle get textFieldTextStyle => _textFieldTextStyle;
  TextStyle get buttonTextStyle => _buttonTextStyle;
  TextStyle get labelTextStyle => _labelTextStyle;
  TextStyle get titleTextStyle => _titleTextStyle;
}
