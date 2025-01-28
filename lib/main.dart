import 'package:flutter/material.dart';
import 'package:grid_search_app/screens/grid_display_screen.dart';
import 'package:grid_search_app/screens/grid_input_screen.dart';
import 'package:grid_search_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      title: 'Grid Search App',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/gridInput': (context) => GridInputScreen(),
        '/gridDisplay': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map;
          return GridDisplayScreen(
            rows: args['rows'],
            columns: args['columns'],
            letters: args['letters'],
          );
        },
      },
    );
  }
}
