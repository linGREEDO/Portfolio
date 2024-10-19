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
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.greenAccent,
      brightness: _isDarkMode ? Brightness.dark : Brightness.light,
    );

    final ThemeData themeData = ThemeData(
      colorScheme: colorScheme,
      fontFamily: 'Futura PT',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(fontSize: 16),
        bodySmall: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
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
