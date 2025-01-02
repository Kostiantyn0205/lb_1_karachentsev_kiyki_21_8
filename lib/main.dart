import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/tabs_screen.dart';

void main() {
  runApp(
    ProviderScope( 
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TabsScreen(),
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.purpleAccent),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Lato', color: Color.fromARGB(255, 255, 255, 255), fontSize: 18),
          bodyMedium: TextStyle(fontFamily: 'Lato', color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
          titleLarge: TextStyle(fontFamily: 'Lato', color: Color.fromARGB(255, 255, 255, 255), fontSize: 22),
          headlineSmall: TextStyle(fontFamily: 'Lato', color: Color.fromARGB(255, 255, 255, 255), fontSize: 16),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
