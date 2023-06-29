import 'package:flutter/material.dart';
import 'package:non_linear_video/pages/non_linear_video_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of this application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Non Linear Video',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          platform: TargetPlatform.iOS,
        ),
        home: const NonLinearVideoApp());
  }
}
