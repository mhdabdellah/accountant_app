import 'package:flutter/material.dart';

class ApplicationColors {
  MaterialColor primaryColor = Colors.blue;
  Color? seconderyColor = Colors.white;
  Color greenColor = Colors.green;
  Color greytemColor = Colors.grey;
  Color black = Colors.black;
}

class ApplicationThemes {
  ThemeData principalTheme = ThemeData(
    // brightness: Brightness.light,
    primarySwatch: ApplicationColors().primaryColor,
    primaryColor: ApplicationColors().primaryColor, // Couleur d'accentuation
    scaffoldBackgroundColor: Colors.white, // Couleur de fond de vos écrans
    unselectedWidgetColor: ApplicationColors()
        .primaryColor, // Couleur des éléments non sélectionnés

    // Styles de texte
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight
              .bold), // Style de texte pour les titres de grande taille
      bodyLarge: TextStyle(
          fontSize: 18,
          color:
              Colors.black87), // Style de texte pour les grands corps de texte
    ),

    // Styles d'app bar
    appBarTheme: const AppBarTheme(
      color: Colors.blue, // Couleur de la barre d'applications
      iconTheme: IconThemeData(
          color: Colors.white), // Couleur des icônes de la barre d'applications
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue).copyWith(
        secondary: ApplicationColors()
            .primaryColor), // Schéma de couleur basé sur la couleur principale

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(ApplicationColors()
            .primaryColor), // Set the background color for all ElevatedButtons
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: const Color.fromARGB(255, 13, 56, 198),
      unselectedItemColor: Colors.grey,
      backgroundColor: ApplicationColors().seconderyColor,
      selectedLabelStyle: TextStyle(color: ApplicationColors().primaryColor),
      unselectedLabelStyle: TextStyle(color: ApplicationColors().black),
      selectedIconTheme: IconThemeData(
        color: ApplicationColors()
            .primaryColor, // Couleur des icônes sélectionnées
      ),
    ),
    iconTheme: IconThemeData(
      color: ApplicationColors().black, // Couleur par défaut des icônes
    ),
  );
}
