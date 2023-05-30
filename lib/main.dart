import 'package:blabber/screens/home_screen.dart';
import 'package:blabber/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blabber',
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Pallete.whiteColor, useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}
