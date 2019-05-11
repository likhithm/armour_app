import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class Visuals extends StatefulWidget {

  final int maleCount;
  final int femaleCount;

  Visuals(this.maleCount,this.femaleCount);

  @override
  _Visuals createState() => new _Visuals();
}

class _Visuals extends State<Visuals> {

  List<charts.Series> seriesList;
  final bool animate = true;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    seriesList = _createSampleData(widget.maleCount,widget.femaleCount);
    return dataVizBuilder();
  }

  dataVizBuilder() {
    return (
        Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                      height: 200,
                      child: charts.PieChart(seriesList,
                          animate: animate,
                          defaultRenderer: new charts.ArcRendererConfig(
                              arcWidth: 100,
                              arcRendererDecorators: [
                                new charts.ArcLabelDecorator()
                              ]
                          )
                      )
                  ),
                ],
              ),


            ]
        )
    );
  }

  static List<charts.Series<GenderData, String>> _createSampleData(int m,int f) {
    final sent = [
      new GenderData(0, "Male", m),
      new GenderData(1, "Female",f ),

    ];

    return [
      new charts.Series<GenderData, String>(
        id: 'Messages',
        domainFn: (GenderData m, _) => m.type,
        measureFn: (GenderData m, _) => m.total,
        data: sent,
        labelAccessorFn: (GenderData row, _) => '${row.type}: ${row.total}',
        fillColorFn: (messages, color) => charts.Color.fromHex(),
      )
    ];
  }



}

class GenderData {
  final int index;
  final int total;
  final String type;

  GenderData(this.index, this.type, this.total);
}
