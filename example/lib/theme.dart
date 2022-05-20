import 'package:flutter/material.dart';

class ThemeDataGetter {
  Color get accentColor => const Color.fromARGB(255, 0, 76, 255);
  Color get secondAccentColor => const Color(0xFF5B86E5);

  Color get onLightColor => blackColor;

  Color get darkPrimaryColor => Colors.black;

  Color get errorColor => const Color.fromARGB(255, 255, 0, 0);

  Color get primaryLightColor => blackColor;

  Color get dividerColor => const Color(0xFFECECEC);

  Color get backgroundColor => const Color(0xFFFFFFFF);

  Color get primaryColor => Colors.white;

  Color get secondaryNavBarBackgroundColor => Colors.black;

  Color get tabbarBackgroundColor => const Color(0xFFf1f1f1);

  Color get darkAccentColor => const Color(0xFF7ED2EE);

  Color get darkBackgroundColor => const Color(0xFF101215);

  Color get darkTabbarBackgroundColor => const Color(0xFF2D2D2D);

  Color get darkSecondaryNavBarBackgroundColor => darkTabbarBackgroundColor;

  Color get darkWhite => Colors.white.withOpacity(0.94);

  //customColors
  Color get lightGrey => const Color(0xFFf2f2f2);
  Color get mediumGrey => const Color(0xFF9c9c9c);

  Color get blackColor => const Color(0xFF000000);
  Color get whiteColor => Colors.white;

  ThemeData get theme {
    final data = ThemeData(
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
      dividerTheme: const DividerThemeData(color: Color(0xFFB2B2B2), thickness: 1),
    );

    return data.copyWith(
      appBarTheme: data.appBarTheme.copyWith(elevation: 0),
      textSelectionTheme: data.textSelectionTheme.copyWith(
        cursorColor: primaryColor,
      ),
      colorScheme: data.colorScheme.copyWith(
        secondary: accentColor,
        primary: primaryColor,
        background: backgroundColor,
        surface: whiteColor,
        error: errorColor,
        onPrimary: onLightColor,
        onSecondary: whiteColor,
        onBackground: onLightColor,
        onSurface: onLightColor,
        onError: whiteColor,
      ),
    );
  }
}
