import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MultiLineChartWidget extends StatefulWidget {
  const MultiLineChartWidget({super.key});

  @override
  State<MultiLineChartWidget> createState() => _MultiLineChartWidgetState();
}

class _MultiLineChartWidgetState extends State<MultiLineChartWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
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
        .map((spot) => FlSpot(spot.x, spot.y * _opacityAnimation.value))
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
        Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: SizedBox(
              height: 300,
              width: 350,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: _getAnimatedSpots([
                        const FlSpot(0, 1),
                        const FlSpot(1, 3),
                        const FlSpot(2, 2),
                        const FlSpot(3, 4),
                        const FlSpot(4, 3),
                      ]),
                      isCurved: true,
                      color: Colors.red,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            Colors.red.withOpacity(0.5),
                            Colors.red.withOpacity(0.0),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    LineChartBarData(
                      spots: _getAnimatedSpots([
                        const FlSpot(0, 2),
                        const FlSpot(1, 2.5),
                        const FlSpot(2, 3),
                        const FlSpot(3, 3.5),
                        const FlSpot(4, 4),
                      ]),
                      isCurved: true,
                      color: Colors.green,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            Colors.green.withOpacity(0.5),
                            Colors.green.withOpacity(0.0),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(),
                    rightTitles: const AxisTitles(),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const style = TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          );
                          String text;
                          switch (value.toInt()) {
                            case 0:
                              text = 'Jan';
                              break;
                            case 1:
                              text = 'Feb';
                              break;
                            case 2:
                              text = 'Mar';
                              break;
                            case 3:
                              text = 'Apr';
                              break;
                            case 4:
                              text = 'May';
                              break;
                            default:
                              text = '';
                              break;
                          }
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space: 4,
                            child: Text(text, style: style),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: const Border(
                      bottom: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                      left: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    verticalInterval: 1,
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: Colors.white.withOpacity(0.2),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  lineTouchData: LineTouchData(
                    enabled: true,
                    getTouchedSpotIndicator: (barData, spotIndexes) {
                      return spotIndexes.map((index) {
                        return TouchedSpotIndicatorData(
                          FlLine(
                            color: barData.color,
                            strokeWidth: 4,
                          ),
                          FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
                              return FlDotCirclePainter(
                                radius: 6,
                                color: Colors.white,
                                strokeWidth: 2,
                                strokeColor: barData.color!,
                              );
                            },
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
