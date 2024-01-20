import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/responsive.dart';

import '../pages/roadissue.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(Responsive.isMobile(context) ? 10 : 30.0),
          topLeft: Radius.circular(Responsive.isMobile(context) ? 10 : 30.0),
        ),
        color: Colors.grey.shade100,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // Pie Chart
              const SizedBox(height: 40.0),
              const Text(
                "Reported Issues",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const PieChartWidget(),
              ),

              // SizedBox
              const SizedBox(height: 20.0),

              // Four Tiles
              const Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProfileTile(
                      icon: Icons.directions_car,
                      title: "Roads and Transportation"),
                  ProfileTile(icon: Icons.opacity, title: "Water and Sewer"),
                  ProfileTile(
                      icon: Icons.power, title: "Electricity and Power"),
                  ProfileTile(icon: Icons.delete, title: "Sanitation"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> sections = [
      PieChartSectionData(
        title: 'Roads and Transportation',
        value: 15,
        color: Colors.orange,
        showTitle: false,
      ),
      PieChartSectionData(
        title: 'Water and Sewer',
        value: 30,
        color: Colors.blue,
        showTitle: false,
      ),
      PieChartSectionData(
        title: 'Electricity and Power',
        value: 10,
        color: Colors.green,
        showTitle: false,
      ),
      PieChartSectionData(
        title: 'Sanitation',
        value: 25,
        color: Colors.red,
        showTitle: false,
      ),
    ];

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sections: sections,
              sectionsSpace: 6,
              centerSpaceRadius: 40,
              // showBorder: false, // Hide the border
              // chartType: ChartType.disc, // Use "disc" chart type to hide labels
            ),
          ),
        ),
        Column(
          children: [
            for (var section in sections)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8), // Add padding
                child: LegendTile(
                  color: section.color,
                  value: section.title.toString(),
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class LegendTile extends StatelessWidget {
  final Color color;
  final String value;

  const LegendTile({super.key, required this.color, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(value,
            style:
                const TextStyle(fontSize: 16)), // Show value instead of title
      ],
    );
  }
}

class _Segment {
  final String title;
  final int value;

  _Segment(this.title, this.value);
}


class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const ProfileTile({required this.icon, required this.title, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => RoadTransportationPage())); // Navigate to the issue page
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16), // Add padding
        child: Row(
          children: [
            Icon(icon, size: 36, color: Colors.blueGrey),
            const SizedBox(width: 16), // Add spacing between the icon and text
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


