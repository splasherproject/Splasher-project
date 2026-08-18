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

/// The font family used throughout the app, chosen to read close to macOS'
/// system typeface (San Francisco) without relying on an Apple-only font.
const String kSplasherFontFamily = 'Inter';

const double _kPillRadius = 20.0;
const BorderRadius _kCardRadius = BorderRadius.all(Radius.circular(16.0));

final RoundedRectangleBorder _pillShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(_kPillRadius),
);

FluentThemeData buildSplasherTheme(Brightness brightness) {
  final isDark = brightness == Brightness.dark;

  return FluentThemeData(
      brightness: brightness,
      accentColor: kSplasherAccentColor,
      fontFamily: kSplasherFontFamily,
      visualDensity: VisualDensity.standard,
      scaffoldBackgroundColor: Colors.transparent,
      cardColor: isDark ? const Color(0xFF172226) : const Color(0xFFFFFFFF),
      navigationPaneTheme: NavigationPaneThemeData(
        backgroundColor: isDark
            ? const Color(0xF00E1A1D)
            : const Color(0xF0F7FBFC),
        highlightColor: kSplasherAccentColor,
      ),
      buttonTheme: ButtonThemeData(
        defaultButtonStyle: ButtonStyle(
          shape: WidgetStatePropertyAll(_pillShape),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          ),
        ),
        filledButtonStyle: ButtonStyle(
          shape: WidgetStatePropertyAll(_pillShape),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          ),
        ),
        outlinedButtonStyle: ButtonStyle(
          shape: WidgetStatePropertyAll(_pillShape),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          ),
        ),
      ),
      dialogTheme: ContentDialogThemeData(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1B2A2E) : Colors.white,
          borderRadius: _kCardRadius,
        ),
      ),
  );
}
