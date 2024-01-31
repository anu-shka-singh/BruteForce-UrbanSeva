import 'package:flutter/material.dart';
import 'package:flutter_dashboard/pages/home/widgets/header_widget.dart';
import 'package:flutter_dashboard/pages/home/widgets/map.dart';
import 'package:flutter_dashboard/responsive.dart';
import 'package:flutter_dashboard/pages/home/widgets/bar_graph_card.dart';
import 'package:flutter_dashboard/pages/home/widgets/line_chart_card.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const HomePage({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    SizedBox height(BuildContext context) => SizedBox(
          height: Responsive.isDesktop(context) ? 30 : 20,
        );

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Responsive.isMobile(context) ? 15 : 18),
          child: Column(
            children: [
              SizedBox(
                height: Responsive.isMobile(context) ? 5 : 18,
              ),
              Header(scaffoldKey: scaffoldKey),
              height(context),
              const ProblemMap(),
              height(context),
              LineChartCard(),
              height(context),
              BarGraphCard(),
              height(context),
            ],
          ),
        ),
      ),
    );
  }
}
