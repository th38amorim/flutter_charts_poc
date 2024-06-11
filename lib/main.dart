import 'package:flutter/material.dart';
import 'package:flutter_charts_poc/charts/animated_pie_chart_widget.dart';
import 'package:flutter_charts_poc/charts/bar_chart_widget.dart';
import 'package:flutter_charts_poc/charts/curved_line_chart_widget.dart';
import 'package:flutter_charts_poc/charts/line_chart_widget.dart';
import 'package:flutter_charts_poc/charts/multi_line_chart_widget.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
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
