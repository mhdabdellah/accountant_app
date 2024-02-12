import 'package:flutter/material.dart';

const primaryColor = Colors.blue;
const seconderyColor = Colors.white;
const greenColor = Colors.green;
const greytemColor = Colors.grey;
const black = Colors.black;

ThemeData principalTheme = ThemeData(
  // brightness: Brightness.light,
  primarySwatch: primaryColor,
  primaryColor: primaryColor, // Couleur d'accentuation
  scaffoldBackgroundColor: Colors.white, // Couleur de fond de vos écrans
  unselectedWidgetColor: primaryColor, // Couleur des éléments non sélectionnés

  // Styles de texte
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontSize: 32,
        fontWeight:
            FontWeight.bold), // Style de texte pour les titres de grande taille
    bodyLarge: TextStyle(
        fontSize: 18,
        color: Colors.black87), // Style de texte pour les grands corps de texte
  ),

  // Styles d'app bar
  appBarTheme: const AppBarTheme(
    color: Colors.blue, // Couleur de la barre d'applications
    iconTheme: IconThemeData(
        color: Colors.white), // Couleur des icônes de la barre d'applications
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue).copyWith(
      secondary:
          primaryColor), // Schéma de couleur basé sur la couleur principale

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
          primaryColor), // Set the background color for all ElevatedButtons
    ),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Color.fromARGB(255, 13, 56, 198),
    unselectedItemColor: Colors.grey,
    backgroundColor: seconderyColor,
    selectedLabelStyle: TextStyle(color: primaryColor),
    unselectedLabelStyle: TextStyle(color: black),
    selectedIconTheme: IconThemeData(
      color: primaryColor, // Couleur des icônes sélectionnées
    ),
  ),
  iconTheme: const IconThemeData(
    color: black, // Couleur par défaut des icônes
  ),
);
