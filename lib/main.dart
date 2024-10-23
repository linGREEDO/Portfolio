import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:lin_portfolio/page/home_page.dart';
import 'package:responsive_builder/responsive_builder.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = true;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme =
        _isDarkMode ? ghibliDarkColorScheme : ghibliLightColorScheme;

    final ThemeData themeData = ThemeData(
      colorScheme: colorScheme,
      fontFamily: 'Ghibli', // You'll need to add this font to your pubspec.yaml
      textTheme: TextTheme(
        headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface),
        headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface),
        headlineSmall: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface),
        displayMedium: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface),
        bodyMedium: TextStyle(fontSize: 16, color: colorScheme.onSurface),
        bodySmall: TextStyle(
            fontSize: 14,
            fontStyle: FontStyle.italic,
            color: colorScheme.onSurface),
      ),
      useMaterial3: true,
    );

    return ResponsiveApp(
      builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          title: 'Dyari Ali Tahir',
          theme: themeData,
          home: MyHomePage(toggleTheme: _toggleTheme),
        );
      },
    );
  }
}

const ColorScheme ghibliLightColorScheme = ColorScheme.light(
  primary: Color(4278208865),
  surfaceTint: Color(4279723652),
  onPrimary: Color(4294967295),
  primaryContainer: Color(4281760923),
  onPrimaryContainer: Color(4294967295),
  secondary: Color(4281484624),
  onSecondary: Color(4294967295),
  secondaryContainer: Color(4284708739),
  onSecondaryContainer: Color(4294967295),
  tertiary: Color(4282597216),
  onTertiary: Color(4294967295),
  tertiaryContainer: Color(4285886612),
  onTertiaryContainer: Color(4294967295),
  error: Color(4287365129),
  onError: Color(4294967295),
  errorContainer: Color(4292490286),
  onErrorContainer: Color(4294967295),
  surface: Color(4294376190),
  onSurface: Color(4279704607),
  onSurfaceVariant: Color(4282139720),
  outline: Color(4284047461),
  outlineVariant: Color(4285824129),
  shadow: Color(4278190080),
  scrim: Color(4278190080),
  inverseSurface: Color(4281086260),
  inversePrimary: Color(4287483889),
  primaryFixed: Color(4281760923),
  onPrimaryFixed: Color(4294967295),
  primaryFixedDim: Color(4279395201),
  onPrimaryFixedVariant: Color(4294967295),
  secondaryFixed: Color(4284708739),
  onSecondaryFixed: Color(4294967295),
  secondaryFixedDim: Color(4283129706),
  onSecondaryFixedVariant: Color(4294967295),
  tertiaryFixed: Color(4285886612),
  onTertiaryFixed: Color(4294967295),
  tertiaryFixedDim: Color(4284242043),
  onTertiaryFixedVariant: Color(4294967295),
  surfaceDim: Color(4292270814),
  surfaceBright: Color(4294376190),
  surfaceContainerLowest: Color(4294967295),
  surfaceContainerLow: Color(4293981432),
  surfaceContainer: Color(4293586674),
  surfaceContainerHigh: Color(4293192173),
  surfaceContainerHighest: Color(4292862951),
);

const ColorScheme ghibliDarkColorScheme = ColorScheme.dark(
  primary: Color(4294441983),
  surfaceTint: Color(4287483889),
  onPrimary: Color(4278190080),
  primaryContainer: Color(4287747062),
  onPrimaryContainer: Color(4278190080),
  secondary: Color(4294441983),
  onSecondary: Color(4278190080),
  secondaryContainer: Color(4290367195),
  onSecondaryContainer: Color(4278190080),
  tertiary: Color(4294900223),
  onTertiary: Color(4278190080),
  tertiaryContainer: Color(4291610350),
  onTertiaryContainer: Color(4278190080),
  error: Color(4294965753),
  onError: Color(4278190080),
  errorContainer: Color(4294949553),
  onErrorContainer: Color(4278190080),
  surface: Color(4279178263),
  onSurface: Color(4294967295),
  onSurfaceVariant: Color(4294441983),
  outline: Color(4291087569),
  outlineVariant: Color(4291087569),
  shadow: Color(4278190080),
  scrim: Color(4278190080),
  inverseSurface: Color(4292862951),
  inversePrimary: Color(4278201919),
  primaryFixed: Color(4291554559),
  onPrimaryFixed: Color(4278190080),
  primaryFixedDim: Color(4287747062),
  onPrimaryFixedVariant: Color(4278196516),
  secondaryFixed: Color(4292209399),
  onSecondaryFixed: Color(4278190080),
  secondaryFixedDim: Color(4290367195),
  onSecondaryFixedVariant: Color(4278458658),
  tertiaryFixed: Color(4293518335),
  onTertiaryFixed: Color(4278190080),
  tertiaryFixedDim: Color(4291610350),
  onTertiaryFixedVariant: Color(4279636529),
  surfaceDim: Color(4279178263),
  surfaceBright: Color(4281678397),
  surfaceContainerLowest: Color(4278849298),
  surfaceContainerLow: Color(4279704607),
  surfaceContainer: Color(4279967779),
  surfaceContainerHigh: Color(4280691502),
  surfaceContainerHighest: Color(4281414969),
);
