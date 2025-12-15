import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Laptop Matcher Elite',
      theme: ThemeData(
        // Skema Warna Gelap Elegan
        scaffoldBackgroundColor: const Color(0xFF1A1A2E), // Dark Navy
        primaryColor: const Color(0xFFE94560), // Aksen Merah/Pink Modern
        cardColor: const Color(0xFF16213E), // Navy lebih terang buat Card
        
        // Atur Text Default jadi Putih
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        
        // Style AppBar
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A1A2E),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          iconTheme: IconThemeData(color: Colors.white),
        ),

        // Style Input Form
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF16213E),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          hintStyle: TextStyle(color: Colors.grey[400]),
          labelStyle: const TextStyle(color: Colors.white70),
        ),
        
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFFE94560), // Warna tombol/aksen
        ),
      ),
      home: const HomePage(),
    );
  }
}