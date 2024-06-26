import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CurvedLineChart extends StatefulWidget {
  const CurvedLineChart({super.key});

  @override
  State<StatefulWidget> createState() => CurvedLineChartState();
}

class CurvedLineChartState extends State<CurvedLineChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<FlSpot> _getAnimatedSpots(List<FlSpot> spots) {
    return spots
        .map((spot) => FlSpot(spot.x, spot.y * _animation.value))
        .toList();
  }

  void _restartAnimation() {
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: _restartAnimation,
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Monthly Incomes',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 16,
                left: 6,
              ),
              child: LineChart(
                LineChartData(
                  lineTouchData: lineTouchData1,
                  gridData: gridData,
                  titlesData: titlesData1,
                  borderData: borderData,
                  lineBarsData: lineBarsData1,
                  minX: 0,
                  maxX: 14,
                  maxY: 4,
                  minY: 0,
                ),
                duration: const Duration(milliseconds: 250),
              ),
            ),
          ),
        ],
      ),
    );
  }

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        LineChartBarData(
          spots: _getAnimatedSpots(const [
            FlSpot(1, 1),
            FlSpot(3, 1.5),
            FlSpot(5, 1.4),
            FlSpot(7, 3.4),
            FlSpot(10, 2),
            FlSpot(12, 2.2),
            FlSpot(13, 1.8),
          ]),
          isCurved: true,
          color: Colors.lightBlueAccent.withOpacity(_animation.value),
          barWidth: 10 * _animation.value,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
        ),
        LineChartBarData(
          spots: _getAnimatedSpots(const [
            FlSpot(1, 1),
            FlSpot(3, 2.8),
            FlSpot(7, 1.2),
            FlSpot(10, 2.8),
            FlSpot(12, 2.6),
            FlSpot(13, 3.9),
          ]),
          isCurved: true,
          color: Colors.pink.withOpacity(_animation.value),
          barWidth: 10 * _animation.value,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
        ),
        LineChartBarData(
          spots: _getAnimatedSpots(const [
            FlSpot(1, 2.8),
            FlSpot(3, 1.9),
            FlSpot(6, 3),
            FlSpot(10, 1.3),
            FlSpot(13, 2.5),
          ]),
          isCurved: true,
          color: Colors.green.withOpacity(_animation.value),
          barWidth: 10 * _animation.value,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
        ),
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
      color: Colors.white,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1m';
        break;
      case 2:
        text = '2m';
        break;
      case 3:
        text = '3m';
        break;
      case 4:
        text = '4m';
        break;
      case 5:
        text = '5m';
        break;
      default:
        return Container();
    }
    return Text(
      text,
      style: style,
      textAlign: TextAlign.center,
    );
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Colors.white,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('SEPT', style: style);
        break;
      case 7:
        text = const Text('OCT', style: style);
        break;
      case 12:
        text = const Text('DEC', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.2), width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );
}
