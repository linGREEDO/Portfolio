import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:lin_portfolio/page/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Dyari Ali Tahir',
      theme: themeData,
      home: MyHomePage(toggleTheme: _toggleTheme),
    );
  }
}

const ColorScheme ghibliLightColorScheme = ColorScheme.light(
  primary: Color(4278199606),
  surfaceTint: Color(4280116614),
  onPrimary: Color(4294967295),
  primaryContainer: Color(4278208612),
  onPrimaryContainer: Color(4294967295),
  secondary: Color(4279313455),
  onSecondary: Color(4294967295),
  secondaryContainer: Color(4281550161),
  onSecondaryContainer: Color(4294967295),
  tertiary: Color(4280557117),
  onTertiary: Color(4294967295),
  tertiaryContainer: Color(4282728031),
  onTertiaryContainer: Color(4294967295),
  error: Color(4283301890),
  onError: Color(4294967295),
  errorContainer: Color(4287365129),
  onErrorContainer: Color(4294967295),
  surface: Color(4294376190),
  onSurface: Color(4278190080),
  onSurfaceVariant: Color(4280165673),
  outline: Color(4282205257),
  outlineVariant: Color(4282205257),
  shadow: Color(4278190080),
  scrim: Color(4278190080),
  inverseSurface: Color(4281086260),
  inversePrimary: Color(4292472831),
  primaryFixed: Color(4278208612),
  onPrimaryFixed: Color(4294967295),
  primaryFixedDim: Color(4278202692),
  onPrimaryFixedVariant: Color(4294967295),
  secondaryFixed: Color(4281550161),
  onSecondaryFixed: Color(4294967295),
  secondaryFixedDim: Color(4280037178),
  onSecondaryFixedVariant: Color(4294967295),
  tertiaryFixed: Color(4282728031),
  onTertiaryFixed: Color(4294967295),
  tertiaryFixedDim: Color(4281215048),
  onTertiaryFixedVariant: Color(4294967295),
  surfaceDim: Color(4292336351),
  surfaceBright: Color(4294376190),
  surfaceContainerLowest: Color(4294967295),
  surfaceContainerLow: Color(4293981432),
  surfaceContainer: Color(4293586675),
  surfaceContainerHigh: Color(4293257453),
  surfaceContainerHighest: Color(4292862951),
);

const ColorScheme ghibliDarkColorScheme = ColorScheme.dark(
  primary: Color(4287680244),
  surfaceTint: Color(4287680244),
  onPrimary: Color(4278203466),
  primaryContainer: Color(4278209641),
  onPrimaryContainer: Color(4291094527),
  secondary: Color(4290103767),
  onSecondary: Color(4280300350),
  secondaryContainer: Color(4281813333),
  onSecondaryContainer: Color(4291945972),
  tertiary: Color(4291477993),
  onTertiary: Color(4281478220),
  tertiaryContainer: Color(4282991204),
  onTertiaryContainer: Color(4293320447),
  error: Color(4294948011),
  onError: Color(4285071365),
  errorContainer: Color(4287823882),
  onErrorContainer: Color(4294957782),
  surface: Color(4279178263),
  onSurface: Color(4292862951),
  onSurfaceVariant: Color(4290824141),
  outline: Color(4287337111),
  outlineVariant: Color(4282468429),
  shadow: Color(4278190080),
  scrim: Color(4278190080),
  inverseSurface: Color(4292862951),
  inversePrimary: Color(4280116614),
  primaryFixed: Color(4291094527),
  onPrimaryFixed: Color(4278197804),
  primaryFixedDim: Color(4287680244),
  onPrimaryFixedVariant: Color(4278209641),
  secondaryFixed: Color(4291945972),
  onSecondaryFixed: Color(4278853160),
  secondaryFixedDim: Color(4290103767),
  onSecondaryFixedVariant: Color(4281813333),
  tertiaryFixed: Color(4293320447),
  onTertiaryFixed: Color(4280096566),
  tertiaryFixedDim: Color(4291477993),
  onTertiaryFixedVariant: Color(4282991204),
  surfaceDim: Color(4279178263),
  surfaceBright: Color(4281678397),
  surfaceContainerLowest: Color(4278849298),
  surfaceContainerLow: Color(4279770143),
  surfaceContainer: Color(4280033315),
  surfaceContainerHigh: Color(4280691502),
  surfaceContainerHighest: Color(4281414969),
);
