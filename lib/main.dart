import 'package:flutter/material.dart';
import 'package:people/preference/Preference.dart';
import 'package:people/screens/home_screen.dart';
import 'package:people/routes/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'People',
      initialRoute: 'home',
      routes: getApplicationRoutes(),
      home: const HomeScreen(),
      theme: ThemeData(
        primaryColor: const Color(0xff296DC8),
      ),
      localizationsDelegates: const [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('es')],
    );
  }
}
