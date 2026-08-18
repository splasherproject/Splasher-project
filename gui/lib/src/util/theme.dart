import 'package:fluent_ui/fluent_ui.dart';

/// Splasher's brand accent: a vivid aqua/cyan "splash" palette, used instead
/// of the Windows system accent so the app keeps a consistent identity
/// across machines.
const Map<String, Color> _kSplasherAccentSwatch = <String, Color>{
  'darkest': Color(0xFF04222B),
  'darker': Color(0xFF063A49),
  'dark': Color(0xFF0A5C70),
  'normal': Color(0xFF00BCD4),
  'light': Color(0xFF26E1F0),
  'lighter': Color(0xFF7DF0F7),
  'lightest': Color(0xFFD6FBFC),
};

final AccentColor kSplasherAccentColor = AccentColor.swatch(_kSplasherAccentSwatch);

/// Secondary brand color used for gradients/highlights across the UI.
const Color kSplasherSecondaryColor = Color(0xFF7C4DFF);

FluentThemeData buildSplasherTheme(Brightness brightness) => FluentThemeData(
    brightness: brightness,
    accentColor: kSplasherAccentColor,
    visualDensity: VisualDensity.standard,
    scaffoldBackgroundColor: Colors.transparent
);
