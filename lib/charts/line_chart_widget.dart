import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({
    super.key,
  });

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget>
    with SingleTickerProviderStateMixin {
  bool showGrid = true;
  bool showDots = false;
  bool showTitles = true;
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

  List<FlSpot> _getAnimatedSpots() {
    List<FlSpot> spots = const [
      FlSpot(0, 1),
      FlSpot(1, 3),
      FlSpot(2, 10),
      FlSpot(3, 7),
      FlSpot(4, 12),
      FlSpot(5, 13),
      FlSpot(6, 17),
    ];
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
    return Column(
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
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: showTitles ? 250 : 235,
          width: 330,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: showGrid,
                drawHorizontalLine: true,
                drawVerticalLine: true,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.grey.withOpacity(0.5),
                    strokeWidth: 1,
                  );
                },
                getDrawingVerticalLine: (value) {
                  return FlLine(
                    color: Colors.grey.withOpacity(0.5),
                    strokeWidth: 1,
                  );
                },
              ),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: showTitles,
                    reservedSize: 40,
                    interval: 5,
                    getTitlesWidget: (value, meta) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: showTitles,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          'Day ${value.toInt()}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border(
                  left: BorderSide(
                    color: Colors.grey.withOpacity(1),
                  ),
                  bottom: BorderSide(
                    color: Colors.grey.withOpacity(1),
                  ),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: _getAnimatedSpots(),
                  isCurved: true,
                  color: Colors.lightBlueAccent.withOpacity(_animation.value),
                  barWidth: 4 * _animation.value,
                  isStrokeCapRound: true,
                  belowBarData: BarAreaData(
                    show: true,
                    color: Colors.lightBlueAccent
                        .withOpacity(0.3 * _animation.value),
                  ),
                  dotData: FlDotData(
                    show: showDots,
                    checkToShowDot: (spot, barData) {
                      return true;
                    },
                    getDotPainter: (spot, percent, barData, index) {
                      return FlDotCirclePainter(
                        radius: 4,
                        color: Colors.lightBlueAccent,
                        strokeWidth: 2,
                        strokeColor: Colors.blueGrey[900]!,
                      );
                    },
                  ),
                ),
              ],
              backgroundColor: Colors.blueGrey[800],
              lineTouchData: LineTouchData(
                touchTooltipData: const LineTouchTooltipData(
                    // tooltipBgColor: Colors.blueAccent,
                    ),
                touchCallback:
                    (FlTouchEvent event, LineTouchResponse? touchResponse) {
                  setState(() {});
                },
                handleBuiltInTouches: true,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          alignment: WrapAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showGrid = !showGrid;
                });
              },
              child: Text(showGrid ? 'Ocultar Grid' : 'Mostrar Grid'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showDots = !showDots;
                });
              },
              child: Text(showDots ? 'Ocultar Pontos' : 'Mostrar Pontos'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showTitles = !showTitles;
                });
              },
              child: Text(showTitles ? 'Ocultar Legendas' : 'Mostrar Legendas'),
            ),
          ],
        ),
      ],
    );
  }
}
