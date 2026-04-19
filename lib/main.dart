import 'package:flutter/material.dart';
import 'package:flutter_money_tracking_app/views/splash_screen_ui.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {

  /*WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://rgenrkojurrqdhhtbzts.supabase.co', // เปลี่ยนเป็น URL ของคุณ
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJnZW5ya29qdXJycWRoaHRienRzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzM3ODc5MDksImV4cCI6MjA4OTM2MzkwOX0.c7wCnJxDnW9eixtjXyyAI6Y-v1h4hWKJkX-w7e1xkPU',
  );*/
  runApp(const FlutterMoneyTrackingApp());
}

class FlutterMoneyTrackingApp extends StatefulWidget {
  const FlutterMoneyTrackingApp({super.key});

  @override
  State<FlutterMoneyTrackingApp> createState() =>
      _FlutterMoneyTrackingAppState();
}

class _FlutterMoneyTrackingAppState extends State<FlutterMoneyTrackingApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenUi(),
      theme: ThemeData(
        textTheme: GoogleFonts.kanitTextTheme(Theme.of(context).textTheme),
      ),
    );
  }
}
