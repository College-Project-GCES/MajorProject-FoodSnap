import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class NutritionPage extends StatefulWidget {
  const NutritionPage({super.key});

  @override
  State<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: const Text('Nutrition Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(Icons.arrow_back),
                  SizedBox(width: 8.0),
                  Text('Page Title'),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: const [
                  Text('Text 1: '),
                  Text('Numeric Value 1'),
                ],
              ),
              const SizedBox(height: 16.0),
              charts.PieChart(
                _createSampleData(),
                animate: true,
                defaultRenderer: charts.ArcRendererConfig(
                  arcWidth: 60,
                  arcRendererDecorators: [
                    charts.ArcLabelDecorator(
                      labelPosition: charts.ArcLabelPosition.inside,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Detailed Nutrition',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(1),
                },
                children: const [
                  TableRow(
                    children: [
                      TableCell(
                        child: Text('Carbohydrate'),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text('Fat'),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text('Protein'),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text('Serving per gm'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Diabetic Recommend',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              const LinearProgressIndicator(
                value: 0.75, // Replace with the actual value
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                backgroundColor: Colors.red,
              ),
              const SizedBox(height: 16.0),
              const Text('Explanation'),
              const SizedBox(height: 16.0),
              const Text('Reason to Avoid Food'),
            ],
          ),
        ),
      ),
    );
  }

  List<charts.Series<ChartData, String>> _createSampleData() {
    final data = [
      ChartData('Carbohydrate', 40),
      ChartData('Fat', 30),
      ChartData('Protein', 30),
    ];

    return [
      charts.Series<ChartData, String>(
        id: 'Nutrients',
        domainFn: (ChartData nutrient, _) => nutrient.nutrientName,
        measureFn: (ChartData nutrient, _) => nutrient.value,
        labelAccessorFn: (ChartData nutrient, _) =>
            '${nutrient.nutrientName}: ${nutrient.value}%',
        data: data,
        colorFn: (_, index) {
          switch (index) {
            case 0:
              return charts.MaterialPalette.blue.shadeDefault;
            case 1:
              return charts.MaterialPalette.red.shadeDefault;
            case 2:
              return charts.MaterialPalette.green.shadeDefault;
            default:
              return charts.MaterialPalette.gray.shadeDefault;
          }
        },
      ),
    ];
  }
}

class ChartData {
  final String nutrientName;
  final int value;

  ChartData(this.nutrientName, this.value);
}
