import 'dart:convert';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../screens/notifications.dart';
import '../services/obtainData.dart';
import '../util/comments.dart';
import '../util/const.dart';
//import '../util/brands.dart';
import '../widgets/badge.dart';
import '../widgets/smooth_star_rating.dart';
import '../services/obtainBrands.dart';
import '../services/createReceiver.dart';
import '../services/createTransaction.dart';

class ProductDetails extends StatefulWidget {
  final int index;
  ProductDetails({Key key, @required this.index});
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFav = false;
  final TextEditingController _fullNameControl = new TextEditingController();
  final TextEditingController _phoneNameControl = new TextEditingController();
  final TextEditingController _emailNameControl = new TextEditingController();
  final TextEditingController _messageControl = new TextEditingController();
  var dropdownValue;
  List<String> values = [];
  var dateTimeValue;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    if ("${brandsList[widget.index]['flagType']}" == "FIXED") {
      values = "${brandsList[widget.index]['values']}".split(",");
      //print("Camino: true");
    } else {
      int start =
          int.parse("${brandsList[widget.index]['values']}".split(",")[0]);
      int pivot =
          int.parse("${brandsList[widget.index]['values']}".split(",")[1]);
      int end =
          int.parse("${brandsList[widget.index]['values']}".split(",")[2]);
      //print("Inicio: "+start.toString()+" pivote: "+pivot.toString()+" final: "+end.toString());
      for (var i = start; i <= end; i = i + pivot) {
        values.add(i.toString());
        //print("Valor agregado: " + i.toString());
      }
      //print("Camino: false");
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        // title: Text(
        //   "Item Details",
        // ),
        elevation: 0.0,
        //actions: <Widget>[
        //  IconButton(
        //    icon: IconBadge(
        //      icon: Icons.notifications,
        //      size: 22.0,
        //    ),
        //    onPressed: (){
        //      Navigator.of(context).push(
        //        MaterialPageRoute(
        //          builder: (BuildContext context){
        //            return Notifications();
        //          },
        //        ),
        //      );
        //    },
        //  ),
        //],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3.2,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      "${brandsList[widget.index]['iconUrl']}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                //Positioned(
                //  right: -10.0,
                //  bottom: 3.0,
                //  child: RawMaterialButton(
                //    onPressed: (){},
                //    fillColor: Colors.white,
                //    shape: CircleBorder(),
                //    elevation: 4.0,
                //    child: Padding(
                //      padding: EdgeInsets.all(5),
                //      child: Icon(
                //        isFav
                //            ?Icons.favorite
                //),
              ],
            ),

            SizedBox(height: 10.0),

            Text(
              "${brandsList[widget.index]['brandName']}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),

            //Padding(
            //  padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
            //  child: Row(
            //    children: <Widget>[
            //      SmoothStarRating(
            //        starCount: 5,
            //        color: Constants.ratingBG,
            //        allowHalfRating: true,
            //        rating: 5.0,
            //        size: 10.0,
            //      ),
            //      SizedBox(width: 10.0),
            //
            //      Text(
            //        "5.0 (23 Reviews)",
            //        style: TextStyle(
            //          fontSize: 11.0,
            //        ),
            //      ),
            //
            //    ],
            //  ),
            //),

            Padding(
              padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
              child: Row(
                children: <Widget>[
                  //  Text(
                  //    "20 Pieces",
                  //    style: TextStyle(
                  //      fontSize: 11.0,
                  //      fontWeight: FontWeight.w300,
                  //    ),
                  //  ),
                  SizedBox(width: 10.0),

                  Text(
                    "Valores:",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),

            Card(
              elevation: 3.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepOrange),
                  underline: Container(
                    height: 2,
                    color: Colors.deepOrange,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  //items: <String>['One', 'Two', 'Free', 'Four']
                  items: values.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),

            SizedBox(height: 20.0),

            Text(
              "Descripcion",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),

            SizedBox(height: 10.0),

            Text(
              "${brandsList[widget.index]['description']}",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),

            SizedBox(height: 20.0),

            // Text(
            //   "Reviews",
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.w800,
            //   ),
            //   maxLines: 2,
            // ),
            SizedBox(height: 20.0),

            //  ListView.builder(
            //    shrinkWrap: true,
            //    primary: false,
            //    physics: NeverScrollableScrollPhysics(),
            //    itemCount: comments == null?0:comments.length,
            //    itemBuilder: (BuildContext context, int index) {
            //      Map comment = comments[index];
            //      return ListTile(
            //          leading: CircleAvatar(
            //            radius: 25.0,
            //            backgroundImage: AssetImage(
            //              "${comment['img']}",
            //            ),
            //          ),
            //
            //          title: Text("${comment['name']}"),
            //          subtitle: Column(
            //            children: <Widget>[
            //              Row(
            //                children: <Widget>[
            //                  SmoothStarRating(
            //                    starCount: 5,
            //                    color: Constants.ratingBG,
            //                    allowHalfRating: true,
            //                    rating: 5.0,
            //                    size: 12.0,
            //                  ),
            //                  SizedBox(width: 6.0),
            //                  Text(
            //                    "February 14, 2020",
            //                    style: TextStyle(
            //                      fontSize: 12,
            //                      fontWeight: FontWeight.w300,
            //                    ),
            //                  ),
            //                ],
            //              ),
            //
            //              SizedBox(height: 7.0),
            //              Text(
            //                "${comment["comment"]}",
            //              ),
            //            ],
            //          ),
            //      );
            //    },
            //  ),

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
                    hintText: "Nombre destinatario",
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
                  controller: _fullNameControl,
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
                    hintText: "Celular destinatario",
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                  ),
                  maxLines: 1,
                  controller: _phoneNameControl,
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
                    hintText: "Email destinatario",
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                  ),
                  maxLines: 1,
                  controller: _emailNameControl,
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
                    hintText: "Mensaje personalizado",
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                    prefixIcon: Icon(
                      Icons.message,
                      color: Colors.black,
                    ),
                  ),
                  maxLines: 1,
                  controller: _messageControl,
                ),
              ),
            ),

            SizedBox(height: 10.0),

            CheckboxListTile(
              title: Text(
                "Programar Entrega:",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).accentColor,
                ),
              ),
              checkColor: Colors.white,
              value: isChecked,
              onChanged: (bool value) {
                setState(() {
                  isChecked = value;
                });
              },
            ),

            SizedBox(height: 10.0),

            if (isChecked)
              Card(
                elevation: 3.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: DateTimePicker(
                    calendarTitle: 'Programar en:',
                    type: DateTimePickerType.dateTime,
                    //yyyy-MM-dd'T'HH:mm:ss.SSSZ
                    dateMask: 'yyyy-MM-dd HH:00',
                    initialValue:
                        DateTime.now().add(const Duration(days: 1)).toString(),
                    firstDate: DateTime.now().add(const Duration(days: 1)),
                    lastDate: DateTime(2100),
                    icon: Icon(Icons.event),
                    dateLabelText: 'Fecha',
                    timeLabelText: 'Hora',
                    onChanged: (val) => {
                      if (DateTime.parse(val).hour > 8 &&
                          DateTime.parse(val).hour < 21)
                        {
                          dateTimeValue = DateTime.parse(val),
                          //print(DateTime.parse(val)),
                        }
                      else
                        {
                          dateTimeValue =
                              DateTime.now().add(const Duration(days: 1)),
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Hora Invalida'),
                              content: const Text(
                                  'Debe seleccionar entre 8 AM y 9 PM'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          )
                        },
                    },
                    validator: (val) {
                      if (DateTime.parse(val).hour > 8 &&
                          DateTime.parse(val).hour < 21) {
                        dateTimeValue = DateTime.parse(val);
                        //print(DateTime.parse(val)),
                      } else {
                        dateTimeValue =
                            DateTime.now().add(const Duration(days: 1));
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Hora Invalida'),
                            content: const Text(
                                'Debe seleccionar entre 8 AM y 9 PM'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                      ;
                      return null;
                    },
                    onSaved: (val) => print(val),
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50.0,
        child: RaisedButton(
          child: Text(
            "Enviar",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          color: Theme.of(context).accentColor,
          onPressed: () async {
            if (int.parse(balance.replaceAll(",00", "").replaceAll(".", "")) >=
                int.parse(dropdownValue)) {
              await createReceiver(
                  dateTimeValue,
                  _emailNameControl.text,
                  _fullNameControl.text,
                  _messageControl.text,
                  _phoneNameControl.text,
                  isChecked);
              await readInfoUser();
              //print("=======Respuesta de tx http=======");
              if (await createTransaction(
                      "-" + dropdownValue.toString(),
                      "${brandsList[widget.index]['id']}",
                      receiver,
                      "Compra en " +
                          "${brandsList[widget.index]['brandName']}") ==
                  200) {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Transaccion exitosa'),
                    content: const Text('Hemos registrado tu compra'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              } else {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Transaccion fallida'),
                    content: const Text('Ups lo sentimos, algo fallo'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }
              ;
            } else {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Lo sentimo'),
                  content: const Text('El monto excede tu saldo'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
