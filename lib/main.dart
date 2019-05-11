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
import 'dart:convert';
import 'dart:convert' show utf8;
import 'package:flutter/material.dart';
import 'package:armour_app/visualization2.dart';
import 'package:armour_app/visualization1.dart';
import 'package:armour_app/Model/elastic.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    if(loading==true)
      return Scaffold(
        appBar: AppBar(
          title: const Text('Project Armour'),
        ),
        body: Center(
          child: _selectedIndex == 0 ? Visuals(maleCount,femaleCount) : _selectedIndex == 1
              ? Visualization(caCount,waCount,nyCount)
              : Text("Coming soon..."), //show  graph here
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.insert_emoticon),
              title: Text('Gender'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.language),
              title: Text('Countrty'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart),
              title: Text('Age'),
            ),
          ],
          currentIndex: _selectedIndex,
          //selectedItemColor: Colors.amber[800],
          fixedColor: Colors.cyan,
          onTap: _onItemTapped,
        ),

      );

    else return Container(
        color: Colors.white,
        child: new Center(
            child: CircularProgressIndicator()
        )
    );
  }

  void getData(String text) async{
    var link = 'https://search-project-armour-phbfhe2v26gnfcbxbwa6p2wrva.us-east-2.es.amazonaws.com/users/_search?q='+text;
    Uri apiUri = Uri.parse(link);
    HttpClientRequest request = await new HttpClient().getUrl(apiUri);
    HttpClientResponse response = await request.close();
    Stream resStream = response.transform(utf8.decoder);

    await for (var data in resStream){
       _parseJson(data,text);
    }
  }

  void  _parseJson(String jsonString,String text) {
    Map previewMap = json.decode(jsonString);
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

}
