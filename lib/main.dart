import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_app/services/locale.dart';
import 'package:provider/provider.dart';
import 'view_models/home_view_model.dart';
import 'view_models/movie_details_view_model.dart';
import 'views/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      child: const MovieApp(),
    ),
  );
}

class MovieApp extends StatefulWidget {
  const MovieApp({super.key});

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    debugPrint('==pausing...');
    await Future.delayed(const Duration(seconds: 3));
    debugPrint('==unpausing...');
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => MovieDetailsViewModel()),
      ],
      child: Consumer<LocaleProvider>(
        builder:
            (context, provider, child) => MaterialApp(
              title: 'Movie App',
              debugShowCheckedModeBanner: false,
              locale: provider.locale,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              theme: ThemeData(
                primaryColor: const Color(0xFF1E1634),
                scaffoldBackgroundColor: const Color(0xFF1E1634),
                fontFamily: GoogleFonts.montserrat().fontFamily,
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
      ),
    );
  }
}
