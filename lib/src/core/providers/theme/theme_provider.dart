import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = FlexThemeData.light(
  scheme: FlexScheme.redWine,
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  blendLevel: 7,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 10,
    blendOnColors: false,
    useMaterial3Typography: true,
    useM2StyleDividerInM3: true,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,
  // To use the Playground font, add GoogleFonts package and uncomment
  fontFamily: GoogleFonts.lato().fontFamily,
).copyWith(
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(16.0), // Set the desired padding
    ),
  ),
);

final darkTheme = FlexThemeData.dark(
  scheme: FlexScheme.redWine,
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  blendLevel: 13,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 20,
    useMaterial3Typography: true,
    useM2StyleDividerInM3: true,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,

  // To use the Playground font, add GoogleFonts package and uncomment
  fontFamily: GoogleFonts.lato().fontFamily,
).copyWith(
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      // padding: const EdgeInsets.all(17.0), // Set the desired padding
    ),
  ),
);

final lightThemeProvider = Provider<ThemeData>((ref) {
  return lightTheme;
});
final darkThemeProvider = Provider<ThemeData>((ref) {
  return darkTheme;
});

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

final isLightThemeProvider = Provider<bool>((ref) {
  bool lightTheme = ref.read(themeProvider).brightness == Brightness.light;

  return lightTheme;
});

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(lightTheme);
  void switchTheme() => state = state == lightTheme ? darkTheme : lightTheme;
}

final userThemeProvider =
    Provider.family.autoDispose<String, BuildContext>((ref, context) {
  final theme = Theme.of(context).brightness;

  return theme == Brightness.dark ? 'darkTheme' : 'lightTheme';
});
