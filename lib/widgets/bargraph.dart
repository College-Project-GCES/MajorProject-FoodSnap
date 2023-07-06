import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CustomBarGraph extends StatelessWidget {
  final List<Nutrient> nutrients;
  final List<Color> barColors;

  const CustomBarGraph({
    required this.nutrients,
    required this.barColors,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final seriesList = _createSeriesList(nutrients, barColors);

    return Center(
      child: SizedBox(
        height: 300,
        width: 350,
        child: charts.BarChart(
          seriesList,
          domainAxis: const charts.OrdinalAxisSpec(
              renderSpec: charts.SmallTickRendererSpec(
            labelRotation: 0,
            labelStyle: charts.TextStyleSpec(
                //2 style of label
                fontSize: 16),
          )),
        ),
      ),
    );
  }

  List<charts.Series<Nutrient, String>> _createSeriesList(
    List<Nutrient> nutrients,
    List<Color> barColors,
  ) {
    return [
      charts.Series<Nutrient, String>(
        id: 'Nutrients',
        data: nutrients,
        domainFn: (Nutrient nutrient, _) => nutrient.name,
        measureFn: (Nutrient nutrient, _) => nutrient.value,
        colorFn: (Nutrient nutrient, _) {
          final index = nutrients.indexOf(nutrient) % barColors.length;
          return charts.ColorUtil.fromDartColor(barColors[index]);
        },
        labelAccessorFn: (Nutrient nutrient, _) =>
            '${nutrient.name}: ${nutrient.value}%',
      ),
    ];
  }
}

class Nutrient {
  final String name;
  final int value;

  Nutrient(this.name, this.value);
}
