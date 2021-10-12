import 'package:flutter/material.dart';
import '../screens/dishes.dart';
import '../widgets/grid_product.dart';
import '../widgets/home_category.dart';
import '../widgets/slider_item.dart';
import '../util/brands.dart';
import '../util/categories.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../services/obtainData.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home>{

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  int _current = 0;


  @override
  Widget build(BuildContext context) {
    readInfoUser();
    super.build(context);
    return Scaffold(

      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Saldo actual: \u0024" + "$balance",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),

              // FlatButton(
              //   child: Text(
              //     "View More",
              //     style: TextStyle(
//            //         fontSize: 22,
//            //         fontWeight: FontWeight.w800,
              //       color: Theme.of(context).accentColor,
              //     ),
              //   ),
              //   onPressed: (){
              //     Navigator.of(context).push(
              //       MaterialPageRoute(
              //         builder: (BuildContext context){
              //           return DishesScreen();
              //         },
              //       ),
              //     );
              //   },
              // ),
              ],
            ),

            SizedBox(height: 10.0),

            //Slider Here

           // CarouselSlider(
           //   height: MediaQuery.of(context).size.height/2.4,
           //   items: map<Widget>(
           //     foods,
           //         (index, i){
           //           Map food = foods[index];
           //       return SliderItem(
           //         img: food['img'],
           //         isFav: false,
           //         name: food['name'],
           //         rating: 5.0,
           //         raters: 23,
           //       );
           //     },
           //   ).toList(),
           //   autoPlay: true,
//         //       enlargeCenterPage: true,
           //   viewportFraction: 1.0,
//         //     aspectRatio: 2.0,
           //   onPageChanged: (index) {
           //     setState(() {
           //       _current = index;
           //     });
           //   },
           // ),
            SizedBox(height: 20.0),

            Text(
              "Categorias",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 10.0),

            Container(
              height: 65.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: categories == null?0:categories.length,
                itemBuilder: (BuildContext context, int index) {
                  Map cat = categories[index];
                  return HomeCategory(
                    iconUrl: cat['iconUrl'],
                    categoryName: cat['categoryName'],
                    id: cat['id'].toString(),
                    //items: cat['items'].toString(),
                    isHome: true,
                  );
                },
              ),
            ),

            SizedBox(height: 20.0),

          //  Row(
          //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //    children: <Widget>[
          //      Text(
          //        "Popular Items",
          //        style: TextStyle(
          //          fontSize: 23,
          //          fontWeight: FontWeight.w800,
          //        ),
          //      ),
          //
          //      FlatButton(
          //        child: Text(
          //          "View More",
          //          style: TextStyle(
//        //              fontSize: 22,
//        //              fontWeight: FontWeight.w800,
          //            color: Theme.of(context).accentColor,
          //          ),
          //        ),
          //        onPressed: (){},
          //      ),
          //    ],
          //  ),
            SizedBox(height: 10.0),

        //  GridView.builder(
        //    shrinkWrap: true,
        //    primary: false,
        //    physics: NeverScrollableScrollPhysics(),
        //    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //      crossAxisCount: 2,
        //      childAspectRatio: MediaQuery.of(context).size.width /
        //          (MediaQuery.of(context).size.height / 1.25),
        //    ),
        //    itemCount: foods == null ? 0 :foods.length,
        //    itemBuilder: (BuildContext context, int index) {
//      //        Food food = Food.fromJson(foods[index]);
        //      Map food = foods[index];
//      //        print(foods);
//      //        print(foods.length);
        //      return GridProduct(
        //        img: food['img'],
        //        isFav: false,
        //        name: food['name'],
        //        rating: 5.0,
        //        raters: 23,
        //      );
        //    },
        //  ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
