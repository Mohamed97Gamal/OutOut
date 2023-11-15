import 'package:flutter/material.dart';
import 'package:out_out/data/memory/providers/bottom_navigation_bar_provider.dart';
import 'package:out_out/data/memory/providers/search_provider.dart';
import 'package:out_out/views/auth/splash_screen.dart';

class NavObserver extends NavigatorObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    var bottomNavProvider = BottomNavigationBarProvider.instance;
    var searchProvider = SearchProvider.instance;

    bottomNavProvider.back();
    searchProvider.pop();

    return super.didPop(route, previousRoute);
  }
}

class OutOutApp extends StatelessWidget {
  static const primaryColor = const Color(0xfff82a8a);
  static const accentColor = const Color(0xffe41f7b);
  static const errorColor = const Color(0xffcf0000);
  static const backgroundColor = const Color(0xfff5f5f5);
  static const dividerColor = const Color(0xFFC2C2C2);
  static const bottomNavUnselectedColor = const Color(0xffcdcdcd);

  const OutOutApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Out-Out',
      navigatorObservers: [
        NavObserver(),
      ],
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
          secondary: accentColor,
        ),
        primaryColor: primaryColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            visualDensity: VisualDensity.standard,
            primary: primaryColor,
            textStyle: DefaultTextStyle.of(context).style.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            visualDensity: VisualDensity.standard,
            primary: primaryColor,
            textStyle: DefaultTextStyle.of(context).style.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            visualDensity: VisualDensity.standard,
            primary: primaryColor,
            textStyle: DefaultTextStyle.of(context).style.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          filled: true,
          errorStyle: Theme.of(context).textTheme.bodyText2?.copyWith(color: errorColor) ?? TextStyle(color: errorColor),
          contentPadding: const EdgeInsets.all(12.0),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
            borderRadius: const BorderRadius.all(
              const Radius.circular(2.0),
            ),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: Colors.white,
          disabledColor: Colors.transparent,
          selectedColor: primaryColor,
          secondarySelectedColor: primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          labelStyle: Theme.of(context).textTheme.bodyText2?.copyWith(color: errorColor) ?? TextStyle(color: accentColor),
          secondaryLabelStyle: Theme.of(context).textTheme.bodyText2?.copyWith(color: errorColor) ?? TextStyle(color: accentColor),
          brightness: Brightness.dark,
          showCheckmark: false,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: primaryColor,
          unselectedItemColor: bottomNavUnselectedColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
        visualDensity: VisualDensity.compact,
        dividerTheme: DividerThemeData(
          color: dividerColor,
          thickness: 0.5,
        ),
      ),
      home: SplashScreen(),
    );
  }
}
