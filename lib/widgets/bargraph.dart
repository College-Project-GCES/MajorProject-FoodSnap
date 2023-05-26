import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CustomBarGraph extends StatefulWidget {
  const CustomBarGraph({super.key});

  @override
  State<CustomBarGraph> createState() => _CustomBarGraphState();
}

class _CustomBarGraphState extends State<CustomBarGraph> {
  final List<charts.Series<Nutrient, String>> seriesList = [
    charts.Series<Nutrient, String>(
      id: 'Nutrients',
      data: [
        Nutrient('Carbohydrates', 30),
        Nutrient('Fat', 20),
        Nutrient('Protein', 50),
      ],
      domainFn: (Nutrient nutrient, _) => nutrient.name,
      measureFn: (Nutrient nutrient, _) => nutrient.value,
      labelAccessorFn: (Nutrient nutrient, _) =>
          '${nutrient.name}: ${nutrient.value}%',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 2.0,
            color: Colors.grey,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 2.0,
            color: Colors.grey,
          ),
        ),
        SizedBox(
          width: 300, // Set the desired width for the bar graph
          height: 200,
          child: charts.BarChart(
            seriesList,
            animate: true,
            vertical: true,
            primaryMeasureAxis: const charts.NumericAxisSpec(
              tickProviderSpec:
                  charts.BasicNumericTickProviderSpec(zeroBound: false),
            ),
          ),
        ),
      ],
    );
  }
}

class Nutrient {
  final String name;
  final int value;

  Nutrient(this.name, this.value);
}
