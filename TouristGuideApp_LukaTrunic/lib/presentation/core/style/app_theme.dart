import 'package:flutter/material.dart';

import 'colors.dart';

final lightTheme = ThemeData(
    colorScheme: .fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    fontFamily: 'Montserrat',
    extensions: [
        AppColors(
            text: textColorLight,
            background: backgroundColorLight,
            border: borderColorLight,
            error: errorColorLight,
            gradientBegin: gradientBeginColorLight,
            gradientEnd: gradientEndColorLight,
            cardText: cardTextColorLight,
            link: linkColorLight,
        ),
    ],
);