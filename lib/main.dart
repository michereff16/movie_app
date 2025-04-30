import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'view_models/home_view_model.dart';
import 'view_models/movie_details_view_model.dart';
import 'views/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => MovieDetailsViewModel()),
      ],
      child: MaterialApp(
        title: 'Movie App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF1E1634),
          scaffoldBackgroundColor: const Color(0xFF1E1634),
          fontFamily: GoogleFonts.montserrat().fontFamily,
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            displayMedium: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            displaySmall: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            headlineMedium: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            headlineSmall: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            titleLarge: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            titleMedium: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            bodyLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white70),
          ),
          colorScheme: ColorScheme.dark(
            primary: const Color(0xFF1E1634),
            secondary: const Color(0xFFE94DAA),
            tertiary: const Color(0xFF3498DB),
            background: const Color(0xFF1E1634),
            surface: const Color(0xFF2A1F45),
            onSurface: Colors.white,
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}
