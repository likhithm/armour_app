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
                    charts.ChartTitle('Number of People v/s State(US)'),
                    charts.ChartTitle('Number of People',
                        behaviorPosition: charts.BehaviorPosition.start),
                    charts.ChartTitle('State',
                        behaviorPosition: charts.BehaviorPosition.bottom)
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
          id: 'Number of People v/s State(US)',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
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