import 'package:flutter/material.dart';
import '../screens/notifications.dart';
import '../services/obtainBrands.dart';
import '../util/categories.dart';
//import '../util/brands.dart';
import '../util/const.dart';
import '../widgets/badge.dart';
import '../widgets/grid_product.dart';
import '../widgets/home_category.dart';
import '../services/obtainBrandCategories.dart';
import '../services/obtainData.dart';
import '../services/obtainBrands.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String catie = "";
  @override
  Widget build(BuildContext context) {
    readInfoUser();
    //print("Id de categoria seleccionada: " + category);
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
        title: Text(
          "Categorias",
        ),
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
            Container(
              height: 65.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: categories == null ? 0 : categories.length,
                itemBuilder: (BuildContext context, int index) {
                  Map cat = categories[index];
                  return HomeCategory(
                    iconUrl: cat['iconUrl'],
                    categoryName: cat['categoryName'],
                    id: cat['id'].toString(),
                    //items: cat['items'].toString(),
                    isHome: false,
                    tap: () {
                      setState(() {
                        catie = "${cat['categoryName']}";
                        //print("Categoria con click: " + "${cat['id']}");
                        Constants().setCategory("${cat['id']}");
                        readInfoUser();
                        getBrands();
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "$catie",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
            Divider(),
            SizedBox(height: 10.0),
            GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.25),
              ),
              itemCount: brandsList == null ? 0 : brandsList.length,
              itemBuilder: (BuildContext context, int index) {
                Map brand = brandsList[index];
                return GridProduct(
                  index: index,
                  iconUrl: brand['iconUrl'],
                  // isFav: false,
                  brandName: brand['brandName'],
                  id: brand['id'].toString(),
                  flagType: brand['flagType'],
                  // rating: 5.0,
                  // raters: 23,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
