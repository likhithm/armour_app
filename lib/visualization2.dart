import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

//Main method for all Flutter Applications

class Visualization extends StatelessWidget {

  final int caCount;
  final int waCount;
  final int nyCount;

  Visualization(this.caCount,this.waCount,this.nyCount);

  @override
  Widget build(BuildContext context) {
    {
      return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 250,
                child:
                charts.BarChart(
                  _createVisualizationData(caCount,waCount,nyCount),
                  animate: true,
                  behaviors: [
                    /*charts.ChartTitle('No. of People vs State',
                      titleStyleSpec: charts.TextStyleSpec(fontSize: 15,color: charts.MaterialPalette.black)
                    ),*/
                    charts.ChartTitle('No. of People',
                      behaviorPosition: charts.BehaviorPosition.start,
                      titleStyleSpec: charts.TextStyleSpec(fontSize: 15,color: charts.MaterialPalette.gray.shadeDefault),
                    ),
                    charts.ChartTitle('State',
                      behaviorPosition: charts.BehaviorPosition.bottom,
                      titleStyleSpec:charts.TextStyleSpec(fontSize: 16,color: charts.MaterialPalette.gray.shadeDefault)
                    )
                  ],
                ),
              )
            ],
          ),
      );
    }
  }

  static List<charts.Series<Foo, String>>
  _createVisualizationData(int ca, int wa,int ny) {
    final data = [
      Foo("CA", ca),
      Foo("WA", wa),
      Foo("NY", ny),

    ];
    return [
      charts.Series<Foo, String>(
          id: 'No. of People vs State',
          colorFn: (Foo dataPoint, __) => dataPoint.state=="CA"?
            charts.MaterialPalette.teal.shadeDefault:dataPoint.state=="WA"?
            charts.MaterialPalette.indigo.shadeDefault:charts.MaterialPalette.lime.shadeDefault,
          domainFn: (Foo dataPoint, _) =>
          dataPoint.state,
          measureFn: (Foo dataPoint, _) =>
          dataPoint.numberOfPeople,
          data: data)
    ];
  }
}

class Foo {
  final String state;
  final int numberOfPeople;

  Foo(this.state, this.numberOfPeople);
}