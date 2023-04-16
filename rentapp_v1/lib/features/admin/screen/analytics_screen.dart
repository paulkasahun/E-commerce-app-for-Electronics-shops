import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentapp_v1/constants/loader.dart';
import 'package:rentapp_v1/features/admin/services/admin_service.dart';
import 'package:rentapp_v1/features/admin/widgets/category_chart.dart';
import 'package:rentapp_v1/models/sales.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminService adminService = AdminService();
  int? totalSales;
  List<Sales>? earnings;
  @override
  void initState() {
    super.initState();
    getearnings();
  }

  void getearnings() async {
    var earningdata = await adminService.getEarnings(context);
    totalSales = earningdata['totalEarnings'];
    earnings = earningdata['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : Column(
            children: [
              Text(
                '$totalSales ETB',
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 250,
                child: CategoryProductChart(
                  seriesList: [
                    Series(
                      id: 'Sales',
                      data: earnings!,
                      domainFn: (Sales sales, _) => sales.label,
                      measureFn: (Sales sales, _) => sales.earning,
                    ),
                  ],
                ),
              )
            ],
          );
  }
}
