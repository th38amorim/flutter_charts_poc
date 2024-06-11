import 'package:flutter/material.dart';
import 'package:flutter_charts_poc/presentation/home/charts/animated_pie_chart_widget.dart';
import 'package:flutter_charts_poc/presentation/home/charts/bar_chart_widget.dart';
import 'package:flutter_charts_poc/presentation/home/charts/curved_line_chart_widget.dart';
import 'package:flutter_charts_poc/presentation/home/charts/line_chart_widget.dart';
import 'package:flutter_charts_poc/presentation/home/charts/multi_line_chart_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FL Chart POC Example',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                AnimatedBarChartWidget(),
                Divider(height: 80),
                CurvedLineChart(),
                Divider(height: 80),
                LineChartWidget(),
                Divider(height: 80),
                AnimatedPieChartWidget(),
                Divider(height: 80),
                MultiLineChartWidget(),
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.blueGrey[900],
    );
  }
}
