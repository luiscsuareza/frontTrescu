import 'package:http/http.dart' as http;
import 'dart:convert';
import '../util/const.dart';
import 'obtainData.dart';

List<dynamic> brandsList;

Future<void> getBrands() async {
  await readInfoUser();
  final http.Response response = await http.get(
      Uri.parse(
          Constants.hostBackend+"/api/brands/is/"+category),
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
        'Email': userName,
        'Password': password,
      });

  if (response.statusCode == 200) {
    //Aca que hacemos en caso de tener 200 la validacion es exitosa y continuamos
    //final responseJson = json.decode(response.body)[0]["id"];
    final responseJson = json.decode(response.body);
    brandsList = responseJson;
    //print("Json de respuesta de Marcas: "+responseJson.toString());
    //return responseJson;
  } else {
    //throw Exception('Failed to Validate');
    print(response.body);
    return null;
  }
}