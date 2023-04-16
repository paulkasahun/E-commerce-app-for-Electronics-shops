// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:charts_flutter/flutter.dart' as chart;
import 'package:flutter/material.dart';

import 'package:rentapp_v1/models/sales.dart';

class CategoryProductChart extends StatelessWidget {
  final List<chart.Series<Sales, String>> seriesList;
  const CategoryProductChart({
    Key? key,
    required this.seriesList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return chart.BarChart(
      seriesList,
      animate: true,
    );
  }
}
