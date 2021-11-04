import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import '../util/const.dart';
import 'obtainData.dart';

Future<void> createReceiver(DateTime dateTime, String email, String fullName,
    String message, String phone, bool checked) async {
  await readInfoUser();
  final http.Response response = await http.post(
    Uri.parse(Constants.hostBackend + "/api/receivers"),
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
    body: jsonEncode(<String, String>{
      //aca toca reemplazar los datos que estan quemados
      if (checked)
        "dateShipping": await DateFormat("yyyy-MM-dd HH:mm:ss.SSS")
            .parse(dateTime.toString()).toString().replaceAll(' ', 'T').replaceAll("000", "000Z"),
      "email": email,
      "fullName": fullName,
      "message": message,
      "phone": phone
    }),
  );

  if (response.statusCode == 200) {
    //Aca que hacemos en caso de tener 200 la validacion es exitosa y continuamos
    final responseJson = json.decode(response.body)["id"];
    await Constants().setReceiver(double.parse(responseJson.toString()));
    await readInfoUser();
    //final responseJson = json.decode(response.body);
    //brandsList = responseJson;
    //print("Json de respuesta de Receiver: "+responseJson.toString());
    //return responseJson;
  } else {
    print(response.body);
    throw Exception('Failed to create');
    return null;
  }
}
