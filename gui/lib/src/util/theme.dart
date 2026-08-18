import 'package:fluent_ui/fluent_ui.dart';

/// Splasher's brand accent: a muted forest green, near-black surfaces —
/// modeled after modern gaming launcher dashboards (dark card-based UI).
const Map<String, Color> _kSplasherAccentSwatch = <String, Color>{
  'darkest': Color(0xFF0F2419),
  'darker': Color(0xFF1B4029),
  'dark': Color(0xFF2A6144),
  'normal': Color(0xFF3E9169),
  'light': Color(0xFF5AB588),
  'lighter': Color(0xFF8CD3AC),
  'lightest': Color(0xFFD6F3E4),
};

final AccentColor kSplasherAccentColor = AccentColor.swatch(_kSplasherAccentSwatch);

/// Secondary brand color used for gradients/highlights across the UI.
const Color kSplasherSecondaryColor = Color(0xFF7C4DFF);

/// The font family used throughout the app, chosen to read close to macOS'
/// system typeface (San Francisco) without relying on an Apple-only font.
const String kSplasherFontFamily = 'Inter';

const double _kPillRadius = 20.0;
const BorderRadius _kCardRadius = BorderRadius.all(Radius.circular(8.0));

// Near-black gaming-launcher palette.
const Color _kDarkBackground = Color(0xFF0C0C0E);
const Color _kDarkCard = Color(0xFF18181C);
const Color _kDarkBorder = Color(0xFF33333A);
const Color _kLightBackground = Color(0xFFF5F6F7);
const Color _kLightCard = Color(0xFFFFFFFF);

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
      micaBackgroundColor: isDark ? _kDarkBackground : _kLightBackground,
      cardColor: isDark ? _kDarkCard : _kLightCard,
      menuColor: isDark ? _kDarkCard : _kLightCard,
      navigationPaneTheme: NavigationPaneThemeData(
        backgroundColor: isDark ? _kDarkBackground : _kLightBackground,
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
          color: isDark ? _kDarkCard : Colors.white,
          borderRadius: _kCardRadius,
          border: isDark ? Border.all(color: _kDarkBorder) : null,
        ),
      ),
  );
}
