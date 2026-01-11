import 'package:flutter/material.dart';
import 'package:tourist_guide_app/presentation/style/colors.dart';
import 'package:tourist_guide_app/presentation/style/text_styles.dart';

extension StyleExtention on BuildContext {
  Color get colorGradientBegin =>
      Theme.of(this).extension<AppColors>()!.gradientBegin!;
  Color get colorGradientEnd =>
      Theme.of(this).extension<AppColors>()!.gradientEnd!;
  Color get colorText => Theme.of(this).extension<AppColors>()!.text!;
  Color get colorBackground =>
      Theme.of(this).extension<AppColors>()!.background!;
  Color get colorBorder => Theme.of(this).extension<AppColors>()!.border!;
  Color get colorError => Theme.of(this).extension<AppColors>()!.error!;
  Color get colorCardText => Theme.of(this).extension<AppColors>()!.cardText!;
  Color get colorLink => Theme.of(this).extension<AppColors>()!.link!;

  TextStyle get textSubtitle => Theme.of(this).textTheme.subtitleTextStyle;
  TextStyle get textButton => Theme.of(this).textTheme.buttonTextStyle.copyWith(color: Colors.white);
  TextStyle get textLabel => Theme.of(this).textTheme.labelTextStyle;
}
