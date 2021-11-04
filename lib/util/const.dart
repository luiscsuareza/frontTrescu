import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  static String appName = "Trescubos";
  static String hostBackend = "http://ec2-3-14-125-59.us-east-2.compute.amazonaws.com:8080/Trescubos-1.0";

  //Colors for theme
//  Color(0xfffcfcff);
  static Color lightPrimary = Color(0xfffcfcff);
  static Color darkPrimary = Colors.black;
  static Color lightAccent = Colors.red;
  static Color darkAccent = Colors.red[400];
  static Color lightBG = Color(0xfffcfcff);
  static Color darkBG = Colors.black;
  static Color ratingBG = Colors.yellow[600];

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    cursorColor: lightAccent,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        title: TextStyle(
          color: darkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
//      iconTheme: IconThemeData(
//        color: lightAccent,
//      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkAccent,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        title: TextStyle(
          color: lightBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
//      iconTheme: IconThemeData(
//        color: darkAccent,
//      ),
    ),
  );

  Future<double> validateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double user = (prefs.getDouble('user'));
    return user;
  }

  setUser(double user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('user', user);
  }

  Future<double> validateBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double balance = (prefs.getDouble('balance'));
    return balance;
  }

  setBalance(double balance) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('balance', balance);
  }

  Future<String> validateUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = (prefs.getString('username'));
    return username;
  }

  setUsername(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

  Future<String> validatePassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String password = (prefs.getString('password'));
    return password;
  }

  setPassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', password);
  }

  Future<String> validateCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String category = (prefs.getString('category'));
    return category;
  }

  setCategory(category) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('category', category);
  }

  Future<String> validateCurrency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String currency = (prefs.getString('currency'));
    return currency;
  }

  setCurrency(currency) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('currency', currency);
  }

  Future<double> validateReceiver() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double receiver = (prefs.getDouble('receiver'));
    return receiver;
  }

  setReceiver(double receiver) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('receiver', receiver);
  }
}
