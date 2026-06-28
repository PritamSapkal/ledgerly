import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/adapters.dart';

import 'package:ledgerly/pages/welcomepage.dart';

import 'Model/expense_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Initialize Hive for Flutter
  await Hive.initFlutter();

  // 2. Register with explicit generic type parameters on the methods
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(expensemodelAdapter());

  // 3. Open your type-safe box
  await Hive.openBox<expense_model>('expenses_box');

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode thememode = ThemeMode.system;

  void Apptheme(String mode) {
    if (mode == 'light') {
      setState(() {
        thememode = ThemeMode.light;
      });
    }
    if (mode == 'dark') {
      setState(() {
        thememode = ThemeMode.dark;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xFFF8F9FB),

        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          shadowColor: Colors.black38,
        ),

        textTheme: TextTheme(
          headlineLarge: GoogleFonts.openSans(
            color: Colors.black,
            fontSize: (screenWidth * 0.09).clamp(30.0, 45.0),
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: GoogleFonts.openSans(
            color: Colors.black,
            fontSize: (screenWidth * 0.051).clamp(18, 26),
            fontWeight: FontWeight.bold,
          ),
          headlineSmall: GoogleFonts.openSans(
            color: Colors.grey,
            fontSize: (screenWidth * 0.030).clamp(11, 16),
          ),
          titleLarge: GoogleFonts.openSans(
            color: Colors.black,
            fontSize: (screenWidth * 0.044).roundToDouble().clamp(15, 22),
            fontWeight: FontWeight.w500,
          ),
          titleMedium: GoogleFonts.openSans(
            color: Colors.orange.shade300,
            fontSize: (screenWidth * 0.033).clamp(12, 18),
          ),
          titleSmall: GoogleFonts.openSans(
            color: Colors.green,
            fontSize: (screenWidth * 0.038).clamp(14, 20),
          ),
          labelMedium: GoogleFonts.openSans(
            color: Colors.black,
            fontSize: (screenWidth * 0.051).clamp(18, 26),
            fontWeight: FontWeight.bold,
          ),
          labelSmall: GoogleFonts.openSans(
            color: Colors.grey,
            fontSize: (screenWidth * 0.030).clamp(11, 16),
          ),
        ),

        iconTheme: IconThemeData(color: Colors.black),

        cardColor: Colors.white,
        canvasColor: Color(0xFF1E293B),

        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 5,
          shape: CircleBorder(),
          splashColor: Colors.grey,
          hoverColor: Colors.grey,
        ),

        primaryColorDark: Colors.black,
        primaryColorLight: Colors.white,

        dialogTheme: DialogThemeData(
          backgroundColor: Colors.white,
          elevation: 5,
          titleTextStyle: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: (screenWidth * 0.064).roundToDouble().clamp(22, 32),
            fontWeight: FontWeight.w600,
          ),
          contentTextStyle: GoogleFonts.poppins(
            color: Colors.black54,
            fontSize: (screenWidth * 0.044).roundToDouble().clamp(15, 22),
            fontWeight: FontWeight.w400,
          ),
        ),
        extensions: [
          AppGradients(
            containerGradient: LinearGradient(
              colors: [
                Color(0xFFE4ECF7),
                Color(0xFFF5F7FA),
                Color(0xFFFFFFFF),
                Colors.white,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            barGradient: LinearGradient(
              colors: [Color(0xFF6A11CB), Color(0xFF2575FC), Color(0xFF00C6FF)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ],
      ),

      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,

        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          shadowColor: Colors.white38,
        ),

        textTheme: TextTheme(
          headlineLarge: GoogleFonts.openSans(
            color: Colors.white,
            fontSize: (screenWidth * 0.09).clamp(30.0, 45.0),
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: GoogleFonts.openSans(
            color: Colors.white,
            fontSize: (screenWidth * 0.051).roundToDouble().clamp(18, 26),
            fontWeight: FontWeight.bold,
          ),
          headlineSmall: GoogleFonts.openSans(
            color: Colors.white70,
            fontSize: (screenWidth * 0.030).roundToDouble().clamp(11, 16),
          ),
          titleLarge: GoogleFonts.openSans(
            color: Colors.white,
            fontSize: (screenWidth * 0.044).roundToDouble().clamp(15, 22),
            fontWeight: FontWeight.w500,
          ),
          titleMedium: GoogleFonts.openSans(
            color: Colors.orange.shade300,
            fontSize: (screenWidth * 0.033).roundToDouble().clamp(12, 18),
          ),
          titleSmall: GoogleFonts.openSans(
            color: Colors.green,
            fontSize: (screenWidth * 0.038).roundToDouble().clamp(14, 20),
          ),
        ),

        iconTheme: IconThemeData(color: Colors.white),

        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 5,
          shape: CircleBorder(),
          splashColor: Colors.grey,
          hoverColor: Colors.grey,
        ),

        primaryColorDark: Colors.white,

        primaryColorLight: Colors.black,

        dialogTheme: DialogThemeData(
          titleTextStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: (screenWidth * 0.064).roundToDouble().clamp(22, 32),
            fontWeight: FontWeight.w600,
          ),
          contentTextStyle: GoogleFonts.poppins(
            color: Colors.white70,
            fontSize: (screenWidth * 0.044).roundToDouble().clamp(15, 22),
            fontWeight: FontWeight.w400,
          ),
        ),

        canvasColor: Color(0xFFF8FAFC),
        extensions: [
          AppGradients(
            containerGradient: LinearGradient(
              colors: [
                Color(0xFF0F3460),
                Color(0xFF16213E),
                Color(0xFF1A1A2E),
                Colors.black,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            barGradient: LinearGradient(
              colors: [Color(0xFF00F5A0), Color(0xFF00D9F5), Color(0xFF0088FF)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ],
      ),

      themeMode: thememode,
      home: welcomepage(apptheme: Apptheme),
    );
  }
}

@immutable
class AppGradients extends ThemeExtension<AppGradients> {
  final LinearGradient containerGradient;
  final LinearGradient barGradient;

  const AppGradients({
    required this.containerGradient,
    required this.barGradient,
  });

  @override
  AppGradients copyWith({
    LinearGradient? containerGradient,
    LinearGradient? barGradient,
  }) {
    return AppGradients(
      containerGradient: containerGradient ?? this.containerGradient,
      barGradient: barGradient ?? this.barGradient,
    );
  }

  @override
  AppGradients lerp(ThemeExtension<AppGradients>? other, double t) {
    if (other is! AppGradients) return this;

    return AppGradients(
      containerGradient: containerGradient,
      barGradient: barGradient,
    );
  }
}
