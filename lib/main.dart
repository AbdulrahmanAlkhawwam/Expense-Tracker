import 'package:acodemind02/Expenses.dart';
import 'package:flutter/material.dart';

void main (){
 /* WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((fn){*/
    runApp(MyApp());
 // });

}

final ColorScheme kColorScheme = ColorScheme.fromSeed(seedColor: Colors.indigo);
final ColorScheme kDarkColorScheme = ColorScheme.fromSeed(brightness: Brightness.dark,seedColor: const Color.fromARGB(255, 5, 99, 125));

class MyApp extends StatelessWidget {
  @override
  Widget build(context) {

    return MaterialApp(
      debugShowCheckedModeBanner: true,
      darkTheme: ThemeData.dark()
          .copyWith(
        useMaterial3: true ,
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme()
            .copyWith(
            color: kDarkColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5)
        ),
        iconTheme: const IconThemeData().copyWith(
            color: kDarkColorScheme.onSecondaryContainer
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: MaterialStateColor.resolveWith((states) => kDarkColorScheme.onPrimaryContainer),
            foregroundColor: MaterialStateColor.resolveWith((states) => kDarkColorScheme.primaryContainer),
          ),
        ),

      ),
      theme: ThemeData()
          .copyWith(
          useMaterial3: true,
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme()
              .copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,
          ),
        cardTheme: const CardTheme()
            .copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5)
        ),
        textTheme: ThemeData().textTheme.copyWith(
          bodyMedium: const TextStyle().copyWith(
            color: kColorScheme.onSecondaryContainer
          )
        ),
        iconTheme: const IconThemeData().copyWith(
          color: kColorScheme.onSecondaryContainer
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: MaterialStateColor.resolveWith((states) => kColorScheme.onPrimaryContainer),
            foregroundColor: MaterialStateColor.resolveWith((states) => kColorScheme.primaryContainer),
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      home: const Expenses(),
    );
  }
}