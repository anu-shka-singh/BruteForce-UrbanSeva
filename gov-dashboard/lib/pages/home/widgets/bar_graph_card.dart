import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/responsive.dart';
import 'package:flutter_dashboard/model/bar_graph_model.dart';
import 'package:flutter_dashboard/model/graph_model.dart';
import 'package:flutter_dashboard/widgets/custom_card.dart';

class BarGraphCard extends StatelessWidget {
  BarGraphCard({super.key});

  final List<BarGraphModel> data = [
    BarGraphModel(
      lable: "Resolution Level",
      color: const Color(0xFFFEB95A),
      graph: [
        GraphModel(x: 0, y: 20),
        GraphModel(x: 1, y: 50),
        GraphModel(x: 2, y: 30),
      ],
    ),
  ];

  final lable = ['Resolved', 'Ongoing', 'Not Started'];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: data.length,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Responsive.isMobile(context) ? 1 : 3,
        crossAxisSpacing: !Responsive.isMobile(context) ? 15 : 12,
        mainAxisSpacing: 12.0,
        childAspectRatio: Responsive.isMobile(context) ? 16 / 9 : 5 / 4,
      ),
      itemBuilder: (context, i) {
        return CustomCard(
          color: Colors.white,
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  data[i].lable,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 130, // Set your desired height
                width: 700, // Set your desired width
                child: BarChart(
                  BarChartData(
                    barGroups: _chartGroups(
                      points: data[i].graph,
                      color: data[i].color,
                    ),
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.blueAccent,
                      ),
                    ),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                lable[value.toInt()],
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: false,
                      // border: Border(
                      //   bottom: BorderSide(
                      //     width: 2,  // Adjust the border width
                      //   ),
                      //   left: BorderSide(
                      //     width: 2,  // Adjust the border width
                      //   ),
                      // ),
                    ),
                    gridData: FlGridData(show: false),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<BarChartGroupData> _chartGroups(
      {required List<GraphModel> points, required Color color}) {
    return points
        .map((point) => BarChartGroupData(x: point.x.toInt(), barRods: [
              BarChartRodData(
                toY: point.y,
                width: 30,
                color: color.withOpacity(point.y.toInt() > 4 ? 1 : 0.4),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(3.0),
                  topRight: Radius.circular(3.0),
                ),
              )
            ]))
        .toList();
  }
}
