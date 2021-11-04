import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../screens/main_screen.dart';
import '../services/obtainBrandCategories.dart';
import '../util/const.dart';
import 'package:http/http.dart' as http;
import '../services/obtainData.dart';
import '../services/obtainCategories.dart';
import '../services/obtainBrands.dart';
import 'package:date_time_picker/date_time_picker.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameControl = new TextEditingController();
  final TextEditingController _passwordControl = new TextEditingController();
  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              top: 25.0,
            ),
            child: Text(
              "Log in to your account",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),

          SizedBox(height: 30.0),

          Card(
            elevation: 3.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "Username",
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                  prefixIcon: Icon(
                    Icons.perm_identity,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
                controller: _usernameControl,
              ),
            ),
          ),

          SizedBox(height: 10.0),

          Card(
            elevation: 3.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "Password",
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                obscureText: true,
                maxLines: 1,
                controller: _passwordControl,
              ),
            ),
          ),

          SizedBox(height: 10.0),

          //Container(
          //  alignment: Alignment.centerRight,
          //  child: FlatButton(
          //    child: Text(
          //      "Forgot Password?",
          //      style: TextStyle(
          //        fontSize: 14.0,
          //        fontWeight: FontWeight.w500,
          //        color: Theme.of(context).accentColor,
          //      ),
          //    ),
          //    onPressed: (){},
          //  ),
          //),

          SizedBox(height: 30.0),

          Container(
            height: 50.0,
            child: RaisedButton(
              child: Text(
                "LOGIN".toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                validate(
                    this._usernameControl.text, this._passwordControl.text);
              },
              color: Theme.of(context).accentColor,
            ),
          ),

          SizedBox(height: 10.0),
          Divider(
            color: Theme.of(context).accentColor,
          ),
          SizedBox(height: 10.0),

          //
          //: Container(
          //th: MediaQuery.of(context).size.width/2,
          //ld: Row(
          //hildren: <Widget>[
          // RawMaterialButton(
          //   onPressed: (){},
          //   fillColor: Colors.blue[800],
          //   shape: CircleBorder(),
          //   elevation: 4.0,
          //   child: Padding(
          //     padding: EdgeInsets.all(15),
          //     child: Icon(
          //       FontAwesomeIcons.facebookF,
          //       color: Colors.white,
//       //ize: 24.0,
          //     ),
          //   ),
          // ),
          //
          // RawMaterialButton(
          //   onPressed: (){},
          //   fillColor: Colors.white,
          //   shape: CircleBorder(),
          //   elevation: 4.0,
          //   child: Padding(
          //     padding: EdgeInsets.all(15),
          //     child: Icon(
          //       FontAwesomeIcons.google,
          //       color: Colors.blue[800],
//       //ize: 24.0,
          //     ),
          //   ),
          // ),
          //,
          //
          //
          //

          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Future<void> validate(String email, String password) async {
    final http.Response response = await http.get(
        Uri.parse(Constants.hostBackend +
            "/api/enterprise/users/" +
            email +
            "/" +
            password),
        headers: <String, String>{
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Access-Control-Allow-Credentials":
              "true", // Required for cookies, authorization headers with HTTPS
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "GET, OPTIONS",
          'Content-Type': 'application/json; charset=UTF-8',
          //este header se debe consumir en todos igual
          'Authorization': 'sdfh-drtj-hktf-yikt-ykyg-uikt',
          'Email': email,
          'Password': password,
        });

    if (response.statusCode == 200) {
      //Aca que hacemos en caso de tener 200 la validacion es exitosa y continuamos
      final responseJson = json.decode(response.body)[0]["id"];
      final balance = json.decode(response.body)[0]["balance"];
      final currency =
          json.decode(response.body)[0]["currencyId"]["id"].toString();
      //final responseJson = json.decode(response.body);
      //print("Este el el json de response exitoso: " + responseJson.toString());
      //print("Este el el json de response exitoso: " + balance.toString());
      await Constants().setUser(double.parse(responseJson.toString()));
      await Constants().setBalance(double.parse(balance.toString()));
      await Constants().setUsername(email);
      await Constants().setPassword(password);
      //print("Currency: "+currency);
      await Constants().setCurrency(currency);
      await readInfoUser();
      await getCategories(email, password);
      //await getBrands();
      //await getBrandCategories();
      _pushPage(context, MainScreen());
      //return responseJson;
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('No tiene permiso'),
          content: const Text('Usuario no autorizado, acceso denegado'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      throw Exception('Failed to Validate');
    }
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}
