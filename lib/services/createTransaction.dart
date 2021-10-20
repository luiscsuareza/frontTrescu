import 'package:http/http.dart' as http;
import 'dart:convert';
import '../util/const.dart';
import 'obtainData.dart';

Future<int> createTransaction(
    String amount, String brand, String receiver, String description) async {
  await readInfoUser();

  var bodyRequest = {};

  bodyRequest["amount"] = amount;

  var currencyBody = {};
  currencyBody["id"] = int.parse(currency.replaceAll(".0", ""));
  bodyRequest["currencyId"] = currencyBody;

  var userBody = {};
  userBody["id"] = int.parse(userId.replaceAll(".0", ""));
  bodyRequest["userId"] = userBody;

  var brandBody = {};
  brandBody["id"] = int.parse(brand.replaceAll(".0", ""));
  bodyRequest["brandId"] = brandBody;

  var receiverBody = {};
  receiverBody["id"] = int.parse(receiver.replaceAll(".0", ""));
  bodyRequest["receiverId"] = receiverBody;

  bodyRequest["description"] = description;

  //print(bodyRequest);

  final http.Response response = await http.post(
    Uri.parse(Constants.hostBackend + "/Trescubos/api/transactions"),
    headers: <String, String>{
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
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
    },
    body: jsonEncode(bodyRequest),
  );

  if (response.statusCode == 200) {
    //Aca que hacemos en caso de tener 200 la validacion es exitosa y continuamos
    //var responseJson = json.decode(response.body)[0]["id"];
    final responseJson = json.decode(response.statusCode.toString());
    //brandsList = responseJson;
    //print("Json de respuesta de tx: " + responseJson.toString());
    return responseJson;

  } else {

    print(response.body);
    throw Exception('Failed to create');
    return null;
  }
}
