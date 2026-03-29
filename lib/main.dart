import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ledgerly/pages/welcomepage.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(MyApp());
  });
}
class MyApp extends StatefulWidget{

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode thememode = ThemeMode.system;

  void Apptheme (String mode){
    if(mode=='light'){
      setState(() {
        thememode=ThemeMode.light;
      });
    }
    if(mode=='dark'){
      setState(() {
        thememode=ThemeMode.dark;
      });
    }

  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(debugShowCheckedModeBanner: false,

      theme:ThemeData.light().copyWith(
        primaryColor: Color(0xFFF8F9FB),

        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          shadowColor:Colors.black38,
        ),

        textTheme: TextTheme(
          headlineLarge: GoogleFonts.openSans(
            color: Colors.black,
            fontSize:35,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: GoogleFonts.openSans(color: Colors.black,fontSize:20,fontWeight: FontWeight.bold),
          headlineSmall: GoogleFonts.openSans(color: Colors.grey,fontSize: 12),
          titleLarge:GoogleFonts.openSans(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w500) ,
          titleMedium: GoogleFonts.openSans(color: Colors.orange.shade300, fontSize: 13) ,
          titleSmall: GoogleFonts.openSans(color: Colors.green, fontSize: 15) ,
        ),

        iconTheme: IconThemeData(color: Colors.black),

        cardColor:Colors.white,
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
          titleTextStyle: GoogleFonts.poppins(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w600),
          contentTextStyle: GoogleFonts.poppins(color: Colors.black54,fontSize: 17,fontWeight: FontWeight.w400),
        ),
        extensions: [
          AppGradients(
            containerGradient: LinearGradient(
              colors: [
                Color(0xFFE4ECF7),
                Color(0xFFF5F7FA),
                Color(0xFFFFFFFF),
                Colors.white
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            barGradient: LinearGradient(
              colors: [
                Color(0xFF6A11CB),
                Color(0xFF2575FC),
                Color(0xFF00C6FF),
              ],
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
          shadowColor:Colors.white38,
        ),

          textTheme: TextTheme(

          headlineLarge: GoogleFonts.openSans(
            color: Colors.white,
            fontSize:35,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: GoogleFonts.openSans(color: Colors.white,fontSize:20,fontWeight: FontWeight.bold),
          headlineSmall: GoogleFonts.openSans(color: Colors.white70,fontSize: 12),
          titleLarge:GoogleFonts.openSans(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w500) ,
          titleMedium: GoogleFonts.openSans(color: Colors.orange.shade300,fontSize: 13) ,
          titleSmall: GoogleFonts.openSans(color: Colors.green, fontSize: 15) ,
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
          titleTextStyle: GoogleFonts.poppins(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w600),
          contentTextStyle: GoogleFonts.poppins(color: Colors.white70,fontSize: 17,fontWeight: FontWeight.w400),
        ),

           canvasColor: Color(0xFFF8FAFC),
        extensions: [
          AppGradients(
            containerGradient: LinearGradient(
              colors: [
                Color(0xFF0F3460),
                Color(0xFF16213E),
                Color(0xFF1A1A2E),
                Colors.black
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            barGradient: LinearGradient(
              colors: [
                Color(0xFF00F5A0),
                Color(0xFF00D9F5),
                Color(0xFF0088FF),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ],
      ),

      themeMode:thememode,
      home: welcomepage(apptheme:Apptheme ,),
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
