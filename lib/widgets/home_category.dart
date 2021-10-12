import 'package:flutter/material.dart';
import '../screens/categories_screen.dart';
import '../services/obtainBrands.dart';
import '../services/obtainData.dart';
import '../util/const.dart';

class HomeCategory extends StatefulWidget {
  final String iconUrl;
  final String categoryName;
  final String id;
  //final String items;
  final Function tap;
  final bool isHome;

  HomeCategory(
      {Key key,
      @required this.iconUrl,
      @required this.categoryName,
      @required this.id,
      //@required this.items,
      this.tap,
      this.isHome})
      : super(key: key);

  @override
  _HomeCategoryState createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isHome
          ? () {
              setState(() {
                //print("Categoria clickeada: " + widget.id);
                Constants().setCategory(widget.id);
                readInfoUser();
                getBrands();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return CategoriesScreen();
                    },
                  ),
                );
              });
            }
          : widget.tap,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 4.0,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 0.0, right: 10.0),
                child: Image.network(
                  widget.iconUrl,
                  color: Theme.of(context).accentColor,
                ),
              ),
              SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 10.0),
                  Text(
                    "${widget.categoryName}",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 17,
                    ),
                  ),

                  //Text(
                  //  "${widget.items} Items",
                  //  style: TextStyle(
                  //    fontWeight: FontWeight.w400,
                  //    fontSize: 10,
                  //  ),
                  //),
                  SizedBox(height: 5),
                ],
              ),
              SizedBox(width: 5),
            ],
          ),
        ),
      ),
    );
  }
}
