import '../util/const.dart';
import 'package:intl/intl.dart';

List<Map> infoServices = [];
NumberFormat f = new NumberFormat("#,##0.00", "es_AR");
String balance;
String userId;
String userName;
String password;
String category;
String currency;
String receiver;

Future<void> readInfoUser() async {
  await Constants()
      .validateBalance()
      .then((value) => {balance = f.format(value).toString()});
  await Constants().validateUser().then((value) => userId = value.toString());
  await Constants()
      .validateUsername()
      .then((value) => userName = value.toString());
  await Constants()
      .validatePassword()
      .then((value) => password = value.toString());
  await Constants()
      .validateCategory()
      .then((value) => category = value.toString());
  await Constants()
      .validateCurrency()
      .then((value) => currency = value.toString());
  await Constants()
      .validateReceiver()
      .then((value) => receiver = value.toString());
  //return _balance;
}
