import 'package:flutter/material.dart';
import 'package:room_app/pages/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  // environment variable initiailzation
  await dotenv.load();

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL', fallback: 'API_URL not found'),
    anonKey: dotenv.get('SUSUPABASE_ANON_KEY', fallback: 'ANON_KEY not found'),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Monty'),
      home: const Home(),
    );
  }
}
