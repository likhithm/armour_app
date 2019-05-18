// Flutter code sample for material.BottomNavigationBar.1

// This example shows a [BottomNavigationBar] as it is used within a [Scaffold]
// widget. The [BottomNavigationBar] has three [BottomNavigationBarItem]
// widgets and the [currentIndex] is set to index 0. The selected item is
// amber. The `_onItemTapped` function changes the selected item's index
// and displays a corresponding message in the center of the [Scaffold].
//
// ![A scaffold with a bottom navigation bar containing three bottom navigation
// bar items. The first one is selected.](https://flutter.github.io/assets-for-api-docs/assets/material/bottom_navigation_bar.png)

import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'dart:convert' show utf8;
import 'package:flutter/material.dart';
import 'package:armour_app/visualization2.dart';
import 'package:armour_app/visualization1.dart';
import 'package:armour_app/Model/elastic.dart';
import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  int _selectedIndex = 0;
  int maleCount=0;
  int femaleCount=0;
  int caCount=0;
  int waCount=0;
  int nyCount=0;
  bool loading = false;

  int hits = 0;
  String queryString ='';
  bool search = false;

  int _key = 123;
  bool check = false;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    getData('gender:Female');
    getData('gender:Male');
    getData('state:California');
    getData('state:Washington');
    getData('state:New York');
    //getData('gender:male AND state:california');
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children:[
              Icon(Icons.security),
              Text('Project Armour'),
            ]
          ),
          backgroundColor: Colors.cyan,
        ),
        floatingActionButton:
          new FloatingActionButton(
            onPressed: _tapRefreshData, //open new activity
            backgroundColor: Colors.blue[400],
            mini: false,
            child:
              new Icon(
                Icons.refresh
              ),
          ),
        body:
        NestedScrollView(
          headerSliverBuilder: (context, boxScrolled) => [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              flexibleSpace:
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child:
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: 'Search ( \'field_name : value\' for accurate result )'),
                    onSubmitted: getSearchQuery,
                  )
              ),
              floating: true,
            ),
          ],
          body:
            Center(
              child: _selectedIndex == 0?
                testData()
                :_selectedIndex == 1?
                Text("Coming soon...")
                : Text("Coming soon..."), //show  graph here
            )
        ),
        bottomNavigationBar:
          BottomNavigationBar(
            items:
              const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.build),
                  title: Text('Test Data'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.cloud),
                  title: Text('Server Data'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  title: Text('Sales Data'),
                ),
              ],
            currentIndex: _selectedIndex,
            //selectedItemColor: Colors.amber[800],
            fixedColor: Colors.cyan,
            onTap: _onItemTapped,
        ),
      );
  }

  Widget testData(){
    return  ListView(
        children:[
          search?
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Text('Total hits for ' + queryString+' : '+ hits.toString(),
              style: TextStyle(color: Colors.blue[700],fontSize:16))
            ],
          )
          : LimitedBox(),
          Divider(height: 20,color:Colors.transparent),
          ExpansionTile(
            leading: Icon(Icons.insert_chart,color:Colors.cyan),
            initiallyExpanded: check,
            key: Key(_key.toString()),
            title: Text("View Sample Visualizations"),
            children:[
              Visuals(maleCount,femaleCount),
              Divider(height: 20,color:Colors.transparent),
              Visualization(caCount,waCount,nyCount),
            ]
          )
        ]
    );
  }

  _collapse() {
    int newKey;
    do {
      _key = new Random().nextInt(10000);
      check = false;
    } while (newKey == _key);
  }

  /// --------------
  /// Controller Code
  /// ---------------

  void getData(String text) async{
    var dio = Dio();
    dio.transformer = new FlutterTransformer();
    Response response =
    await dio.get('https://search-project-armour-phbfhe2v26gnfcbxbwa6p2wrva.us-east-2.es.amazonaws.com/users/_search?q='+text);
    Map previewMap = json.decode(response.toString());
    Elastic els = Elastic.fromJson(previewMap);
    setState(() {
      if(text=='gender:Female')
        femaleCount = els.hits.total;
      else if(text=='gender:Male')
       maleCount= els.hits.total;
      else if(text=='state:California')
        caCount = els.hits.total;
      else if(text=='state:Washington')
         waCount = els.hits.total;
      else
        nyCount = els.hits.total;

      loading = true;
    });
  }

  void _tapRefreshData(){

    getData('gender:Female');
    getData('gender:Male');
    getData('state:California');
    getData('state:Washington');
    getData('state:New York');
    //getData('gender:male AND state:california');
  }

  getSearchQuery(String text) async {
    setState(() {
      search=false;
    });
    var dio = Dio();
    dio.transformer = new FlutterTransformer();
    Response response =
    await dio.get('https://search-project-armour-phbfhe2v26gnfcbxbwa6p2wrva.us-east-2.es.amazonaws.com/users/_search?q='+text);
    Map previewMap = json.decode(response.toString());
    Elastic els = Elastic.fromJson(previewMap);
    setState(() {
      queryString = text;
      hits = els.hits.total;
      search=true;
    });
  }

}
