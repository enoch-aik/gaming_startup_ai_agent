import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaming_startup_ai_agent/src/res/color_scheme/color_scheme.dart';

final class AppTheme {
  AppTheme._();
  // The FlexColorScheme defined light mode ThemeData.
  static ThemeData light = FlexThemeData.light(
    colorScheme: AppColorScheme.lightColorScheme,
    // Using FlexColorScheme built-in FlexScheme enum based colors
    scheme: FlexScheme.shark,
    // Component theme configurations for light mode.
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      defaultRadius: 8.0,
      inputDecoratorIsFilled: true,
      inputDecoratorContentPadding: EdgeInsetsDirectional.fromSTEB(
        2,
        20,
        12,
        12,
      ),
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorBorderWidth: 0.5,
      inputDecoratorFocusedBorderWidth: 2.0,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
    ),
    // Direct ThemeData properties.
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    fontFamily: 'Gelion'
  );

  // The FlexColorScheme defined dark mode ThemeData.
  static ThemeData dark = FlexThemeData.dark(
    colorScheme: AppColorScheme.darkColorScheme,
    // Using FlexColorScheme built-in FlexScheme enum based colors.
    scheme: FlexScheme.shark,
    // Component theme configurations for dark mode.
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      defaultRadius: 8.0,
      inputDecoratorIsFilled: true,
      inputDecoratorContentPadding: EdgeInsetsDirectional.fromSTEB(
        2,
        20,
        12,
        12,
      ),
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorBorderWidth: 0.5,
      inputDecoratorFocusedBorderWidth: 2.0,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
    ),
    // Direct ThemeData properties.
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    fontFamily: 'Gelion'
  );
}
